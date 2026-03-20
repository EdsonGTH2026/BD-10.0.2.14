SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[pSDObtenerDictamenAlertasRiesgoCliente](@Id INT)
AS
BEGIN
	SELECT ISNULL(DictamenObservacion, '') AS DictamenObservacion
	FROM tAlertasRiesgoCliente WITH (NOLOCK)
	WHERE Id = @Id
END
GO