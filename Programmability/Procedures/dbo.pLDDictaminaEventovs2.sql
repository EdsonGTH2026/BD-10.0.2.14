SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE procedure [dbo].[pLDDictaminaEventovs2] @id int,@tipo varchar(30),@CodUsuario varchar(25),@CodSolicitud varchar(20),@CodOficina varchar(3),@DescripcionAlerta varchar(500)
									,@FechaDictamen smalldatetime,@ReportaAComision char(2),@FechaReporteComision smalldatetime,@CodUsuarioAlta varchar(25)
									,@Coincidencia varchar(20),@ProcedeOperacionInusual varchar(2),@Dictamen varchar(1000),@VoBo tinyint
as
--ver 14-08-2020: se agrego codigo para actualiza la tabla de tUsQuienEsQuienAhorroRenovacion cuando aplique
--ver 25-08-2020: se agrego codigo para actualiza la tabla de tUsQuienEsQuienAhorroRenovacion cuando aplique y se separo de Nuevos

--SELECT * FROM tPLDDictamentes

--declare @id int
--declare @tipo varchar(30)
--declare @CodUsuario  varchar(25)
--declare @CodSolicitud  varchar(20)
--declare @CodOficina  varchar(3)
--declare @DescripcionAlerta  varchar(500)
----Archivodicamentelocal
----Archivodictamenteservidor
--declare @FechaDictamen smalldatetime
--declare @ReportaAComision char(2)
--declare @FechaReporteComision smalldatetime
--declare @CodUsuarioAlta varchar(25)
----declare @FechaAlta smalldatetime
----declare @Activo int
--declare @Coincidencia varchar(20)
--declare @ProcedeOperacionInusual varchar(2)
--declare @Dictamen varchar(1000)
--declare @VoBo tinyint

--set @id=1052
--set @tipo='QeQ Ah-Vista'--'QeQ Credito'--> solo alta
--set @CodUsuario='DMJ780519M7597'--'CUM'--> solo alta
--set @CodSolicitud='09811306001071'--'XXX'--> solo alta
--set @CodOficina='98'--'98'--> solo alta
--set @DescripcionAlerta='Coincidencia:67%; Lista: VENC; Estatus: 8 años'--> solo alta
--set @FechaDictamen='20200806'--'20200722'
--set @ReportaAComision='NO'
--set @FechaReporteComision=null
--set @CodUsuarioAlta='curbiza'--> solo alta y en actualiza otro campo
----set @FechaAlta=getdate()--> solo alta
----set @Activo=1--> solo alta
--set @Coincidencia='HOMINIMIA'
--set @ProcedeOperacionInusual='NO'
--set @Dictamen='Se autoriza continuar con la apertura'
--set @VoBo=null--0

--exec pLDDictaminaEventovs2 1052 ,'QeQ Ah-Vista' ,'DMJ780519M7597' ,'09811306001071' ,'98' ,'Coincidencia:67%; Lista: VENC; Estatus: 8 años' 
--,'20200806' ,'NO' ,null ,'CURBIZA' ,'HOMONIMIA' ,'NO' ,'Se autoriza continuar con la apertura' ,0 

set nocount on

if(not exists(select 1 from tPLDDictamentes with(nolock) where idregistro=@id))
	begin
		begin tran
		
		SELECT @id=isnull(count(idregistro),0)+1 FROM tPLDDictamentes with(nolock)

		insert into tPLDDictamentes 
			(idregistro,Tipo,CodUsuario,CodSolicitud,CodOficina,DescripcionAlerta,FechaDictamen,ReportarAComision
			,FechaReporteComisión,CodUsuarioAlta,FechaAlta,Activo,Coincidencia,ProcedeOperacionInusual,Dictamen)
		values (@id, @tipo,@codusuario,@CodSolicitud,@CodOficina,@DescripcionAlerta,@FechaDictamen,@ReportaAComision
			,@FechaReporteComision,@CodUsuarioAlta,getdate(),1,@Coincidencia,@ProcedeOperacionInusual,@Dictamen)
		if(@@error<>0 or @@ROWCOUNT=0)
		begin
			rollback tran
			RAISERROR ('Error al grabar dictamen: %s .', 16, -1, @CodSolicitud)
			return
		end

		if(@tipo='QeQ Ah-DPF-N')  --DPF NEUVOS
		begin
			if exists(select * from finmas.dbo.tUsAhorroQeQ where nrosolicitud=@CodSolicitud and codusuario=@codusuario)
			begin  --QeQ Originacion
				--select * from finmas.dbo.tUsAhorroQeQ with(nolock)
				update finmas.dbo.tUsAhorroQeQ
				set idregistro=@id
				,RptaEvento=@VoBo
				,FechaRptaEvento=case when @VoBo is null then null else getdate() end
				where nrosolicitud=@CodSolicitud and codusuario=@codusuario
				if(@@error<>0 or @@ROWCOUNT=0)
				begin
					rollback tran
					RAISERROR ('Error al grabar QeQ Ah-DPF-N Originacion: %s .', 16, -1, @CodSolicitud)
					return
				end
			end	
		end

		if(@tipo='QeQ Ah-DPF-R')  --DPF RENOVACION
		begin

			if exists(select * from finmas.dbo.tUsQuienEsQuienAhorroRenovacion where nrosolicitud=@CodSolicitud and codusuario=@codusuario)
			begin  --QeQ Renovacion
				--select top 100 * from finmas.dbo.tUsQuienEsQuienAhorroRenovacion with(nolock)
				update finmas.dbo.tUsQuienEsQuienAhorroRenovacion
				set idregistro=@id
				,RptaEvento=@VoBo
				,FechaRptaEvento=case when @VoBo is null then null else getdate() end
				where nrosolicitud=@CodSolicitud and codusuario=@codusuario
				if(@@error<>0 or @@ROWCOUNT=0)
				begin
					rollback tran
					RAISERROR ('Error al grabar QeQ Ah-DPF-R Renovacion: %s .', 16, -1, @CodSolicitud)
					return
				end
			end
		end

		if(@tipo='QeQ Ah-Vista')
		begin
			--select * from finmas.dbo.tUsQuienEsQuienAhorroVista as q with(nolock)
			update finmas.dbo.tUsQuienEsQuienAhorroVista
			set idregistro=@id
			,RptaEvento=@VoBo
			,FechaRptaEvento=case when @VoBo is null then null else getdate() end
			where solicitud=@CodSolicitud and codusuario=@codusuario
			if(@@error<>0 or @@ROWCOUNT=0)
			begin
				rollback tran
				RAISERROR ('Error al grabar QeQ Ah-Vista: %s .', 16, -1, @CodSolicitud)
				return
			end
		end

		if(@tipo='QeQ Credito')
		begin
			select @id,@VoBo,FechaRptaEvento=case when @VoBo is null then null else getdate() end,@CodSolicitud,@codoficina,@codusuario
			
			select top 10 * from finmas.dbo.tUsQuienEsQuienCredito where CodSolicitud = @CodSolicitud and CodOficina=@codoficina

			--select * from finmas.dbo.tUsQuienEsQuienCredito as q with(nolock) where fechaalta>='20200715'
			update finmas.dbo.tUsQuienEsQuienCredito
			set idregistro=@id
			,RptaEvento=@VoBo
			,FechaRptaEvento=case when @VoBo is null then null else getdate() end
			where codsolicitud=@CodSolicitud and codoficina=@codoficina and codusuario=@codusuario
			if(@@error<>0 or @@ROWCOUNT=0)
			begin
				rollback tran
				RAISERROR ('Error al grabar QeQ Credito : %s .', 16, -1, @CodSolicitud)
				return
			end
		end

		commit tran

	end
else
	begin
		begin tran
		update tPLDDictamentes
		set FechaDictamen=@FechaDictamen,ReportarAComision=@ReportaAComision,FechaReporteComision=@FechaReporteComision
		,Coincidencia=@Coincidencia,ProcedeOperacionInusual=@ProcedeOperacionInusual,Dictamen=@Dictamen
		,fechamodifica=getdate(),usuariomodifica=@CodUsuarioAlta
		where idregistro=@id
		if(@@error<>0 or @@ROWCOUNT=0)
			begin
				rollback tran
				RAISERROR ('Error al grabar dictamen: %s .', 16, -1, @CodSolicitud)
				return
			end


		if(@tipo='QeQ Ah-DPF-N')  --DPF NEUVOS
		begin
			if exists(select * from finmas.dbo.tUsAhorroQeQ where nrosolicitud=@CodSolicitud and codusuario=@codusuario)
			begin  --QeQ Originacion
				--select * from finmas.dbo.tUsAhorroQeQ with(nolock)
				update finmas.dbo.tUsAhorroQeQ
				set idregistro=@id
				,RptaEvento=@VoBo
				,FechaRptaEvento=case when @VoBo is null then null else getdate() end
				where nrosolicitud=@CodSolicitud and codusuario=@codusuario
				if(@@error<>0 or @@ROWCOUNT=0)
				begin
					rollback tran
					RAISERROR ('Error al grabar QeQ Ah-DPF-N Originacion: %s .', 16, -1, @CodSolicitud)
					return
				end
			end	
		end

		if(@tipo='QeQ Ah-DPF-R')  --DPF RENOVACION
		begin

			if exists(select * from finmas.dbo.tUsQuienEsQuienAhorroRenovacion where nrosolicitud=@CodSolicitud and codusuario=@codusuario)
			begin  --QeQ Renovacion
				--select top 100 * from finmas.dbo.tUsQuienEsQuienAhorroRenovacion with(nolock)
				update finmas.dbo.tUsQuienEsQuienAhorroRenovacion
				set idregistro=@id
				,RptaEvento=@VoBo
				,FechaRptaEvento=case when @VoBo is null then null else getdate() end
				where nrosolicitud=@CodSolicitud and codusuario=@codusuario
				if(@@error<>0 or @@ROWCOUNT=0)
				begin
					rollback tran
					RAISERROR ('Error al grabar QeQ Ah-DPF-R Renovacion: %s .', 16, -1, @CodSolicitud)
					return
				end
			end
		end

		if(@tipo='QeQ Ah-Vista')
		begin
			update finmas.dbo.tUsQuienEsQuienAhorroVista
			set RptaEvento=@VoBo
			,FechaRptaEvento=case when @VoBo is null then null else getdate() end
			where solicitud=@CodSolicitud and codusuario=@codusuario
			if(@@error<>0 or @@ROWCOUNT=0)
			begin
				rollback tran
				RAISERROR ('Error al grabar QeQ Ah-Vista: %s .', 16, -1, @CodSolicitud)
				return
			end
		end

		if(@tipo='QeQ Credito')
		begin
			--select * from finmas.dbo.tUsQuienEsQuienCredito as q with(nolock) where fechaalta>='20200715'
			update finmas.dbo.tUsQuienEsQuienCredito
			set RptaEvento=@VoBo
			,FechaRptaEvento=case when @VoBo is null then null else getdate() end
			where codsolicitud=@CodSolicitud and codoficina=@codoficina and codusuario=@codusuario
			if(@@error<>0 or @@ROWCOUNT=0)
			begin
				rollback tran
				RAISERROR ('Error al actualizar QeQ Credito: %s .', 16, -1, @CodSolicitud)
				return
			end
		end

		commit tran
	end




GO