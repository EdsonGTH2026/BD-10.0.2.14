SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE procedure [dbo].[pCcRC_ConsultasScore] (@IdCC int)
as
--declare @IdCC int
--set @IdCC=215581
set nocount on
	select 
	rs.IdScore, rs.IdCC, rs.NombreScore, rs.Codigo, rs.Valor, 
	rs.Razon1, r.Descripcion as DescRazon,
	rs.Error
	from tCcRespuestaScore as rs with(nolock)
	left join tCcClRazonesScore as r with(nolock) on r.IdRazon = rs.Razon1
	where rs.IdCC = @IdCC
	
	union
	
	select 
	rs.IdScore, rs.IdCC, rs.NombreScore, rs.Codigo, rs.Valor, 
	rs.Razon2, r.Descripcion as DescRazon,
	rs.Error
	from 
	tCcRespuestaScore as rs with(nolock)
	left join tCcClRazonesScore as r with(nolock) on r.IdRazon = rs.Razon2
	where rs.IdCC = @IdCC
	
	union
	
	select 
	rs.IdScore, rs.IdCC, rs.NombreScore, rs.Codigo, rs.Valor, 
	rs.Razon3, r.Descripcion as DescRazon,
	rs.Error
	from 
	tCcRespuestaScore as rs with(nolock)
	left join tCcClRazonesScore as r with(nolock) on r.IdRazon = rs.Razon3
	where rs.IdCC = @IdCC
	
	union
	
	select 
	rs.IdScore, rs.IdCC, rs.NombreScore, rs.Codigo, rs.Valor, 
	rs.Razon4, r.Descripcion as DescRazon,
	rs.Error
	from 
	tCcRespuestaScore as rs with(nolock)
	left join tCcClRazonesScore as r with(nolock) on r.IdRazon = rs.Razon4
	where rs.IdCC = @IdCC
	
	order by rs.IdScore
GO

GRANT EXECUTE ON [dbo].[pCcRC_ConsultasScore] TO [public]
GO