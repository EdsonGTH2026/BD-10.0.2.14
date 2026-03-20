SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE procedure [dbo].[pMsMarcaRegistroConsultado] @codcuenta varchar(20)
as
	update tConsultaMasiva
	set estado=3,fechaconsulta=getdate()
	where codcuenta=@codcuenta
GO