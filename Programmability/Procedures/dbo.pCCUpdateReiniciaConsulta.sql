SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
create procedure [dbo].[pCCUpdateReiniciaConsulta] @intIdCC int
as
	set nocount on
	update tCcConsulta set 
	encolacc = 0,encola=0 
	where IdCC = @intIdCC
GO