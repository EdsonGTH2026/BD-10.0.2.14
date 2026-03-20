SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
create procedure [dbo].[pLDDictaminaEvento] @id int,@tipo varchar(30),@CodUsuario varchar(25),@CodSolicitud varchar(20),@CodOficina varchar(3),@DescripcionAlerta varchar(500)
									,@FechaDictamen smalldatetime,@ReportaAComision char(2),@FechaReporteComision smalldatetime,@CodUsuarioAlta varchar(25)
									,@Coincidencia varchar(20),@ProcedeOperacionInusual varchar(2),@Dictamen varchar(1000)
as
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

--set @id=0
--set @tipo='QeQ Credito'--> solo alta
--set @CodUsuario='6GGA0708881'--'CUM'--> solo alta
--set @CodSolicitud='SOL-0011831'--'XXX'--> solo alta
--set @CodOficina='6'--'98'--> solo alta
--set @DescripcionAlerta='Se encontro coincidencia'--> solo alta
--set @FechaDictamen=null--'20200722'
--set @ReportaAComision='NO'
--set @FechaReporteComision=null
--set @CodUsuarioAlta='curbiza'--> solo alta y en actualiza otro campo
----set @FechaAlta=getdate()--> solo alta
----set @Activo=1--> solo alta
--set @Coincidencia='HOMINIMIA'
--set @ProcedeOperacionInusual='NO'
--set @Dictamen='Se encontro coincidencia completa'

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

		if(@tipo='QeQ Ah-DPF')
		begin
			--select * from finmas.dbo.tUsAhorroQeQ with(nolock)
			update finmas.dbo.tUsAhorroQeQ
			set idregistro=@id
			where nrosolicitud=@CodSolicitud and codusuario=@codusuario
			if(@@error<>0 or @@ROWCOUNT=0)
			begin
				rollback tran
				RAISERROR ('Error al grabar dictamen: %s .', 16, -1, @CodSolicitud)
				return
			end
		end

		if(@tipo='QeQ Ah-Vista')
		begin
			--select * from finmas.dbo.tUsQuienEsQuienAhorroVista as q with(nolock)
			update finmas.dbo.tUsQuienEsQuienAhorroVista
			set idregistro=@id
			where solicitud=@CodSolicitud and codusuario=@codusuario
			if(@@error<>0 or @@ROWCOUNT=0)
			begin
				rollback tran
				RAISERROR ('Error al grabar dictamen: %s .', 16, -1, @CodSolicitud)
				return
			end
		end

		if(@tipo='QeQ Credito')
		begin
			--select * from finmas.dbo.tUsQuienEsQuienCredito as q with(nolock) where fechaalta>='20200715'
			update finmas.dbo.tUsQuienEsQuienCredito
			set idregistro=@id
			where codsolicitud=@CodSolicitud and codoficina=@codoficina and codusuario=@codusuario
			if(@@error<>0 or @@ROWCOUNT=0)
			begin
				rollback tran
				RAISERROR ('Error al grabar dictamen: %s .', 16, -1, @CodSolicitud)
				return
			end
		end

		commit tran

	end
else
	begin

		update tPLDDictamentes
		set FechaDictamen=@FechaDictamen,ReportarAComision=@ReportaAComision,FechaReporteComision=@FechaReporteComision
		,Coincidencia=@Coincidencia,ProcedeOperacionInusual=@ProcedeOperacionInusual,Dictamen=@Dictamen
		,fechamodifica=getdate(),usuariomodifica=@CodUsuarioAlta
		where idregistro=@id

	end
GO