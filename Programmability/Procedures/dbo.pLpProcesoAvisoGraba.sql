SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
create procedure [dbo].[pLpProcesoAvisoGraba] @IdProceso int, @Acepta bit
as
BEGIN
	--Ver. 25-01-2021
	set nocount on
	
	update tLpProceso set
	 AvisoPrivacidadAceptado = @Acepta,
	 AvisoPrivacidadFecha = getdate()
	where IdProceso = @IdProceso
	
	select AvisoPrivacidadAceptado from tLpProceso where IdProceso = @IdProceso
END
GO