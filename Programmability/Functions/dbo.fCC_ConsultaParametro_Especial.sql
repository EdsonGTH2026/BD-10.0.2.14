SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

create function [dbo].[fCC_ConsultaParametro_Especial](@IdCC int)
returns varchar(1500)
as
BEGIN
	declare @XML_Persona varchar(1500)	
	select @XML_Persona = parametroXML from tCcConsultaEspecialParametro where idcc = @IdCC
	set @XML_Persona = isnull(@XML_Persona,'')
	
	set @XML_Persona = replace(@XML_Persona,'</Domicilios></Persona></Personas>','</Domicilios><Empleos><Empleo></Empleo></Empleos><CuentasReferencia><NumeroCuenta /><NumeroCuenta /><NumeroCuenta /></CuentasReferencia> </Persona></Personas>')
	
	return @XML_Persona
	
END
GO