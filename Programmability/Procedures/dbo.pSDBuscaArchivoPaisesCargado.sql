SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[pSDBuscaArchivoPaisesCargado](@NombreArchivo VARCHAR(50))
AS
BEGIN
	DECLARE @ArchivoExistente INT

	SELECT @ArchivoExistente = COUNT(*) FROM tListaArchivosPaisesCargados WITH (NOLOCK)
	WHERE NombreArchivo = RTRIM(LTRIM(@NombreArchivo))

	IF @ArchivoExistente > 0
		BEGIN
			SELECT 'Archivo existente' AS Ret
		END
	ELSE
		BEGIN
			SELECT ISNULL(MAX(IdArchivo),0) + 1 AS Ret FROM tListaArchivosPaisesCargados WITH (NOLOCK)
		END
END
GO