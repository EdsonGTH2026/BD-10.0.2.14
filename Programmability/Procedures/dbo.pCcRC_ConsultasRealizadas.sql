SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE procedure [dbo].[pCcRC_ConsultasRealizadas] (@IdCC int)
as
--declare @IdCC int
--set @IdCC=215581
set nocount on
	select 
	c.IdCC, 
	ce.IdConsulta,  ce.FechaConsulta, ce.ClaveOtorgante, ce.NombreOtorgante, ce.DireccionOtorgante,
	ce.TelefonoOtorgante, ce.TipoCredito, ce.ImporteCredito, ce.TipoResponsabilidad, ce.IdDomicilio,          
	ce.Servicios, ce.ClaveUnidadMonetaria
	from 
	tCcConsulta as c with(nolock)
	inner join tCcRespuestaConsultaEfectuada as ce with(nolock) on ce.IdCC = c.IdCC
	where c.IdCC = @IdCC
	order by ce.FechaConsulta
GO