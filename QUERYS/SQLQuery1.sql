CREATE PROCEDURE accesAdmin
(
    @UserAdmin VARCHAR(25),
    @Pin VARCHAR(10)
)
AS
BEGIN
    DECLARE @Intentos INT = 0;
    DECLARE @FechaHora DATETIME = GETDATE();
    DECLARE @Dead INT = 1205;

    WHILE @Intentos < 3
    BEGIN
        DECLARE @ROL VARCHAR(25);

        SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
        BEGIN TRANSACTION;
        BEGIN TRY
            SELECT @ROL = rol
            FROM Clientes
            WHERE nombreClientes = @UserAdmin AND pin = @Pin;

            IF (@ROL = 'ADMIN')
            BEGIN
                SELECT nombreCliente AS NombreAdmin, rol
                FROM Usuario
                WHERE nombreCliente = @UserAdmin AND pin = @Pin;
            END
            ELSE
            BEGIN
                RAISERROR('El usuario ingresado no es Administrador', 16, 1);
                RETURN;
            END;

            COMMIT;
            BREAK;
        END TRY
        BEGIN CATCH
            IF ERROR_NUMBER() = @Dead
            BEGIN
                SET @Intentos = @Intentos + 1;
                WAITFOR DELAY '00:00:01';
                SELECT 'Intento número: ', @Intentos;
                ROLLBACK;
            END
            ELSE
            BEGIN
                DECLARE @NumeroError INT = 50000 + ERROR_NUMBER();
                DECLARE @MensajeError NVARCHAR(4000) = ERROR_MESSAGE();
                ROLLBACK;
                THROW @NumeroError, @MensajeError, 1;
            END;
        END CATCH;
    END;
END;
