SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
create procedure [dbo].[pCDDCaDocsDigitalesLocal]
as
BEGIN
	select  ee.IdEventoEvidencia, e.CodSolicitud, e.CodOficina, ee.RutaOriginal,
	ee.NombreOriginal,ee.RutaDestino, ee.NombreNuevo, ee.IdTipoDocumento,
	ee.descripcion, ee.FechaAlta, ee.ArchivoWebCopiado, ee.FechaRespaldo
	from finmas.dbo.tCaevento as e with(nolock)
	inner join finmas.dbo.tCaeventoevidencia as ee with(nolock) on ee.IdEvento = e.IdEvento
	where ee.Activa = 1
	and isnull(ee.ArchivoWebCopiado,0) = 0
	and ltrim(isnull(RutaDestino, '')) = ''
	and RutaOriginal like '%c:\%'
	order by RutaOriginal, e.CodSolicitud, e.CodOficina
END
GO