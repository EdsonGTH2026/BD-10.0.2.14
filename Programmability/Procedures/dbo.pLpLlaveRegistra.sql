SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
create procedure [dbo].[pLpLlaveRegistra] (
@IdProceso int, --@Llave varchar(20), 
@UrlCorta varchar(100), @UrlLarga varchar(250), 
@Usuario varchar(20), @Password varchar(20), 
@Token varchar(500), 
@CodUsAlta varchar(20), @IdLlave int output )
as
BEGIN
	--ver. 29-01-2020
	set nocount on
	
	--Genera la llave
	declare @Llave varchar(20)
	set @Llave = ''
		
	--SELECT dbo.fLpCustomPass(20,'CN'), 'Letras y Números'--Cadena aleatoria que contiene Letras y Números.
	--SELECT dbo.fLpCustomPass(15,'C'), 'Letras y Números'
	--SELECT dbo.fLpCustomPass(15,'N'), 'Letras y Números'
	if not exists(select * from tLpProcesoLlave where idproceso = @IdProceso)
		begin		
			while ( exists(select Llave from tLpProcesoLlave with(nolock) where Llave = @Llave ) or @Llave= '' )
			begin
				--print 'genera llave'
				SELECT @Llave = dbo.fLpCustomPass(20,'CN')
			end
			--print 'Nueva Llave: ' + @Llave
		end
	else
	begin
		select @Llave = Llave from tLpProcesoLlave where idproceso = @IdProceso
	end	
	-------------------------------- Usuario
	--declare @Curp varchar(20)
	--declare @User1 varchar(20)
	--declare @User2 varchar(10)
	--declare @User varchar(20)
	--if not exists(select * from tLpProcesoLlave where idproceso = @IdProceso)
	--	begin
	--		select @Curp = up.CURP 
	--		from 
	--		tLpSolicitudPromotor as up with(nolock) 
	--		inner join tLpProceso as p with(nolock) on p.IdSolicitudPromotor = up.IdSolicitudPromotor
	--		where p.idproceso = @IdProceso
		    
	--		set @User1 = left(@Curp,6)    
	--		SELECT @User2 = dbo.fLpCustomPass(6,'N')    
	--		set @User = rtrim(@User1) + rtrim(@User2)
	--	end
	--else
	--	begin
	--		select @User = Usuario from tLpProcesoLlave with(nolock)  where idproceso = @IdProceso
	--	end
	
	-------------------------------- Password	
	--SELECT @Password = dbo.fLpCustomPass(8,'N') 	
		
	------------------------------
	select @UrlCorta = Descripcion from tLpClConfiguracion with(nolock) where Activo = 1 and Tipo= 'LpUrl'	
	set @UrlCorta = @UrlCorta + @Llave
	
	--if not exists(select * from tLpProcesoLlave where idproceso = @IdProceso and Llave= @Llave )
	if not exists(select IdProceso from tLpProcesoLlave with(nolock) where Llave= @Llave )
	begin
		--print 'insert'
		insert into tLpProcesoLlave(IdProceso,Llave,UrlCorta,UrlLarga,Usuario,Contrasena,Token,Activo, FechaHora,CodUsAlta)
		values (@IdProceso,@Llave,@UrlCorta,@UrlLarga,@Usuario,@Password,@Token,1, getdate(),@CodUsAlta)
	end
	else
	begin
		--print 'update'		
		update tLpProcesoLlave set
		UrlCorta=@UrlCorta,UrlLarga=@UrlLarga, 
		Contrasena=@Password, 
		Token=@Token, CodUsAlta = @CodUsAlta, Activo = 1
		where idproceso = @IdProceso and Llave= @Llave --and Usuario = @Usuario 		
	end
	
	select @IdLlave= IdLlave from tLpProcesoLlave with(nolock) where idproceso = @IdProceso and Llave= @Llave and Activo = 1 
	
	select IdLlave, IdProceso, Llave, UrlCorta, UrlLarga, Usuario, Contrasena 
	from tLpProcesoLlave with(nolock)  where idproceso = @IdProceso and Llave= @Llave and Activo = 1 
	--set @IdLlave = 233
END
GO