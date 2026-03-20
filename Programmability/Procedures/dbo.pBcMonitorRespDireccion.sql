SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

create procedure [dbo].[pBcMonitorRespDireccion] (@idmonitor int)
as
begin
	select 
	IdMonitor, IdDireccion, isnull(Direccion1, '') as Direccion1,                               
	isnull(Direccion2, '') as Direccion2, isnull(Colonia, '') as Colonia, isnull(Municipio, '') as Municipio,                                
	isnull(Ciudad, '') as Ciudad, isnull(Estado, '') as Estado, isnull(CP, '') as CP, 
	dbo.fBcFechaFormato(isnull(FechaRecidencia, '')) as FechaRecidencia ,
	isnull(Telefono, '') as Telefono, isnull(Ext, '') as Ext, isnull(Fax, '') as Fax,         
	isnull(TipoDomicilio, '') as TipoDomicilio, isnull(IndicadorEspecial, '') as IndicadorEspecial,
	dbo.fBcFechaFormato(isnull(FechaReporteDir, '')) as FechaReporteDir 
	from tBcMonitorRespDireccion with(nolock)
	where IdMonitor = @idmonitor
    order by IdDireccion
end
GO