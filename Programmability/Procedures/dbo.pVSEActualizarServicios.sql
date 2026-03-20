SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
     
--BGMA:24-09-2020:SP PARA REGISTRAR/ACTUALIZAR DATOS DE SERVICIOS   


CREATE PROCEDURE [dbo].[pVSEActualizarServicios] (    
	@idServicio			int,	
	@descripcion		varchar(30),
	@categoria			varchar (100),
	@avatar				varchar(100),
	@activo				int,
	@Parametro        	int	
	)        
AS        
BEGIN                
	IF @parametro = 1        
	BEGIN        
		INSERT INTO tVSECatalogoServicios(       
			idServicio,	
			descripcion,
			categoria,
			avatar,
			activo,
			fechaUltimaAct			
		)        
		VALUES(      
			@idServicio,      
			@descripcion,        
			@categoria,        
			@avatar,  
			1,
			getdate()
		);        
        
		  
	END;        
	
	IF @parametro = 0      
	BEGIN        
		UPDATE tVSECatalogoServicios                          
		SET	activo = @activo, descripcion = @descripcion, categoria = @categoria,  avatar = @avatar,  fechaUltimaAct = getdate()   
		WHERE idServicio  = @idServicio;        	
		END; 	
	END;            
	
	
GO