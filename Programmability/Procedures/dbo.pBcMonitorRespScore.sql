SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

create procedure [dbo].[pBcMonitorRespScore] (@idmonitor int)
as
begin

	select 
	IdMonitor, IdScore, isnull(NombreScore,'') as NombreScore,                   
	isnull(CodigoScore,'') as CodigoScore, 
	isnull(ValorScore,'') as ValorScore, 

	isnull(CodigoRazon1,'') as CodigoRazon1, 
	(case CodigoScore
	when '007' then isnull((select Descripcion from tBcClRazonScore where activo = 1 and convert(integer,CodigoRazon) = tBcMonitorRespScore.CodigoRazon1),'') 
	when '009' then isnull((select Descripcion from tBcClRazonScoreMicrofinancieras where activo = 1 and tipo <> 'ERROR' and convert(integer,CodigoRazon) = tBcMonitorRespScore.CodigoRazon1),'') 
	end ) as DescRazon1,

	isnull(CodigoRazon2,'') as CodigoRazon2, 
	(case CodigoScore
	when '007' then isnull((select Descripcion from tBcClRazonScore where activo = 1 and convert(integer,CodigoRazon) = tBcMonitorRespScore.CodigoRazon2),'') 
	when '009' then isnull((select Descripcion from tBcClRazonScoreMicrofinancieras where activo = 1 and tipo <> 'ERROR'and convert(integer,CodigoRazon) = tBcMonitorRespScore.CodigoRazon2),'') 
	end ) as DescRazon2,

	isnull(CodigoRazon3,'') as CodigoRazon3, 
	(case CodigoScore
	when '007' then isnull((select Descripcion from tBcClRazonScore where activo = 1 and convert(integer,CodigoRazon) = tBcMonitorRespScore.CodigoRazon3),'') 
	when '009' then isnull((select Descripcion from tBcClRazonScoreMicrofinancieras where activo = 1 and tipo <> 'ERROR' and convert(integer,CodigoRazon) = tBcMonitorRespScore.CodigoRazon3),'') 
	end ) as DescRazon3,

	isnull(CodigoError,'') as CodigoError,
	(case CodigoScore
	when '007' then '' --isnull((select Descripcion from tBcClRazonScore where activo = 1 and tipo = 'ERROR' and convert(integer,CodigoRazon) = tBcMonitorRespScore.CodigoRazon3),'') 
	when '009' then isnull((select Descripcion from tBcClRazonScoreMicrofinancieras where activo = 1 and tipo = 'ERROR' and convert(integer,CodigoRazon) = tBcMonitorRespScore.CodigoError),'') 
	else 'ND'
	end ) as DescError

	from tBcMonitorRespScore
	where idmonitor = @idmonitor

end
GO