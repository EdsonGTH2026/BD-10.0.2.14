SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
create procedure [dbo].[pCCUpdateCambioAReporte] @intIdCC int
as
	set nocount on

	update tCcConsulta 
	set 
	Consulta = '', 
	Tipo = 'R', 
	Procesado = 0,encolacc=0,encola=0, 
	Comentario = left(Comentario + '|Al consultar por MONITOR, regresa error NO EXISTE LA CUENTA ASOCIADA AL EXPEDIENTE, se cambia a tipo REPORTE', 200) 
	where IdCC = @intIdCC --and CodUsuario = @CodCliente 
GO