SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

create procedure [dbo].[pOCRPalabraEnTexto] ( @Texto varchar(50), @Palabra varchar(15))
as
BEGIN
	--declare @Texto varchar(50)
	--declare @Palabra varchar(15)
	--set @Texto = 'ANO DE REGISTRO'
	--set @Palabra = '%ano%'

	--set @Texto = 'VIGENCIA'
	--set @Palabra = 'wGENCIA' 

	if @Texto like '%' + @Palabra + '%'
	begin
		--print 'SI'
		select 'SI' as Resultado
	end
	else
	begin
		--print 'NO'
		select 'NO' as Resultado
	end
END
GO