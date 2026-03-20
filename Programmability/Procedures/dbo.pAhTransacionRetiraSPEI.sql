SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

--RIA:19-12-2019:SP PARA REGISTRAR EL HISTORIAL QUE SE OBTIENE DE LA PETICION A STP  
--25012021 BGMA SE ACTUALIZA SP PARA QUE NO ACTIVE CUENTAS DPF INACTIVAS      

CREATE PROCEDURE [dbo].[pAhTransacionRetiraSPEI] (    
	@IdTransaccion    	INT,         
	@CodCuenta        	VARCHAR(30),         
	@jsonenvio        	VARCHAR(1500),         
	@jsonrespueta     	VARCHAR(1500),         
	@IdSTP            	INT,         
	@DescripcionError	VARCHAR(200),         
	@Firma            	VARCHAR(500),     
	@Monto            	MONEY, 
	@FolioOrigen     	VARCHAR (50), 
	@parametro        	CHAR(1)        
	)        
AS        
BEGIN                
	IF @parametro = '0'        
	BEGIN        
		INSERT INTO tAhTransaccionDiariaRetiraSPEI(       
			IdTransaccion,         
			CodCuenta,         
			jsonenvio,                          
			IdSTP,         
			FechaHoraTran,        
			Firma,  
			Monto , 
			FolioOrigen
		)        
		VALUES(      
			@IdTransaccion,         
			@CodCuenta,         
			@jsonenvio,        
			@IdSTP,         
			GETDATE(),        
			@Firma ,  
			@Monto ,
			@FolioOrigen 
		);        
        
		--- ### ACTUALIZA tAhTransaccionDiariaSTP ENVIADO 1 BANDERA PARA ENVIAR A SPEI#####---    
		UPDATE tAhTransaccionDiariaSTP set Enviado = 1,         
		FechaHoraTran = GETDATE()        
		WHERE IdTransaccion = @IdTransaccion        
		AND CodCuenta = @CodCuenta;     
        
		---#### ACTUALIZA EL ESTADO DE LA CUENTA SP PARA EVITAR QUE TENGA OPERACIONES     
		---- ### MIENTRAS SE ENCUENTRA EN PROCESO POR SPEI    
		
		--update Finmas_20190801fin.dbo.tahcuenta set idEstadoCta='SP' ---BD  PRUEBAS    
		UPDATE Finmas.dbo.tahcuenta set idEstadoCta = 'SP' ---BD  PRODUCCION
		WHERE codcuenta = @CodCuenta
		AND SUBSTRING(CAST(IDProducto AS VARCHAR(10)), 1, 1) = '1'   
	END;        
	
	IF @parametro = '1'        
	IF NOT EXISTS(
		SELECT *        
		FROM tAhTransaccionDiariaRetiraSPEI WITH(NOLOCK)        
		WHERE IdTransaccion = @IdTransaccion        
		)        
	BEGIN        
		INSERT INTO tAhTransaccionDiariaRetiraSPEI(      
			IdTransaccion,         
			CodCuenta,         
			jsonenvio,          
			FechaHoraTran        
			)        
		VALUES(     
			@IdTransaccion,         
			@CodCuenta,         
			@jsonenvio,        
			GETDATE()        
			)  
		
		UPDATE tAhTransaccionDiariaSTP 
		SET	Estado = 3,
			Enviado = 1,
			FechaHoraTran = GETDATE(),
			FechaProcesoFin = GETDATE()
		WHERE ClaveRastreo = @folioOrigen
		
		
	END;            
	
	UPDATE tAhTransaccionDiariaRetiraSPEI                          
	SET	DescripcionError = @DescripcionError,        
		jsonrespueta = @jsonrespueta, 
		FolioOrigen = @FolioOrigen , 
		FechaHoraTran = GETDATE()        
	WHERE IdTransaccion = @IdTransaccion        
	AND CodCuenta = @CodCuenta ;        
	
    END;
GO