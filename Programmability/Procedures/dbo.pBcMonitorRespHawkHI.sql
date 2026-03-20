SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
create procedure [dbo].[pBcMonitorRespHawkHI] (@idmonitor int)
as
begin

	select 
	IdMonitor, IdHI, 
	dbo.fBcFechaFormato(isnull(FechaReporte,'')) as FechaReporte, isnull(CodigoPrevencion,'') as CodigoPrevencion, 
	isnull(TipoUsuario,'') as TipoUsuario, isnull(Mensaje,'') as Mensaje
	from tBcMonitorRespHawkHI
	where idmonitor = @idmonitor
end

GO