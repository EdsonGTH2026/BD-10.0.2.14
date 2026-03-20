CREATE TABLE [dbo].[tCcRespuestaCuenta] (
  [IdCuenta] [int] IDENTITY,
  [IdCC] [int] NOT NULL,
  [FechaActualizacion] [varchar](10) NULL,
  [RegistroImpugnado] [varchar](4) NULL,
  [ClaveOtorgante] [varchar](10) NULL,
  [NombreOtorgante] [varchar](100) NULL,
  [CuentaActual] [varchar](25) NULL,
  [TipoResponsabilidad] [varchar](1) NULL,
  [TipoCuenta] [varchar](1) NULL,
  [TipoCredito] [varchar](2) NULL,
  [ClaveUnidadMonetaria] [varchar](2) NULL,
  [ValorActivoValuacion] [varchar](9) NULL,
  [NumeroPagos] [varchar](4) NULL,
  [FrecuenciaPagos] [varchar](1) NULL,
  [MontoPagar] [varchar](9) NULL,
  [FechaAperturaCuenta] [varchar](10) NULL,
  [FechaUltimoPago] [varchar](10) NULL,
  [FechaUltimaCompra] [varchar](10) NULL,
  [FechaCierreCuenta] [varchar](10) NULL,
  [FechaReporte] [varchar](10) NULL,
  [UltimaFechaSaldoCero] [varchar](10) NULL,
  [Garantia] [varchar](200) NULL,
  [CreditoMaximo] [varchar](9) NULL,
  [SaldoActual] [varchar](9) NULL,
  [LimiteCredito] [varchar](9) NULL,
  [SaldoVencido] [varchar](9) NULL,
  [NumeroPagosVencidos] [varchar](4) NULL,
  [PagoActual] [varchar](3) NULL,
  [HistoricoPagos] [varchar](200) NULL,
  [FechaRecienteHistoricoPagos] [varchar](10) NULL,
  [FechaAntiguaHistoricoPagos] [varchar](10) NULL,
  [ClavePrevencion] [varchar](2) NULL,
  [TotalPagosReportados] [varchar](3) NULL,
  [PeorAtraso] [varchar](2) NULL,
  [FechaPeorAtraso] [varchar](10) NULL,
  [SaldoVencidoPeorAtraso] [varchar](10) NULL,
  [MontoUltimoPago] [varchar](10) NULL,
  [IdDomicilio] [varchar](20) NULL,
  [Servicios] [varchar](1) NULL,
  CONSTRAINT [PK_tCcRespuestaCuenta] PRIMARY KEY CLUSTERED ([IdCuenta], [IdCC])
)
ON [PRIMARY]
GO

CREATE INDEX [IX_tCcRespuestaCuenta]
  ON [dbo].[tCcRespuestaCuenta] ([IdCC])
  WITH (FILLFACTOR = 70)
  ON [PRIMARY]
GO

GRANT SELECT ON [dbo].[tCcRespuestaCuenta] TO [public]
GO