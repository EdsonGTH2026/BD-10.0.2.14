SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[pCURPInfoConsultaSolicitudQA] @CURP VARCHAR(18)
AS
	DECLARE @CURPValido INT
	DECLARE @Nombres VARCHAR(100)
	DECLARE @ApellidoPaterno VARCHAR(50) 
	DECLARE @ApellidoMaterno VARCHAR(50) 
	DECLARE @Sexo VARCHAR(1) 
	DECLARE @FechaNacimiento SMALLDATETIME
	DECLARE @EntidadFederativaNacimiento VARCHAR(3) 
	DECLARE @ClaveNacionalidad VARCHAR(10) 
	DECLARE @DescripcionRespuestaCCB VARCHAR(100) 
	DECLARE @DescripcionRespuestaRenapo VARCHAR(100) 
	DECLARE @FechaRegistro DATETIME
	
	SELECT TOP 1 @CURPValido = CURPValido, @Nombres = Nombres, @ApellidoPaterno = ApellidoPaterno, @ApellidoMaterno = ApellidoMaterno, 
		   @Sexo = Sexo, @FechaNacimiento = FechaNacimiento, @EntidadFederativaNacimiento = EntidadFederativaNacimiento, 
		   @ClaveNacionalidad = ClaveNacionalidad, @DescripcionRespuestaCCB = DescripcionRespuestaCCB, 
		   @DescripcionRespuestaRenapo = DescripcionRespuestaRenapo, @FechaRegistro = FechaRegistro
	FROM tCURPInfoQA WITH (NOLOCK)
	WHERE CURP = @CURP
	AND CodigoRespuestaCCB = 'CRGEN000'
	ORDER BY FechaRegistro DESC

	IF @CURPValido IS NULL
		BEGIN
			SELECT 0 AS Exist, @CURPValido AS CURPValido, @Nombres AS Nombres, @ApellidoPaterno AS ApellidoPaterno, 
				   @ApellidoMaterno AS ApellidoMaterno, @Sexo AS Sexo, @FechaNacimiento AS FechaNacimiento, 
				   @EntidadFederativaNacimiento AS EntidadFederativaNacimiento, @ClaveNacionalidad AS ClaveNacionalidad, 
				   @DescripcionRespuestaCCB AS DescripcionRespuestaCCB, @DescripcionRespuestaRenapo AS DescripcionRespuestaRenapo
		END
	ELSE
		BEGIN
			IF DATEDIFF(DAY, @FechaRegistro, GETDATE()) > 180
				BEGIN
					SELECT 0 AS Exist, NULL AS CURPValido, NULL AS Nombres, NULL AS ApellidoPaterno, NULL AS ApellidoMaterno, NULL AS Sexo, 
						   NULL AS FechaNacimiento, NULL AS EntidadFederativaNacimiento, NULL AS ClaveNacionalidad, 
						   NULL AS DescripcionRespuestaCCB, NULL AS DescripcionRespuestaRenapo
				END
			ELSE
				BEGIN
					SELECT 1 AS Exist, @CURPValido AS CURPValido, @Nombres AS Nombres, @ApellidoPaterno AS ApellidoPaterno, 
						   @ApellidoMaterno AS ApellidoMaterno, @Sexo AS Sexo, @FechaNacimiento AS FechaNacimiento, 
						   @EntidadFederativaNacimiento AS EntidadFederativaNacimiento, @ClaveNacionalidad AS ClaveNacionalidad, 
						   @DescripcionRespuestaCCB AS DescripcionRespuestaCCB, @DescripcionRespuestaRenapo AS DescripcionRespuestaRenapo
				END
		END
GO