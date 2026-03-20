SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO


CREATE PROCEDURE [dbo].[pEstadoTransaccionSTP]
(@IdSTP       INT, 
	@estado      VARCHAR(20), 
	@detalle     VARCHAR(20), 
	@empresa     VARCHAR(20), 
	@folioOrigen VARCHAR(50)
)
AS
/* BGMA 03022021 Cambio para pago de intereses en ahorro, sólo se debe activar la cuenta de la última renovación*/
BEGIN
    
	DECLARE @CodCuenta VARCHAR(20);
	DECLARE @Monto MONEY;
	DECLARE @EstadoRes VARCHAR(20);
	DECLARE @FolioOrigen2 VARCHAR(100);
	DECLARE @res INT;
	DECLARE @id INT;
	DECLARE @renovado INT;
	
	
	DECLARE @EstadoRes2 varchar(20)		                     
	SELECT  @EstadoRes2 = Estado              
	FROM tAhTransaccionDiariaRetiraSPEI WITH(NOLOCK)
	WHERE IdSTP =@IdSTP ;
	
	--VERIFICAMOS QUE NO SE HALLA REALIZADO LA OPERACION	
	IF @EstadoRes2 <>'' or @EstadoRes2 <>null  
		BEGIN 
			--SI YA SE REALIZO NO REALIZAMOS NADA
			PRINT 'Ya se reliazo la operaciÓn '
			RETURN
	END
	
	ELSE
		BEGIN       
			--- ACTUALIZAMOS LOS DATOS ENVIADOS POR STP -----   
			UPDATE tAhTransaccionDiariaRetiraSPEI
			SET Estado = @estado, 
			Detalle = @detalle, 
			Empresa = @empresa, 
			FolioOrigen = @folioOrigen
			WHERE IdSTP = @IdSTP;
			
			---- CONSULTAMOS EL ESTADO ------  
			SELECT @CodCuenta = CodCuenta, 
			@Monto = Monto, 
			@EstadoRes = Estado, 
			@FolioOrigen2 = FolioOrigen
			FROM tAhTransaccionDiariaRetiraSPEI WITH(NOLOCK)
			WHERE IdSTP = @IdSTP;
			
			--- CONSULTAMOS CUENTA EN TAHCUENTA -----
			SELECT @renovado = MAX (renovado)
			FROM Finmas.dbo.tahcuenta
			WHERE codCuenta = @CodCuenta;
		
		-- PRINT @EstadoRes;
		IF @EstadoRes = 'liquidacion' ---liquidacion
			BEGIN
				UPDATE tAhTransaccionDiariaRetiraSPEI
				SET  FechaHoraEstado = GETDATE()
				WHERE IdSTP = @IdSTP;
				
				EXEC Finmas.dbo.pAhRetiroCuentaSPEI @CodCuenta, @Monto, '98CSM1803891', @IdSTP, @folioOrigen;
				
				UPDATE Finmas.dbo.tahcuenta
				SET idEstadoCta = 'CA'
				WHERE codcuenta = @CodCuenta
				AND renovado = @renovado;
				
				UPDATE tAhTransaccionDiariaSTP 
				SET Estado = 2, FechaProcesoFin = GETDATE() 
				WHERE ClaveRastreo = @folioOrigen			
		END;
		ELSE
			BEGIN 
				UPDATE Finmas.dbo.tahcuenta
				SET idEstadoCta = 'CA'
				WHERE codcuenta = @CodCuenta
				AND renovado = @renovado;
				
				UPDATE tAhTransaccionDiariaSTP 
				SET Estado = 3, FechaProcesoFin = GETDATE() 
				WHERE ClaveRastreo = @folioOrigen
		END;
        --END;
			--    ELSE
			--    BEGIN
			--        UPDATE Finmas.dbo.tahcuenta
			--          SET 
			--              idEstadoCta = 'CA'
			--        WHERE codcuenta = @CodCuenta;
		--END;
		
		--end;
		
		--else
	END
END
GO