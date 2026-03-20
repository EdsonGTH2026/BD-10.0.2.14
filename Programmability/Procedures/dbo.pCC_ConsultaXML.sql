SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

create procedure [dbo].[pCC_ConsultaXML] (@codusuario varchar(20))
as
begin
	declare @cadenacompleta varchar(2000)
	
	set @cadenacompleta = '<?xml version="1.0" encoding="ISO-8859-1"?>'
	set  @cadenacompleta = @cadenacompleta + '<Consulta xmlns:xsi="http://www.w3.org/2001/XMLSchema_instance" xsi:noNamespaceSchemaLocation="/Consulta.xsd">'
	select @cadenacompleta = @cadenacompleta + dbo.fCC_Encabezado(@codusuario)

	select @cadenacompleta = @cadenacompleta + dbo.fCC_Persona(@codusuario)
	set  @cadenacompleta = @cadenacompleta + '</Consulta>'
	--set  @cadenacompleta = @cadenacompleta + '</xml>'
	select @cadenacompleta as ConsultaXML
end
GO