SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
create procedure [dbo].[pBcMonitorRespHawkHR] (@idmonitor int)
as
begin

	select 
	IdMonitor, IdHR, 
	dbo.fBcFechaFormato(isnull(FechaReporte,'')) as FechaReporte, isnull(CodigoPrevencion,'') as CodigoPrevencion, 
	isnull(TipoUsuario,'') as TipoUsuario, isnull(Mensaje,'') as Mensaje
	from tBcMonitorRespHawkHR
	where idmonitor = @idmonitor
end
GO