SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

create procedure [dbo].[pCC_ConsultaXML_Especial] (@IdCC int)
as
begin
	declare @cadenacompleta varchar(2000)
	declare @xml_Persona varchar(1500)
	--declare @ValidacionXML_Persona varchar(200)
	
	select @xml_Persona = dbo.fCC_ConsultaParametro_Especial( @IdCC)
	set @xml_Persona = isnull(@xml_Persona,'')
	
	----Primero valida la cadena de personas
	--select @ValidacionXML_Persona = dbo.fCC_Valida_XML_Especial(@xml_Persona)

	--if @ValidacionXML_Persona <> 'OK'
	--begin
	--	--manda error
	--	RAISERROR (@ValidacionXML_Persona , 16,-1)
	--	return 0
	--end
	
	--Si no hay error continua
	set @cadenacompleta = '<?xml version="1.0" encoding="ISO-8859-1"?>'
	set  @cadenacompleta = @cadenacompleta + '<Consulta xmlns:xsi="http://www.w3.org/2001/XMLSchema_instance" xsi:noNamespaceSchemaLocation="/Consulta.xsd">'
	select @cadenacompleta = @cadenacompleta + dbo.fCC_Encabezado_Especial()

	select @cadenacompleta = @cadenacompleta + @xml_Persona  --dbo.fCC_Persona_Especial(@codusuario, @Tipo)
	set  @cadenacompleta = @cadenacompleta + '</Consulta>'
	--set  @cadenacompleta = @cadenacompleta + '</xml>'
	
	select @cadenacompleta as ConsultaXML
end
GO