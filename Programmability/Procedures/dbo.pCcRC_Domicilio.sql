SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE procedure [dbo].[pCcRC_Domicilio] (@IdCC int)
as
--declare @IdCC int
--set @IdCC=215581
set nocount on
	select 
	c.IdCC, 
	d.IdDom,  d.Direccion, d.ColoniaPoblacion, d.DelegacionMunicipio, d.Ciudad, d.Estado, d.CP,    
	 d.FechaResidencia, d.NumeroTelefono, d.TipoDomicilio, d.TipoAsentamiento, d.FechaRegistroDomicilio, 
	 d.TipoAltaDomicilio, d.NumeroOtorgantesCarga, d.NumeroOtorgantesConsulta, d.IdDomicilio
	from 
		tCcConsulta as c with(nolock)
	left join tCcRespuestaDomicilio as d with(nolock) on c.IdCC = d.IdCC
	where c.IdCC = @IdCC
GO