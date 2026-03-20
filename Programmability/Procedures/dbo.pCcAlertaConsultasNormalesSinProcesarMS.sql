SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
create procedure [dbo].[pCcAlertaConsultasNormalesSinProcesarMS] (@Resultado varchar(8000) output)
as
BEGIN
	set nocount on
	set @Resultado = 'OK'

	create table #tmpTabla(
	Id int identity,
	Valor varchar(300) not null
	)

	--Inserta valores en tabla temporal
	insert into #tmpTabla (Valor)
	
	select 
	'IdCC[' +convert(varchar,idcc) + '],' + 
	'FechaRegistro[' + convert(varchar,FechaRegistro,120) + '], Procesado[' + convert(varchar,Procesado) + 
	'], Fec Respuesta[' + isnull(convert(varchar,FechaRespuesta),'') + '], Respuesta[' + isnull(Respuesta,'') +
	'], NumConsulta[' + isnull(convert(varchar,NumConsultas),'') + ']' as Descripcion
	from tccconsulta 
	where Activo = 1 and tipo <> 'E' and procesado <> 1 --and len(respuesta) > 23	
	
	-----------------------------
	declare @TotReg int
	declare @Reg int
	declare @Valor varchar(200)
	select @TotReg = count(*) from #tmpTabla

	if @TotReg > 0
	begin

	set @Reg = 1
		set @Resultado = 'Verificar las Consultas de CC, no han sido procesados correctamente: ' + char(13) + char(10)
		
		while @Reg <= @TotReg
		begin
			select @Valor = valor from #tmpTabla where id = @Reg
			set @Resultado = @Resultado + @Valor + ' ' + char(13)
			set @Reg = @Reg + 1
		end
	end

	print @Resultado

	drop table #tmpTabla
	
END

GO