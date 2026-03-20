SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
create procedure [dbo].[pLpSolSupervisorConsulta](@CodPromotor varchar(20))
as
BEGIN
	--Ver. 19-01-2021
	--ver. 17-02-2021, se quito campo fecha nacimiento
	set nocount on
	
	select distinct
	sp.IdSolicitudPromotor, sp.NombreCompleto as NombreCliente, 
	sp.CURP, --sp.FechaNacimiento, 
	sp.NumCelular,  
	sp.CodPromotor, isnull(up.NombreCompleto,'') as Promotor,
	sp.FechaRegistro,
	isnull(p.IdProceso,0) as IdProceso, 
	isnull(p.CodSupervisor,'') as CodSupervisor, isnull(us.NombreCompleto,'') as Supervisor,
	isnull(p.FechaRegistro,'') as FechaRegistro,
	isnull(p.IdEstado,0) as IdEstado,
	isnull(e.descripcion,'') as Estado
	from tLpSolicitudPromotor as sp
	left join tLpProceso as p on p.IdSolicitudPromotor = sp.IdSolicitudPromotor
	left join tLpClEstado as e on e.idestado = isnull(p.idestado,0)
	left join finmas.dbo.tsgusuarios as up on up.codusuario = sp.CodPromotor
	left join finmas.dbo.tsgusuarios as us on us.codusuario = p.CodSupervisor
	where sp.Activo = 1
	order by sp.FechaRegistro desc --, isnull(p.IdProceso,0) desc

END
GO