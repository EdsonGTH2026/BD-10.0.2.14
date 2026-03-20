SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
create procedure [dbo].[pLpProcesoRegistra](@IdSolicitud int, @CodSupervisor varchar(20), @IdProceso int output)
as
BEGIN
--Ver. 24-01-2020
	set nocount on
	if not exists(select * from tLpProceso with(nolock) where IdSolicitudPromotor = @IdSolicitud)
	begin
		insert into tLpProceso (IdSolicitudPromotor, CodSupervisor, FechaRegistro, IdEstado, FechaProceso, Activo)
		select IdSolicitudPromotor, @CodSupervisor, getdate(), 0, null, 1 
		from tLpSolicitudPromotor with(nolock) where IdSolicitudPromotor = @IdSolicitud
	end

	select @IdProceso = IdProceso from tLpProceso with(nolock) where IdSolicitudPromotor = @IdSolicitud

	--Registra Proceso
	declare @IdProcesoDet int
	exec pLpProcesoCambioEstado @IdProceso,1,'Nuevo Registro Proceso',@CodSupervisor, @IdProcesoDet output
	--select @IdProcesoDet
	
END
GO