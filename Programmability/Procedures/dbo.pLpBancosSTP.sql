SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
create procedure [dbo].[pLpBancosSTP]
as
	select clavebanco,participante from finamigostp.dbo.CatalogoBancos with(nolock)
GO