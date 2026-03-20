SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE procedure [dbo].[pCcRC_Generales] (@IdCC int)
as
set nocount on
--declare @IdCC int
--set @IdCC=215581

	declare @NumProd varchar(2)
	select @NumProd = substring(consulta,(patindex('%<ProductoRequerido>%', consulta ) +19), (patindex('%</ProductoRequerido>%', consulta )-(patindex('%<ProductoRequerido>%', consulta ) +19))) 
	from tCcConsulta with(nolock) 
	where idcc = @IdCC

	select 
	c.IdCC, c.FechaRespuesta,
	re.FolioConsultaOtorgante, re.ClaveOtorgante, re.ExpedienteEncontrado, re.FolioConsulta ,
	rn.ApellidoPaterno, rn.ApellidoMaterno, rn.ApellidoAdicional, rn.Nombres, 
	rn.FechaNacimiento, rn.RFC, rn.CURP, rn. NumeroSeguridadSocial, rn.Nacionalidad, rn.Residencia, rn.EstadoCivil, 
	rn.Sexo, rn.ClaveElectorIFE, rn.NumeroDependientes, rn.FechaDefuncion,
	(case 
	when @NumProd = '9' then 'Reporte de Crédito Consolidado'
	when @NumProd = '26' then 'Reporte de Crédito Consolidado con FICO Score'
	when @NumProd = '75' then 'Renueva Básico'
	when @NumProd = '77' then 'Renueva Básico con Fico Score'
	when @NumProd = '76' then 'Renueva Consolidado'
	when @NumProd = '78' then 'Renueva Consolidado con Fico Score'
	else 'Reporte Crédito'
	end) as ProductoCC
	from 
	tCcConsulta as c with(nolock)
	inner join tCcRespuestaEncabezado as re with(nolock) on re.IdCC = c.IdCC
	inner join tCcRespuestaNombre as rn with(nolock) on rn.IdCC = re.IdCC 
	where re.IdCC = @IdCC

GO