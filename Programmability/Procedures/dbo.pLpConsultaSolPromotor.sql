SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
create procedure [dbo].[pLpConsultaSolPromotor](@CodPromotor varchar(20))
as
BEGIN
--ver 17-01-2021

	set nocount on
	select s.IdSolicitudPromotor, s.NombreCompleto, s.CURP, s.FechaNacimiento, s.NumCelular ,
	(case isnull(p.IdEstado,-1)
	when -1 then 'PENDIENTE'
	else 'EN PROCESO'
	end) as EstadoRegistro
	from tLpSolicitudPromotor as s with(nolock)
	left join tLpProceso as p with(nolock) on p.IdSolicitudPromotor = s.IdSolicitudPromotor
	where 
	s.activo = 1
	and s.codpromotor = @CodPromotor
	order by s.IdSolicitudPromotor desc,s.fecharegistro desc
END
GO