SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
create procedure [dbo].[pLpUsuarioPassVerifica] (@Usuario varchar(20), @Contrasena varchar(20))
as
BEGIN
	set nocount on
	
	declare @clave_tmp varchar(50)
	
	SELECT @clave_tmp=u.Contrasena
	FROM tLpProcesoLlave u with(nolock)
	where u.Usuario=@Usuario and u.activo=1
	
	set @clave_tmp = isnull(@clave_tmp,'')
	--if(@clave_tmp<>dbo.fdumd5(dbo.fdumd5(@clave)))
	if(@clave_tmp<>@Contrasena )
	begin
		select 0 respuesta,'Incorrecto' Usuario,'' CodUsuario,'' nombres,'' paterno
		return
	end
	
	select 1 as respuesta, pl.Usuario as CodUsuario, pl.Usuario, sp.NombreCompleto as nombres, '' as paterno, null as perfil, null as opciones, null as nombresopcion, null as objetos, null as permisos
	from tLpProcesoLlave as pl
	inner join tLpProceso as p on p.idproceso = pl.idproceso
	inner join tLpSolicitudPromotor as sp on sp.IdSolicitudPromotor = p.IdSolicitudPromotor
	where pl.Usuario = @Usuario 
	and pl.Contrasena = @Contrasena
	and pl.activo = 1
END
GO