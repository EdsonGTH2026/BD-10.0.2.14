SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE procedure [dbo].[pCcRC_Mensaje] (@IdCC int)
as
set nocount on
--declare @IdCC int
--set @IdCC=215581
	select 
	c.IdCC, m.TipoMensaje, m.Leyenda 
	from 
	tCcConsulta as c with(nolock)
	inner join tCcRespuestaMensaje as m with(nolock) on m.IdCC = c.IdCC
	where c.IdCC = @IdCC
GO