SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
create procedure [dbo].[pCCUpdateCambioAReportevs2] @intIdCC int,@codusuario varchar(20)
as
	set nocount on
	declare @cadenacompleta varchar(2000)
	declare @Tipo varchar(1)
	set @Tipo='R'
	set @cadenacompleta = '<?xml version="1.0" encoding="ISO-8859-1"?>'
	set  @cadenacompleta = @cadenacompleta + '<Consulta xmlns:xsi="http://www.w3.org/2001/XMLSchema_instance" xsi:noNamespaceSchemaLocation="/Consulta.xsd">'
	select @cadenacompleta = @cadenacompleta + dbo.fCC_Encabezado(@codusuario)

	select @cadenacompleta = @cadenacompleta + dbo.fCC_PersonaV2(@codusuario, @Tipo)
	set  @cadenacompleta = @cadenacompleta + '</Consulta>'

	update tCcConsulta 
	set 
	Consulta = @cadenacompleta, 
	Tipo = 'R', 
	Procesado = 0,encolacc=0,encola=0, 
	Comentario = left(Comentario + '|Al consultar por MONITOR, regresa error NO EXISTE LA CUENTA ASOCIADA AL EXPEDIENTE, se cambia a tipo REPORTE', 200) 
	where IdCC = @intIdCC --and CodUsuario = @CodCliente 
GO