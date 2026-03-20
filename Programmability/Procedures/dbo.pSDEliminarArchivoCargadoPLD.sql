SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[pSDEliminarArchivoCargadoPLD](@IdArchivo INT)
AS
BEGIN
	UPDATE tListaPersonasBloqueadas SET Activo = 0
	WHERE IdArchivo = @IdArchivo

	SELECT @@ROWCOUNT
END
GO