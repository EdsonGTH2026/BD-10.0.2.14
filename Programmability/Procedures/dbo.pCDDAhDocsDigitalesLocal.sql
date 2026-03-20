SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE procedure [dbo].[pCDDAhDocsDigitalesLocal]
as
BEGIN
	select  ee.IdEventoEvidencia, e.Codcuenta, ee.RutaOriginal,ee.NombreOriginal,ee.RutaDestino, ee.NombreNuevo, ee.IdTipoDocumento,
	ee.descripcion, ee.FechaAlta, ee.ArchivoWebCopiado, ee.FechaRespaldo
	from finmas.dbo.tahevento as e with(nolock)
	inner join finmas.dbo.taheventoevidencia as ee with(nolock) on ee.IdEvento = e.IdEvento
	where ee.Activa = 1
	and isnull(ee.ArchivoWebCopiado,0) = 0
	and ltrim(isnull(RutaDestino, '')) = ''
	--and e.Codcuenta like '098-113-06-%' --cuentas dbmenos
	--and e.Codcuenta = '098-113-06-2-5-00868'
	--GDF 2021.09.02 se comentapara que carguen todas la rutas de almacenamiento
	--and RutaOriginal like 'c:\%'
	and e.Codcuenta <> ''
	order by e.Codcuenta
END
GO