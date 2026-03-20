SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[pSDBuscaArchivoPaisesCargadoDetalle](@IdArchivo INT)
AS
BEGIN
	SELECT IdArchivo, NombreArchivo, CodPais, Pais, Nacionalidad, Continente, Riesgo, FechaSistema
	FROM tListaArchivosPaisesCargados WITH (NOLOCK)
	WHERE IdArchivo = @IdArchivo
	AND Activo = 1
END
GO