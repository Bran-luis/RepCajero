CREATE PROCEDURE ReporteComprobacionSaldos
(
    @Cuenta VARCHAR(25)
)
AS
BEGIN
    DECLARE @Intentos INT = 0;
    DECLARE @FechaHora DATETIME = GETDATE();
    DECLARE @Dead INT = 1205;
    DECLARE @SaldoActual DECIMAL(12, 2);

    WHILE @Intentos < 3
    BEGIN
        SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
        BEGIN TRANSACTION;

        BEGIN TRY
            -- Obtener el saldo actual de la cuenta
            SELECT @SaldoActual = saldo FROM Cuentas WHERE noCuenta = @Cuenta;

            -- Verificar si existen transacciones para la cuenta
            IF EXISTS(SELECT 1 FROM Transacciones WHERE NumeroCuentaOrigen = @Cuenta)
            BEGIN
                SELECT SUM(monto) AS sumaTipo, tipoTransaccion
                FROM Transacciones 
                WHERE NumeroCuentaOrigen = @Cuenta
                GROUP BY tipoTransaccion;
            END
            ELSE
            BEGIN
                -- No hay transacciones para la cuenta
                RAISERROR('No se encontraron transacciones para la cuenta especificada', 16, 1);
                RETURN;
            END

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
        END CATCH;
    END
END;
