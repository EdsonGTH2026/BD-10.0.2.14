SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
     
--BGMA:08-09-2020:SP PARA REGISTRAR DATOS OBTENIDOS DEL OCR DEL INE      


CREATE PROCEDURE [dbo].[pOcrCargarDatosINE] (    
	@CodCuenta			varchar(25),	
	@Texto				varchar(1500),
	@Nombre				varchar(30),
	@ApPaterno			varchar(30),
	@ApMaterno			varchar(30),
	@FechaNacimiento	smalldatetime,
	@Vigencia			varchar(4),
	@NombreArchivo		varchar(200),
	@Parametro        	CHAR(1)	
	)        
AS        
BEGIN                
	IF @parametro = '0'        
	BEGIN        
		INSERT INTO tOcrFrenteINE(       
			CodCuenta,	
			Nombre,
			ApPaterno,
			ApMaterno,
			FechaNacimiento,
			Vigencia,
			NombreArchivo			
		)        
		VALUES(      
			@CodCuenta,      
			@Nombre,        
			@ApPaterno,        
			@ApMaterno,  
			@FechaNacimiento,
			@Vigencia,
			@NombreArchivo
		);        
        
		  
	END;        
	
	IF @parametro = '1'      
	BEGIN        
		INSERT INTO tOcrReversoINE(       
			CodCuenta,	
			NombreArchivo
		)        
		VALUES(      
			@CodCuenta,      
			@NombreArchivo
		);         
		
	END;            
	
	UPDATE tOcrDatosImagen                          
	SET	Envio = 1 , Texto = @Texto, fechaProceso = getdate()   
	WHERE CodigoCuenta = @CodCuenta        
	AND NombreArchivo = @NombreArchivo;        	
    END;
GO