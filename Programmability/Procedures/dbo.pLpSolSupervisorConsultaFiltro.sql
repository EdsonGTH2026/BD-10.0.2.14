SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
create procedure [dbo].[pLpSolSupervisorConsultaFiltro](@CodPromotor varchar(20), @IdEstado int, @NombreCliente varchar(50))
as
BEGIN
	--ver. 22-02-2021, nuevo
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
	and isnull(p.idestado,0) = (case when @IdEstado<> -1 then @IdEstado else isnull(p.idestado,0) end)
	and sp.NombreCompleto like '%' + (case when len(@NombreCliente) > 0 then @NombreCliente else sp.NombreCompleto end) + '%'
	order by sp.FechaRegistro desc --, isnull(p.IdProceso,0) desc

END
GO