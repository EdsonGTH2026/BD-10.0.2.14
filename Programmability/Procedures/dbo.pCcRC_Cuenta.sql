SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE procedure [dbo].[pCcRC_Cuenta] (@IdCC int)
as
--declare @IdCC int
--set @IdCC=215581
set nocount on
	select 
	c.IdCC,
rc.IdCuenta, rc.FechaActualizacion, rc.RegistroImpugnado, rc.ClaveOtorgante, rc.NombreOtorgante,                          
rc.CuentaActual,  rc.TipoResponsabilidad, rc.TipoCuenta, rc.TipoCredito, rc.ClaveUnidadMonetaria, 
rc.ValorActivoValuacion, rc.NumeroPagos, rc.FrecuenciaPagos, rc.MontoPagar, rc.FechaAperturaCuenta, 
rc.FechaUltimoPago, rc.FechaUltimaCompra, rc.FechaCierreCuenta, rc.FechaReporte, rc.UltimaFechaSaldoCero, rc.Garantia,                                                                                                                                         
                                                        
rc.CreditoMaximo, rc.SaldoActual, rc.LimiteCredito, rc.SaldoVencido, rc.NumeroPagosVencidos, rc.PagoActual, 
rc.HistoricoPagos,  rc.FechaRecienteHistoricoPagos, rc.FechaAntiguaHistoricoPagos, rc.ClavePrevencion, 
rc.TotalPagosReportados, rc.PeorAtraso, rc.FechaPeorAtraso, rc.SaldoVencidoPeorAtraso, rc.MontoUltimoPago, 
rc.IdDomicilio, rc.Servicios
	from 
	tCcConsulta as c with(nolock)
	inner join tCcRespuestaCuenta as rc with(nolock) on rc.IdCC = c.IdCC
	where c.IdCC = @IdCC
GO