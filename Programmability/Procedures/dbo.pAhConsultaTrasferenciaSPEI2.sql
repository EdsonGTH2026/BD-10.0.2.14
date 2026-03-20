SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO



CREATE PROCEDURE [dbo].[pAhConsultaTrasferenciaSPEI2](
		@CodCuenta		VARCHAR(20),     
		@ClaveRastreo	VARCHAR(20)
		)    

AS   

BEGIN
	
	--DECLARE @CodCuenta VARCHAR(20);
	--DECLARE @ClaveRastreo VARCHAR(20);
	
	
	DECLARE @ClaveTemp VARCHAR(20);
	DECLARE @Estado VARCHAR(50);
	
	---#### VERIFICAMOS SI LA CLAVE EXISTE ###----
	SELECT @ClaveTemp = ClaveRastreo
	FROM FinamigoSTP.dbo.tAhTransaccionDiariaSTP
	WHERE ClaveRastreo = @ClaveRastreo
	AND Codcuenta = @CodCuenta;
	
	IF @ClaveTemp <> ''
	BEGIN 
		DECLARE @status varchar (20);
		
		SELECT @status = Estado 
		FROM tAhTransaccionDiariaRetiraSPEI  WITH(nolock)
		WHERE FolioOrigen = @ClaveRastreo
		
		-- print '@status'+@status
		IF @status = 'liquidacion'
		
			BEGIN
				SET   @Estado = 'liquidacion';
				SELECT @Estado AS Estado
				RETURN 
		END
		
		ELSE IF @status = 'devolucion'
			BEGIN
				SET   @Estado = 'devolucion';
				SELECT @Estado AS Estado
				RETURN 
		END
		
		ELSE
			BEGIN
				SET   @Estado = 'En proceso';
				SELECT @Estado AS Estado
				RETURN
			END 
		
		END 
		ELSE
			SET   @Estado = 'La clave de rastreo no existe verIFique';
			SELECT @Estado AS Estado
		END
GO