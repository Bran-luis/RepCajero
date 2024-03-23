
ALTER PROCEDURE TransferirCuenta(
    @CuentaOrigen VARCHAR(25), 
    @CuentaDestino VARCHAR(25), 
    @SaldoTransferencia DECIMAL(12,2)
)
AS
BEGIN
    DECLARE @Intentos INT = 0;
    DECLARE @FechaHora DATETIME = GETDATE();
    DECLARE @TransTipo VARCHAR(3) = 'T';
    DECLARE @Dead INT = 1205;
    DECLARE @Saldo NUMERIC(12,2), @TransNumero INT, @IDCuentaDestino INT;

    WHILE @Intentos < 3
    BEGIN
        SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
        BEGIN TRANSACTION;
        
        BEGIN TRY
            SELECT @Saldo = saldo FROM Cuentas WHERE noCuenta = @CuentaOrigen;
            SELECT @TransNumero = ISNULL(MAX(idTransaccion), 0) + 1 FROM Transacciones;
            SELECT @IDCuentaDestino = c.idCliente 
            FROM Clientes c 
            JOIN Cuentas ct ON ct.idCliente = c.idCliente
            WHERE ct.noCuenta = @CuentaDestino;

            IF @SaldoTransferencia < 0
            BEGIN
                RAISERROR('El valor de la transferencia no puede ser negativo', 16, 1);
                RETURN;
            END

            IF EXISTS(SELECT 1 FROM Transacciones WHERE NumeroCuentaOrigen = @CuentaOrigen AND idTransaccion = @TransNumero)
            BEGIN
                IF @Saldo >= @SaldoTransferencia
                BEGIN
                    UPDATE Transacciones 
                    SET 
                        tipoTransaccion = @TransTipo, 
                        monto = @SaldoTransferencia, 
                        fechaHora = @FechaHora, 
                        NumeroCuentaOrigen = @CuentaOrigen 
                    WHERE 
                        NumeroCuentaOrigen = @CuentaOrigen 
                        AND idTransaccion = @TransNumero;
                    
                    IF EXISTS(SELECT 1 FROM Cuentas WHERE noCuenta = @CuentaDestino AND idCliente = @IDCuentaDestino)
                    BEGIN
                        UPDATE Cuentas 
                        SET saldo = saldo - @SaldoTransferencia 
                        WHERE noCuenta = @CuentaOrigen;
                       
                        UPDATE Cuentas 
                        SET saldo = saldo + @SaldoTransferencia 
                        WHERE noCuenta = @CuentaDestino;
                    END
                    ELSE
                    BEGIN
                        RAISERROR('La cuenta destino no existe', 16, 1);
                        RETURN;
                    END
                END
                ELSE
                BEGIN
                    RAISERROR('Saldo insuficiente en la cuenta origen', 16, 1);
                    RETURN;
                END
            END
            ELSE
            BEGIN
                IF @Saldo >= @SaldoTransferencia
                BEGIN
                    INSERT INTO Transacciones 
                    VALUES (@TransNumero, @SaldoTransferencia, @TransTipo, @FechaHora, @CuentaOrigen, @CuentaDestino);
					SET @TransNumero = @TransNumero + 1;
					INSERT INTO Transacciones 
					VALUES (@TransNumero, @SaldoTransferencia, 'D', @FechaHora, @CuentaDestino, NULL);
                    IF EXISTS(SELECT 1 FROM Cuentas WHERE noCuenta = @CuentaDestino AND idCliente = @IDCuentaDestino)
                    BEGIN
                        UPDATE Cuentas 
                        SET saldo = saldo - @SaldoTransferencia 
                        WHERE noCuenta = @CuentaOrigen;
                        UPDATE Cuentas 
                        SET saldo = saldo + @SaldoTransferencia 
                        WHERE noCuenta = @CuentaDestino;
                    END
                    ELSE
                    BEGIN
                        RAISERROR('La cuenta destino no existe', 16, 1);
                        RETURN;
                    END
                END
                ELSE
                BEGIN
                    RAISERROR('Saldo insuficiente en la cuenta origen', 16, 1);
                    RETURN;
                END
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
