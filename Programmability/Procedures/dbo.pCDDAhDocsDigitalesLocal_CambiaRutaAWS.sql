SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
create procedure [dbo].[pCDDAhDocsDigitalesLocal_CambiaRutaAWS]
as
BEGIN
--begin tran
	update ee set
	ee.RutaOriginal = 'C:\Inetpub\wwwroot\SeFin\Storage'
	from finmas.dbo.tahevento as e
	inner join finmas.dbo.taheventoevidencia as ee on ee.idevento = e.idevento		
	where ee.Activa = 1
	and isnull(ee.ArchivoWebCopiado,0) = 0
	and ltrim(isnull(ee.RutaDestino, '')) = ''
	and (e.Codcuenta like '098-' + '112' + '-06-%' or e.Codcuenta like '098' + '112' + '06%' ) 
	and ee.fechamodificacion >= '20200901'
	and ee.rutaoriginal like '\\10.%\storage'
--rollback tran
END
GO