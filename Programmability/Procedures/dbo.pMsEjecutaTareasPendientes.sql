SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
create procedure [dbo].[pMsEjecutaTareasPendientes]
as
BEGIN
	--Ver. 19-10-2020
	set nocount on
	declare @Reg int
	declare @TotReg int
	declare @DiaLetra varchar(2)

	declare @IdTareaSP int
	declare @HoraIni smalldatetime
	declare @HoraFin smalldatetime
	declare @Dias varchar(20) 
	declare @RepetirNumMinutos int
	declare @Sp  varchar(100)
	declare @Correos varchar(400)
	declare @Asunto varchar(200)

	create table #tabla(
	Id int identity,
	IdTareaSP int not null,
	HoraIni smalldatetime not null,
	HoraFin smalldatetime not null,
	Dias varchar(20) not null,
	RepetirNumMinutos int not null,
	Sp varchar(60) not null,
	Correos varchar (400) not null,
	Asunto varchar(200) not null
	)

	--Inserta los datos en la tabla temporal
	insert into #tabla(IdTareaSP,HoraIni,HoraFin,Dias,RepetirNumMinutos,Sp,Correos,Asunto)
	select IdTareaSP, HoraIni,HoraFin,Dias,RepetirNumMinutos,Sp,Correos,Asunto from tMSTareasSP where activo = 1

	--select * from #tabla
	select @DiaLetra = case DatePart(WeekDay, GetDate()) when 1 then 'DO' when 2 then 'LU' when 3 then 'MA'when 4 then 'MI' when 5 then 'JU' when 6 then 'VI' when 7 then 'SA' end

	select @TotReg = count(*) from #tabla

	set @TotReg = isnull(@TotReg,0)
	set @Reg = 1
	while @Reg <= @TotReg
	begin
		select @IdTareaSP = IdTareaSP,
		@HoraIni = HoraIni, @HoraFin = HoraFin, @Dias = Dias, 
		@RepetirNumMinutos = RepetirNumMinutos, @Sp = Sp, @Correos = Correos, @Asunto = Asunto
		from #tabla where id = @Reg		
		
		print '====================================================================='
		print '@IdTareaSP[' + convert(varchar,@IdTareaSP) +'], @HoraIni[' + convert(varchar,@HoraIni,112) + '],@HoraFin[' + convert(varchar,@HoraFin,112) + '],@Dias[' + convert(varchar,@Dias) + '],@RepetirNumMinutos[' + convert(varchar,@RepetirNumMinutos) + '],@Sp[' + convert(varchar,@Sp) + ']'
		--select @IdTareaSP,@HoraIni,@HoraFin,@Dias,@RepetirNumMinutos,@Sp,@Correos,@Asunto
		
		select convert(varchar, @HoraIni,108) ,convert(varchar, @HoraFin,108), convert(varchar, getdate(),108) 
		if convert(varchar, getdate(),108) >= convert(varchar, @HoraIni,108) and convert(varchar, getdate(),108) <= convert(varchar, @HoraFin,108)
			begin
				print 'Esta dentro de horario'
				--select @DiaLetra,@Dias , patindex('%' + @DiaLetra + '%' ,@Dias)
				if patindex('%' + @DiaLetra + '%' ,@Dias) >0
				begin
					print 'si aplica en el dia ['+ @DiaLetra + ']'				
					select 'Reg. Minutos transcurridos [' + convert(varchar, datediff(mi, isnull(max(FechaHora),''), getdate())) + '] para [' + convert(varchar, @RepetirNumMinutos) +']' from tMSTareasResultados where IdTareaSP = @IdTareaSP and convert(varchar,FechaHora,112) = convert(varchar,getdate(),112)
					if (select datediff(mi, isnull(max(FechaHora),''), getdate()) from tMSTareasResultados where IdTareaSP = @IdTareaSP and convert(varchar,FechaHora,112) = convert(varchar,getdate(),112) ) > @RepetirNumMinutos
					begin
						print 'ya pasaron mas de [' + convert(varchar,@RepetirNumMinutos) +'] min'

						--Ejecuta SP
						exec pMSProcesaTareaSP @IdTareaSP, @Sp, @Correos,@Asunto
					end 
					else
					begin
						print 'no han pasado mas de [' + convert(varchar,@RepetirNumMinutos) +'] min'
					end 
				end
			end
		else
			begin
				print 'No esta dentro de Horario'			
			end 
		
		set @Reg = @Reg +1
	end

	drop table #tabla
END
GO