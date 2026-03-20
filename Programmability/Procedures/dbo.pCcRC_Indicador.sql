SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE procedure [dbo].[pCcRC_Indicador] (@IdCC int)
as
--declare @IdCC int
--set @IdCC=215581
set nocount on
	select 
	c.IdCC, 
	i.DescripcionInd, i.ValorInd
	from 
	tCcConsulta as c with(nolock)
	inner join tCcRespuestaIndicador as i with(nolock) on i.IdCC = c.IdCC
	where c.IdCC = @IdCC
GO