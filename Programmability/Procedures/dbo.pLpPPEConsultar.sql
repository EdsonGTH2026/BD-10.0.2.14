SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE procedure [dbo].[pLpPPEConsultar]( @IdProceso int)
as
BEGIN
	select IdPPE,IdProceso,EsPersonaExpuesta, CargoPublico,DependenciaCargo,TieneParentesco, ParienteApePat,ParienteApeMat,ParienteNombres,ParienteParentesco,ParienteCargoPublico,ParienteDependenciaCargo 
	from tLpPPE where IdProceso = @IdProceso
END
GO