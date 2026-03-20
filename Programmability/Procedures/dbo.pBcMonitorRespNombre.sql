SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

create procedure [dbo].[pBcMonitorRespNombre] (@idmonitor int)
as
begin
	select 
	IdMonitor, isnull(ApePaterno,'') as ApePaterno, isnull(ApeMaterno,'') as ApeMaterno,                 
	isnull(ApeAdicional,'') as ApeAdicional, isnull(PrimerNombre,'') as PrimerNombre, isnull(SegundoNombre,'') as SegundoNombre,              
	dbo.fBcFechaFormato(isnull(FechaNacimiento,'')) as FechaNacimiento, isnull(RFC,'') as RFC, isnull(PrefijoPersona,'') as PrefijoPersona, 
	isnull(SufijoPersona,'') as SufijoPersona, isnull(Nacionalidad,'') as Nacionalidad, isnull(TipoResidencia,'') as TipoResidencia, 
	isnull(NumLicenciaCond,'') as NumLicenciaCond, isnull(EstadoCivil,'') as EstadoCivil, isnull(Genero,'') as Genero, 
	isnull(CedulaProfesional,'') as CedulaProfesional, isnull(IFE,'') as IFE, isnull(CURP,'') as CURP,                 
	isnull(ClavePais,'') as ClavePais, isnull(NumeroDependientes,'') as NumeroDependientes, isnull(EdadesDependientes,'') as EdadesDependientes,             
	dbo.fBcFechaFormato(isnull(FechaRecepcion,'')) as FechaRecepcion, dbo.fBcFechaFormato(isnull(FechaDefuncion,'')) as  FechaRecepcion
	from tBcMonitorRespNombre with(nolock)
	where IdMonitor = @idmonitor
end
GO