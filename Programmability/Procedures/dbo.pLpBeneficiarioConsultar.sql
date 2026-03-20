SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE procedure [dbo].[pLpBeneficiarioConsultar]( @IdProceso int)
as
BEGIN
	select IdBeneficiario, IdProceso,APaterno,AMaterno,Nombres,FecNacimiento,Genero, BeneCodParentesco
	from tLpBeneficiario where IdProceso = @IdProceso
END
GO