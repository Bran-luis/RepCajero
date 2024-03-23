CREATE PROCEDURE inicioSeccion
    @Cuenta VARCHAR(25),
    @PIN VARCHAR(10)
AS
BEGIN
    DECLARE @Intentos INT = 0;
    DECLARE @Dead INT = 1205;
    
    WHILE @Intentos < 3
    BEGIN
        SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
        BEGIN TRANSACTION;
        BEGIN TRY
            SELECT u.nombreCliente AS nombreUsuario, u.rol, c.noCuenta AS cuenta, c.saldo, u.telefono, u.pin 
            FROM Clientes AS u
            JOIN Cuentas AS c ON c.idCliente = u.idCliente
            WHERE c.noCuenta = @Cuenta AND u.pin = @PIN;
            COMMIT;
            BREAK;
        END TRY
        BEGIN CATCH
            IF ERROR_NUMBER() = @Dead
            BEGIN
                SET @Intentos = @Intentos + 1;
                WAITFOR DELAY '00:00:01';
                SELECT 'Intento numero: ', @Intentos;
                ROLLBACK;
            END
            ELSE
            BEGIN
                DECLARE @NumeroError INT = 50000 + ERROR_NUMBER();
                DECLARE @MensajeError NVARCHAR(4000) = ERROR_MESSAGE();
                ROLLBACK;
                THROW @NumeroError, @MensajeError, 1;
            END
        END CATCH
    END
END;
