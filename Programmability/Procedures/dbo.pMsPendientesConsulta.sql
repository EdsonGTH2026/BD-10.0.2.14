SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE procedure [dbo].[pMsPendientesConsulta]
as
	set nocount on
	--select top 2 codcuenta,curp,'MIIO_1' idservicio
	--from tConsultaMasiva with(nolock)

	create table #tabla(codcuenta varchar(20),curp varchar(20),idservicio varchar(10))
	insert into #tabla
	select top 100 codcuenta,curp,'MIIO_2' idservicio
	from tConsultaMasiva with(nolock)
	where estado=1 and curp is not null

	update tConsultaMasiva
	set estado=2,fecharegistro=getdate()
	where codcuenta in(select codcuenta from #tabla)

	select * from #tabla
	--select codcuenta,curp,'MIIO_1' idservicio
	--from tConsultaMasiva with(nolock)
	--where codcuenta in(select codcuenta from #tabla)

	drop table #tabla
GO