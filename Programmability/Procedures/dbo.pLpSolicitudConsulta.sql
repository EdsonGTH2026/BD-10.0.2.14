SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
create procedure [dbo].[pLpSolicitudConsulta](@IdProceso int)
as
BEGIN	
	--Ver. 20-01-2021
	set nocount on
	select  
	IdSolicitud, 
	CodProducto, 
	(case CodProducto
	when '211' then 'INVERSIÓN FINAMIGO' 
	else '?' end ) as Producto,
	Plazo,
	Monto,
	CodTipoInteres,
	(case CodTipoInteres
	when 1 then 'AL VENCIMIENTO' 
	when 2 then 'PERIODICO' 
	else '?' end ) as TipoInteres
	from tLpSolicitud
	where idproceso = @IdProceso

END
GO