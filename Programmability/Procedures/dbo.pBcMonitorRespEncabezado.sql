SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

create procedure [dbo].[pBcMonitorRespEncabezado] (@idmonitor int)
as
begin

	select  
	e.IdMonitor,   e.Etiqueta, e.Version, 
    e.Referencia,  e.Pais, e.Reservado,   
    e.ClaveUsuario, 
	--e.ClaveRespuesta, 
	isnull(rc.MarcaFin,'') as ClaveRespuesta,
	--e.Reservado2,
	c.FechaRespuesta 
	from tBcMonitorRespEncabezado as e with(nolock)
	inner join tBcMonitorConsulta as c with(nolock) on c.IdMonitor = e.IdMonitor
	left join tBcMonitorRespCierre as rc with(nolock) on rc.IdMonitor = e.IdMonitor
	where e.IdMonitor = @idmonitor
/*
	select  
	e.IdMonitor,   e.Etiqueta, e.Version, 
    e.Referencia,  e.Pais, e.Reservado,   
    e.ClaveUsuario, e.ClaveRespuesta, e.Reservado2,
	c.FechaRespuesta 
	from tBcMonitorRespEncabezado as e with(nolock)
	inner join tBcMonitorConsulta as c with(nolock) on c.IdMonitor = e.IdMonitor
	where e.IdMonitor = @idmonitor
*/
end
GO