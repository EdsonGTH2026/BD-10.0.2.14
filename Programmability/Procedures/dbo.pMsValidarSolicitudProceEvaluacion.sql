SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
create procedure [dbo].[pMsValidarSolicitudProceEvaluacion] (@Resultado varchar(8000) output)
as
BEGIN
	set nocount on
		
	--declare @Resultado varchar(8000)
	set @Resultado = 'OK'

	create table #tmpTabla(
	Id int identity,
	Valor varchar(300) not null
	)

	insert into #tmpTabla (Valor)
	select 
	'IdProceso[' + convert(varchar,sp.idproceso) + '], CodSolicitud[' + sp.CodSolicitud + '], CodOficina[' + sp.CodOficina + '], FechaEvaluacion[' +
	 convert(varchar,spe.FechaEvaluacion, 120) + '], ValorScore [' + convert(varchar,spe.ValorScore) + ']'
	 from finmas.dbo.tCaSolicitudProceEvaluacion as spe with(nolock)
	inner join  finmas.dbo.tcasolicitudproce as sp  with(nolock) on sp.idproceso = spe.idproceso
	where convert(varchar,spe.FechaEvaluacion,112) >= '20201019'
	and isnull(spe.ValorScore,-1) < 0

	--select * from #tmpTabla


	declare @TotReg int
	declare @Reg int
	declare @Valor varchar(200)
	select @TotReg = count(*) from #tmpTabla

	if @TotReg > 0
	begin

	set @Reg = 1
		set @Resultado = 'Verificar la(s) Evaluacion(es) automaticas de las Solicitud(es), la cual(es) tienen VALORSCORE en negativo: ' + char(13) + char(10)
		
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