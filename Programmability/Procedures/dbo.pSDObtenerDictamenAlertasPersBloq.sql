SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[pSDObtenerDictamenAlertasPersBloq](@Id INT)
AS
BEGIN
	SELECT ISNULL(a.DictamenObservacion, '') AS DictamenObservacion, FechaRespuesta,
		   CASE 
			WHEN a.RptaRegla = 1 THEN 'Por revisar'
			WHEN a.RptaRegla = 2 THEN 'Autorizada'
			WHEN a.RptaRegla = 3 THEN 'Rechazada'
		   END AS RptaRegla,
		   b.FechaOficio, 
		   CASE
			WHEN b.NombreArchivo IS NULL THEN 'Agregado por coincidencia'
			ELSE b.NombreArchivo END AS NombreArchivo,
		   CASE
			WHEN a.CodSistema = 'AH' THEN 'Finmas Ahorro'
			WHEN a.CodSistema = 'MB' THEN 'Finmas App'
		   END AS CodSistema, a.CodSolicitud, a.CodOficina,
		   d.Pais, d.Nacionalidad, 
		   CASE WHEN e.UsCURP IS NOT NULL OR e.UsCURP <> '' THEN e.UsCURP ELSE c.UsCURPBD END AS CURP,
		   f.Direccion + ' ' + f.NumExterno + ', ' + f.NumInterno + ', ' + g.DescUbiGeo + ', ' + h.DescUbiGeo + ', CP: ' + f.CodPostal AS Direccion,
		   c.FechaNacimiento
	FROM tAlertasPersonasBloqueadas a WITH (NOLOCK)
	LEFT JOIN tListaPersonasBloqueadas b WITH (NOLOCK) ON a.IdPersonaBloqueada = b.Id
	LEFT JOIN Finmas.dbo.tUsUsuarios c WITH (NOLOCK) ON a.CodUsuario = c.CodUsuario
	LEFT JOIN Finmas.dbo.tClPaises d WITH (NOLOCK) ON c.CodPais = d.CodPais
	LEFT JOIN Finmas.dbo.tUsUsuarioSecundarios e WITH (NOLOCK) ON a.CodUsuario = e.CodUsuario
	LEFT JOIN Finmas.dbo.tUsUsuarioDireccion f WITH (NOLOCK) ON a.CodUsuario = f.CodUsuario AND f.FamiliarNegocio = 'F'
	LEFT JOIN Finmas.dbo.tClUbiGeo g WITH (NOLOCK) ON f.CodUbiGeo = g.CodUbiGeo
	LEFT JOIN Finmas.dbo.tClUbiGeo h WITH (NOLOCK) ON g.CodEstado = h.CodEstado AND h.CodUbiGeoTipo = 'ESTA'
	WHERE a.Id = @Id
END
GO