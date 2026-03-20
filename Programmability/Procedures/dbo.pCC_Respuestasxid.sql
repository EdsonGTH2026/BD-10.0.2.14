SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE procedure [dbo].[pCC_Respuestasxid] @idcc int
as
	declare @table table (IdRespuesta int,IdCC int,Respuesta varchar(4000))
	insert into @table
	select IdRespuesta, IdCC, Respuesta 
	from tCcConsultaRespuesta with(nolock) 
	where IdCC = @idcc--167601
	and IdRespuesta>0
	
	select * 
	from @table
	order by IdRespuesta
GO