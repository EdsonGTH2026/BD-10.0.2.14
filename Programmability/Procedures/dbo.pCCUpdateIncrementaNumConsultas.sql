SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
create procedure [dbo].[pCCUpdateIncrementaNumConsultas] @intIdCC int,@intNumConsulta int,@Respuesta varchar(200)
as
	set nocount on
	update tCcConsulta set 
	FechaRespuesta = getdate(),  
	Respuesta = 'Longitud respuesta[' + @Respuesta + ']', 
	NumConsultas = @intNumConsulta
	where IdCC = @intIdCC
GO