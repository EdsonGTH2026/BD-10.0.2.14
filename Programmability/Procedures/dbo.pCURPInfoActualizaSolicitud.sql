SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[pCURPInfoActualizaSolicitud] @CodUsuario VARCHAR(50), @CURPValido BIT, @Nombres VARCHAR(100), @ApellidoPaterno VARCHAR(50), 
													 @ApellidoMaterno VARCHAR(50), @Sexo VARCHAR(1), @FechaNacimiento SMALLDATETIME = NULL,
													 @EntidadFederativaNacimiento VARCHAR(3), @ClaveNacionalidad VARCHAR(10),
													 @TipoDocumentoProbatorio INT = NULL, @EstatusCURP VARCHAR(50), @DigestivoEntrada VARCHAR(50), 
													 @DigestivoSalida VARCHAR(50), @TimeStampCadena VARCHAR(50), @DigestivoTimeStamp VARCHAR(50), 
													 @FechaValidacion SMALLDATETIME = NULL, @CodigoRespuestaCCB VARCHAR(10), 
													 @DescripcionRespuestaCCB VARCHAR(100), @CodigoRespuestaRenapo VARCHAR(10),
													 @DescripcionRespuestaRenapo VARCHAR(100), @IdSolicitud VARCHAR(18), @Id INT
AS
	UPDATE tCURPInfo SET
		CodUsuario = @CodUsuario,
		CURPValido = @CURPValido, 
		Nombres = @Nombres,
		ApellidoPaterno = @ApellidoPaterno,
		ApellidoMaterno = @ApellidoMaterno,
		Sexo = @Sexo,
		FechaNacimiento = @FechaNacimiento,
		EntidadFederativaNacimiento = @EntidadFederativaNacimiento,
		ClaveNacionalidad = @ClaveNacionalidad,
		TipoDocumentoProbatorio = @TipoDocumentoProbatorio,
		EstatusCURP = @EstatusCURP,
		DigestivoEntrada = @DigestivoEntrada,
		DigestivoSalida = @DigestivoSalida,
		TimeStampCadena = @TimeStampCadena,
		DigestivoTimeStamp = @DigestivoTimeStamp,
		FechaValidacion = @FechaValidacion,
		CodigoRespuestaCCB = @CodigoRespuestaCCB,
		DescripcionRespuestaCCB = @DescripcionRespuestaCCB,
		CodigoRespuestaRenapo = @CodigoRespuestaRenapo,
		DescripcionRespuestaRenapo = @DescripcionRespuestaRenapo,
		FechaActualizacion = GETDATE()
	WHERE Id = @Id
	AND IdSolicitud = @IdSolicitud

	SELECT @@ROWCOUNT AS RowCountRet


GO