SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[pSDDetalleArchivoCargadoPLD](@IdArchivo INT)
AS
BEGIN
	SELECT IdArchivo, NombreArchivo, Tipo, FechaOficio, Nombre, ApellidoPaterno, ApellidoMaterno, RFC, FechaNacimiento, Motivo, FechaSistema
	FROM tListaPersonasBloqueadas WITH (NOLOCK)
	WHERE IdArchivo = @IdArchivo
	AND Activo = 1
END
GO