SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
create procedure [dbo].[pBcMonitorRespResumen] (@idmonitor int)
as
begin

	select 
	IdMonitor,   IdResumen,   
	dbo.fBcFechaFormato(isnull(FecIntegracionBD,'')) as FecIntegracionBD, 
	isnull(MensajeAlerta,'') as MensajeAlerta  
	from tBcMonitorRespResumen
	where idmonitor = @idmonitor
end

GO