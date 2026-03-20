SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

create procedure [dbo].[pMsDesMarcaRegistroxError] @codcuenta varchar(20)
as
	update tConsultaMasiva
	set estado=1,fecharegistro=null
	where codcuenta=@codcuenta
GO