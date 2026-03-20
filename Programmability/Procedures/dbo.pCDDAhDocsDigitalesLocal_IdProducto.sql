SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
create procedure [dbo].[pCDDAhDocsDigitalesLocal_IdProducto] (@IdProducto varchar(3))
as
BEGIN
	--Actualiza ruta web a ruta local del servidors AWS
	exec pCDDAhDocsDigitalesLocal_CambiaRutaAWS
	
	select  ee.IdEventoEvidencia, e.Codcuenta, ee.RutaOriginal,ee.NombreOriginal,ee.RutaDestino, ee.NombreNuevo, ee.IdTipoDocumento,
	ee.descripcion, ee.FechaAlta, ee.ArchivoWebCopiado, ee.FechaRespaldo
	from finmas.dbo.tahevento as e with(nolock)
	inner join finmas.dbo.taheventoevidencia as ee with(nolock) on ee.IdEvento = e.IdEvento
	where ee.Activa = 1
	and isnull(ee.ArchivoWebCopiado,0) = 0
	and ltrim(isnull(RutaDestino, '')) = ''
	and (e.Codcuenta like '098-' + @IdProducto + '-06-%' or e.Codcuenta like '098' + @IdProducto + '06%' ) 
	--and e.Codcuenta = '098-113-06-2-5-00868'
	and RutaOriginal like 'c:\%'
	order by e.Codcuenta
END
GO