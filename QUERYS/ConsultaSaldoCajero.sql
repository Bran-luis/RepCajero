CREATE PROCEDURE SaldoCajero
AS
BEGIN
    DECLARE @Intentos INT = 0;
    DECLARE @FechaHora DATETIME = GETDATE();
    DECLARE @Dead INT = 1205;
    
    WHILE @Intentos < 3
    BEGIN
        SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
        BEGIN TRANSACTION;
        BEGIN TRY
            SELECT cantidad, billetesDe100, billetesDe50 FROM Cajero;
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
