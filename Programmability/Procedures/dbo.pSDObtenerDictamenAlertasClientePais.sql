SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[pSDObtenerDictamenAlertasClientePais](@Id INT)
AS
BEGIN
	SELECT ISNULL(DictamenObservacion, '') AS DictamenObservacion, FechaRespuesta,
		CASE 
			WHEN RptaRegla = 1 THEN 'Por revisar'
			WHEN RptaRegla = 2 THEN 'Autorizada'
			WHEN RptaRegla = 3 THEN 'Rechazada'
		END AS RptaRegla,
		CodSistema, CodOficina
	FROM tAlertasPais WITH (NOLOCK)
	WHERE Id = @Id
END
GO