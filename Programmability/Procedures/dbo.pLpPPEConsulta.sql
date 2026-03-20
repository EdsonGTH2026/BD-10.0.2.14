SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
create procedure [dbo].[pLpPPEConsulta](@IdProceso int)
as
BEGIN	
	--Ver. 20-01-2021
	set nocount on
	
	select  
    IdPPE,IdProceso,EsPersonaExpuesta, CargoPublico,DependenciaCargo,
    TieneParentesco, ParienteApePat,ParienteApeMat,ParienteNombres,
    ParienteParentesco,ParienteCargoPublico,ParienteDependenciaCargo 
	from tLpPPE
	where idproceso = @IdProceso

END
GO