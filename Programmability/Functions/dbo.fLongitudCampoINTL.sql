SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

create function [dbo].[fLongitudCampoINTL] (@Campo varchar(100), @LongMax int = 100)
returns varchar(100)
as
BEGIN
	declare @longitud int
	declare @LogitudText varchar(2)
	declare @Resultado varchar(100)

	set @Campo = rtrim(ltrim(@Campo))
	set @longitud = len(@Campo)

	if @longitud > @LongMax
	begin
		set @Campo = substring(@Campo,1, @LongMax)
		set @longitud = len(@Campo)
	end

	--vueve a calcular la longitud
	set @Campo = rtrim(ltrim(@Campo))
	set @longitud = len(@Campo)

	set @LogitudText = convert(varchar, @longitud)
	if len(@LogitudText) = 1 set @LogitudText = '0' + @LogitudText

	set @Resultado = @LogitudText + @Campo 	

	--por ultimo remplaza los caracteres especiales
	set @Resultado = replace(@Resultado, 'á', 'a')
	set @Resultado = replace(@Resultado, 'é', 'e')
	set @Resultado = replace(@Resultado, 'í', 'i')
	set @Resultado = replace(@Resultado, 'ó', 'o')
	set @Resultado = replace(@Resultado, 'ú', 'u')
	set @Resultado = replace(@Resultado, 'Á', 'A')
	set @Resultado = replace(@Resultado, 'É', 'E')
	set @Resultado = replace(@Resultado, 'Í', 'I')
	set @Resultado = replace(@Resultado, 'Ó', 'O')
	set @Resultado = replace(@Resultado, 'Ú', 'U')
	set @Resultado = replace(@Resultado, 'ñ', 'n')
	set @Resultado = replace(@Resultado, 'Ñ', 'N')

	set @Resultado = upper(@Resultado)
	return @Resultado
END
GO