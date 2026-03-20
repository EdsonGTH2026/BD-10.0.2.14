SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[pSDInsertListaArchivosPaisesCargados](@IdArchivo INT, @CodPais VARCHAR(4), @Pais VARCHAR(80), @Nacionalidad VARCHAR(80), 
														 @Continente VARCHAR(20), @Riesgo VARCHAR(10), @NombreArchivo VARCHAR(50))
AS
BEGIN
	INSERT INTO tListaArchivosPaisesCargados (IdArchivo, CodPais, Pais, Nacionalidad, Continente, Riesgo, NombreArchivo, FechaSistema)
	VALUES (@IdArchivo, @CodPais, UPPER(@Pais), UPPER(@Nacionalidad), UPPER(@Continente), UPPER(@Riesgo), @NombreArchivo, GETDATE())
	
	SELECT SCOPE_IDENTITY() AS Ret
END
GO