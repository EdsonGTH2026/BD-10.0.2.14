SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
create procedure [dbo].[pLpBeneficiarioConsulta](@IdProceso int)
as
BEGIN	
	--Ver. 20-01-2021
	set nocount on
	
	select  
	IdBeneficiario, IdProceso,APaterno,AMaterno,Nombres,
	FecNacimiento,
	Genero, 
	(case Genero 
	when 'M' then 'MASCULINO'
	when 'F' then 'FEMENINO'
	else '' end
	) as GeneroDesc,
	BeneCodParentesco, 
	(case BeneCodParentesco
	when 'ESP' then 'ESPOSO'
    when 'HER' then 'HERMANO'
    when 'HIJ' then 'HIJO'
    when 'PAE' then 'PADRES'
    when 'PAR' then 'PARIENTE'
    when 'AMI' then 'AMIGO'
    else '' end) as BeneParentesco,                            
	FechaAlta,CodUsAlta
	from tLpBeneficiario
	where idproceso = @IdProceso

END
GO