SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[pCCAPI_CrearRespuestaCuentaCC_QA] (@IdCC INT, @FechaActualizacion VARCHAR(10), @RegistroImpugnado VARCHAR(4), 
													       @NombreOtorgante VARCHAR(100), @CuentaActual VARCHAR(25), @TipoResponsabilidad VARCHAR(1), 
														   @TipoCuenta VARCHAR(1), @TipoCredito VARCHAR(2), @ClaveUnidadMonetaria VARCHAR(2),
														   @ValorActivoValuacion VARCHAR(9), @NumeroPagos VARCHAR(4), @FrecuenciaPagos VARCHAR(1),
														   @MontoPagar VARCHAR(9), @FechaAperturaCuenta VARCHAR(10), @FechaUltimoPago VARCHAR(10),
														   @FechaUltimaCompra VARCHAR(10), @FechaReporte VARCHAR(10), @CreditoMaximo VARCHAR(9),
														   @SaldoActual VARCHAR(9), @LimiteCredito VARCHAR(9), @SaldoVencido VARCHAR(9),
														   @NumeroPagosVencidos VARCHAR(4), @PagoActual VARCHAR(3), @HistoricoPagos VARCHAR(200),
														   @TotalPagosReportados VARCHAR(3), @PeorAtraso VARCHAR(2), @FechaPeorAtraso VARCHAR(10),
														   @SaldoVencidoPeorAtraso VARCHAR(10))
AS
BEGIN
	INSERT INTO tCcRespuestaCuenta_QA (IdCC, FechaActualizacion, RegistroImpugnado, ClaveOtorgante, NombreOtorgante, CuentaActual, TipoResponsabilidad, 
									   TipoCuenta, TipoCredito, ClaveUnidadMonetaria, ValorActivoValuacion, NumeroPagos, FrecuenciaPagos, 
									   MontoPagar, FechaAperturaCuenta, FechaUltimoPago, FechaUltimaCompra, FechaCierreCuenta, FechaReporte, 
									   UltimaFechaSaldoCero, Garantia, CreditoMaximo, SaldoActual, LimiteCredito, SaldoVencido, 
									   NumeroPagosVencidos, PagoActual, HistoricoPagos, FechaRecienteHistoricoPagos, FechaAntiguaHistoricoPagos, 
									   ClavePrevencion, TotalPagosReportados, PeorAtraso, FechaPeorAtraso, SaldoVencidoPeorAtraso)
	VALUES (@IdCC, @FechaActualizacion, @RegistroImpugnado, '', @NombreOtorgante, @CuentaActual, @TipoResponsabilidad, @TipoCuenta, @TipoCredito,
			@ClaveUnidadMonetaria, @ValorActivoValuacion, @NumeroPagos, @FrecuenciaPagos, @MontoPagar, @FechaAperturaCuenta, @FechaUltimoPago,
			@FechaUltimaCompra, '', @FechaReporte, '', '', @CreditoMaximo, @SaldoActual, @LimiteCredito, @SaldoVencido, @NumeroPagosVencidos, 
			@PagoActual, @HistoricoPagos, '', '', '', @TotalPagosReportados, @PeorAtraso, @FechaPeorAtraso, @SaldoVencidoPeorAtraso)
END
GO