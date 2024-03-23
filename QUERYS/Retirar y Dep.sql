CREATE PROCEDURE Movimiento (
    @Cuenta VARCHAR(25),
    @TransTipo VARCHAR(1),
    @TransValor NUMERIC(12,2)
)
AS
BEGIN
    DECLARE @TransFecha DATETIME = GETDATE();
    DECLARE @Intentos INT = 0;
    DECLARE @Dead INT = 1205;
    DECLARE @TransNumero INT;
    DECLARE @Saldo NUMERIC(12,2) = 0;
    DECLARE @Billetes100 INT = 0, @Billetes50 INT = 0;
    DECLARE @TotalDinero INT = @TransValor;
    DECLARE @BillActual100 INT = 0, @BillActual50 INT = 0; 
    DECLARE @IDUsuario INT, @IdRetri INT = 0;
    
    WHILE @Intentos < 3
    BEGIN
        IF @TransTipo <> 'D' AND @TransTipo <> 'R' 
        BEGIN
            RAISERROR('No puede enviar transacciones distintas a D o R', 16, 1);
            RETURN;
        END
        
        SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
        BEGIN TRANSACTION;
        
        BEGIN TRY
            SELECT @Saldo = saldo FROM Cuentas WHERE noCuenta = @Cuenta;
            SELECT @TransNumero = ISNULL((SELECT MAX(idTransaccion) + 1 FROM Transacciones), 1);
            SELECT @IdRetri = MAX(id) + 1 FROM RegistroCajero;
			
            SELECT @BillActual100 = billetesDe100, @BillActual50 = billetesDe50 FROM Cajero WHERE id = 1;
            IF @TransValor < 0
            BEGIN
                RAISERROR('El valor de la transacción no puede ser negativo', 16, 1);
                RETURN;
            END
            
            IF EXISTS(SELECT 1 FROM Transacciones WHERE NumeroCuentaOrigen = @Cuenta AND idTransaccion = @TransNumero)
            BEGIN
                UPDATE Transacciones SET tipoTransaccion = @TransTipo, monto = @TransValor, fechaHora = @TransFecha WHERE NumeroCuentaOrigen = @Cuenta AND idTransaccion = @TransNumero;

                -- Actualizar el cajero solo si hay suficientes billetes disponibles
                IF @TransTipo = 'R' AND @Saldo >= @TransValor 
                BEGIN
                    WHILE @TotalDinero > 0
                    BEGIN
                        IF @TotalDinero >= 100 AND @Billetes100 < @BillActual100
                        BEGIN
                            SET @Billetes100 = @Billetes100 + 1;
                            SET @TotalDinero -= 100;
                        END
                        ELSE IF @TotalDinero >= 50 AND @Billetes50 <= @BillActual50
                        BEGIN
                            SET @Billetes50 = @Billetes50 + 1;
                            SET @TotalDinero -= 50;
                        END
                        ELSE
                        BEGIN
                            RAISERROR('No se puede retirar esta cantidad, tiene que ser dentro de billetes de 100 y 50', 16, 1);
                            RETURN;
                        END
                    END
                    
                    IF EXISTS(SELECT 1 FROM Cajero WHERE billetesDe100 >= @Billetes100 AND billetesDe50 >= @Billetes50)
                    BEGIN
                        UPDATE Cuentas SET saldo = saldo - @TransValor WHERE noCuenta = @Cuenta;
                        
                        -- Actualizar el cajero
                        UPDATE Cajero SET 
                            cantidad = cantidad - ((@Billetes100 * 100) + (@Billetes50 * 50)),
                            billetesDe100 = billetesDe100 - @Billetes100,
                            billetesDe50 = billetesDe50 - @Billetes50
                        WHERE id = 1;
						
						INSERT INTO RegistroCajero (fechahora, billetesDe100, billetesDe50, total, administradorId, accion)
						VALUES (@TransFecha, @Billetes100, @Billetes50, ((@Billetes100 * 100) + (@Billetes50 * 50)), NULL, 'R');

                    END
                    ELSE
                    BEGIN
                        RAISERROR('No hay suficientes billetes disponibles en el cajero para completar la transacción', 16, 1);
                        RETURN;
                    END
                END
                ELSE IF @TransTipo = 'D'
                BEGIN
                    INSERT INTO Transacciones (idTransaccion, tipoTransaccion, monto, fechaHora, NumeroCuentaOrigen, NumeroCuentaDestino)
                    VALUES (@TransNumero, @TransTipo, @TransValor, @TransFecha, @Cuenta, NULL);
                    
                    IF EXISTS(SELECT 1 FROM Cuentas WHERE noCuenta = @Cuenta)
                    BEGIN
                        UPDATE Cuentas SET saldo = saldo + @TransValor WHERE noCuenta = @Cuenta;
                    END
                    ELSE
                    BEGIN
                        SELECT @IDUsuario = idCliente FROM Cuentas WHERE noCuenta = @Cuenta;
                        INSERT INTO Cuentas VALUES (@Cuenta, @IDUsuario, @TransValor);
                    END
                END
            END
            ELSE
            BEGIN 
                IF @TransTipo = 'R' AND @Saldo >= @TransValor 
                BEGIN
                    INSERT INTO Transacciones (idTransaccion, tipoTransaccion, monto, fechaHora, NumeroCuentaOrigen, NumeroCuentaDestino)
                    VALUES (@TransNumero, @TransTipo, @TransValor, @TransFecha, @Cuenta, NULL);
                    
                    IF (@TransValor <= @Saldo)
                    BEGIN
                        WHILE @TotalDinero > 0
                        BEGIN
                            IF @TotalDinero >= 100 AND @Billetes100 < @BillActual100
                            BEGIN
                                SET @Billetes100 = @Billetes100 + 1;
                                SET @TotalDinero -= 100;
                            END
                            ELSE IF @TotalDinero >= 50 AND @Billetes50 <= @BillActual50
                            BEGIN
                                SET @Billetes50 = @Billetes50 + 1;
                                SET @TotalDinero -= 50;
                            END
                            ELSE
                            BEGIN
                                RAISERROR('No se puede retirar esta cantidad, tiene que ser dentro de billetes de 100 y 50', 16, 1);
                                RETURN;
                            END
                        END
                        
                        IF EXISTS(SELECT 1 FROM Cajero WHERE billetesDe100 >= @Billetes100 AND billetesDe50 >= @Billetes50)
                        BEGIN
                            UPDATE Cuentas SET saldo = saldo - @TransValor WHERE noCuenta = @Cuenta;
                            
                            -- Actualizar el cajero
                            UPDATE Cajero SET 
                                cantidad = cantidad - ((@Billetes100 * 100) + (@Billetes50 * 50)),
                                billetesDe100 = billetesDe100 - @Billetes100,
                                billetesDe50 = billetesDe50 - @Billetes50
                            WHERE id = 1;
							
							INSERT INTO RegistroCajero (fechahora, billetesDe100, billetesDe50, total, administradorId, accion)
							VALUES (@TransFecha, @Billetes100, @Billetes50, ((@Billetes100 * 100) + (@Billetes50 * 50)), NULL, 'R');
                        END
                        ELSE
                        BEGIN
                            RAISERROR('No hay suficientes billetes disponibles en el cajero para completar la transacción', 16, 1);
                            RETURN;
                        END
                    END
                END
                ELSE IF @TransTipo = 'D'
                BEGIN
                    INSERT INTO Transacciones (idTransaccion, tipoTransaccion, monto, fechaHora, NumeroCuentaOrigen, NumeroCuentaDestino)
                    VALUES (@TransNumero, @TransTipo, @TransValor, @TransFecha, @Cuenta, NULL);
                    IF EXISTS(SELECT 1 FROM Cuentas WHERE noCuenta = @Cuenta)
                    BEGIN
                        UPDATE Cuentas SET saldo = saldo + @TransValor WHERE noCuenta = @Cuenta;

                    END
                    ELSE
                    BEGIN
                        SELECT @IDUsuario = idCliente FROM Cuentas WHERE noCuenta = @Cuenta;
                        INSERT INTO Cuentas VALUES (@Cuenta, @IDUsuario, @TransValor);
                    END
                END
                ELSE
                BEGIN
                    RAISERROR('No hay suficientes fondos en la cuenta', 16, 1);
                    RETURN;
                END
            END
            
            COMMIT;
            BREAK; -- Salir del bucle while si la transacción es exitosa
        END TRY
        BEGIN CATCH
            IF ERROR_NUMBER() = @Dead
            BEGIN
                SET @Intentos = @Intentos + 1;
                WAITFOR DELAY '00:00:01';
                SELECT 'Intento numero: ', @Intentos;
                ROLLBACK;
            END
            -- Verificar
            ELSE IF @Intentos >= 3
            BEGIN
                SELECT 'Vuelva a intentarlo más tarde, tenemos complicaciones';
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
