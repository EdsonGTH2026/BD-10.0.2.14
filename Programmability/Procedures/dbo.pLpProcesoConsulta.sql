SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
create procedure [dbo].[pLpProcesoConsulta] @IdProceso int
as
BEGIN
	--Ver. 25-01-2021
	set nocount on
	
	select 
	p.IdProceso, p.IdSolicitudPromotor, p.CodSupervisor,p.FechaRegistro,
	p.IdEstado, cle.Descripcion as Estado,
	p.FechaProceso,p.Activo, isnull(p.AvisoPrivacidadAceptado,'') as AvisoPrivacidadAceptado, isnull(p.AvisoPrivacidadFecha,'') as AvisoPrivacidadFecha 
	from tLpProceso as p with(nolock)
	inner join tLpClEstado as cle with(nolock) on cle.IdEstado = p.IdEstado
	where p.idproceso = @IdProceso
	
END

GO