USE [Cajero]
GO
/****** Object:  StoredProcedure [dbo].[inicioSeccion]    Script Date: 22/03/2024 15:12:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[inicioSeccion]
    @Cuenta VARCHAR(25),
    @PIN VARCHAR(10)
AS	
BEGIN
    -- Verificar si los parámetros están ingresados
    IF @Cuenta IS NULL OR @PIN IS NULL
    BEGIN
        THROW 50001, 'Falta ingresar datos. Por favor, ingrese tanto el número de cuenta como el PIN.', 1;
        RETURN;
    END

    DECLARE @Intentos INT = 0;
    DECLARE @Dead INT = 1205;
    
    WHILE @Intentos < 3
    BEGIN
        SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
        BEGIN TRANSACTION;
        BEGIN TRY
            -- Verificar si los datos existen en las tablas Clientes y Cuentas
            IF NOT EXISTS (SELECT 1 FROM Clientes WHERE pin = @PIN)
            BEGIN
                THROW 50002, 'El PIN ingresado no está registrado.', 1;
            END
            
            IF NOT EXISTS (SELECT 1 FROM Cuentas WHERE noCuenta = @Cuenta)
            BEGIN
                THROW 50003, 'El número de cuenta ingresado no está registrado.', 1;
            END

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
