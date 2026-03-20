SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

create procedure [dbo].[pCC_Valida_XML_Especial](@IdCC int)
as
BEGIN
	declare @Resultado varchar(200)
	set @Resultado = 'OK'
	
	declare @XML_Persona varchar(1500)
	declare @cadena varchar(1500)	
	select @cadena = parametroXML from tCcConsultaEspecialParametro where idcc = @IdCC
	set @cadena = isnull(@cadena,'')
	
	
	if len(ltrim(@cadena)) = 0
	begin
		set @Resultado = 'La cadena XML con los datos de la Persona viene vacia'
		return @Resultado
	end
	
	if patindex('%<Personas>%<Persona>%</Persona>%</Personas>%', @cadena) = 0
	begin 
		set @Resultado = 'No esta bien formado el XML, falta alguna etiqueta de la seccion de Personas'
		return @Resultado
	end

	if patindex('%<DetalleConsulta>%<FolioConsultaOtorgante>%</FolioConsultaOtorgante>%<ProductoRequerido>%</ProductoRequerido>%'+
				'<TipoCuenta>E</TipoCuenta>%<ClaveUnidadMonetaria>%</ClaveUnidadMonetaria>%'+
				'<ImporteContrato>%</ImporteContrato>%<NumeroFirma>%</NumeroFirma>%</DetalleConsulta>%', @cadena) = 0
	begin
		set @Resultado = 'No esta bien formado el XML, falta alguna etiqueta de la seccion de DetalleConsulta.'
		return @Resultado
	end

	if patindex('%<Nombre>%<ApellidoPaterno>%</ApellidoPaterno>%<ApellidoMaterno>%</ApellidoMaterno>%<Nombres>%</Nombres>%' +
				'<FechaNacimiento>%</FechaNacimiento>%<RFC>%</RFC>%<Nacionalidad>%</Nacionalidad>%</Nombre>%', @cadena) = 0
	begin
		set @Resultado = 'No esta bien formado el XML, falta alguna etiqueta de la seccion de Nombre.'
		return @Resultado
	end

	if patindex('%<Domicilios>%<Domicilio>%<Direccion>%</Direccion>%<ColoniaPoblacion>%</ColoniaPoblacion>%' +
				'<DelegacionMunicipio>%</DelegacionMunicipio>%<Ciudad>%</Ciudad>%<Estado>%</Estado>%'+
				'<CP>%</CP>%</Domicilio>%</Domicilios>%', @cadena) = 0
	begin
		set @Resultado = 'No esta bien formado el XML, falta alguna etiqueta de la seccion de Domicilios.'
		return @Resultado
	end
						
	----if patindex('%<Empleos>%<Empleo>%</Empleo>%</Empleos>%', @cadena) = 0
	--if patindex('%<Empleos>%</Empleos>%', @cadena) = 0
	--begin
	--	set @Resultado = 'No esta bien formado el XML, falta alguna etiqueta de la seccion de Empleos.'
	--	return @Resultado
	--end

	----if patindex('%<CuentasReferencia>%<NumeroCuenta />%<NumeroCuenta />%<NumeroCuenta />%</CuentasReferencia>%' , @cadena) = 0
	--if patindex('%<CuentasReferencia>%</CuentasReferencia>%' , @cadena) = 0
	--begin
	--	set @Resultado = 'No esta bien formado el XML, falta alguna etiqueta de la seccion de CuentasReferencia.'
	--	return @Resultado
	--end

	select @Resultado as 'Resultado'
END
GO