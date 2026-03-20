CREATE TABLE [dbo].[tCcRespuestaEstadisticaFinanciera] (
  [IdEstadistica] [int] IDENTITY,
  [IdCC] [int] NOT NULL,
  [FechaMontoPagarMaximo] [varchar](10) NULL,
  [MontoPagarMaximo] [varchar](9) NULL,
  [MontoPagarPromedio] [varchar](9) NULL,
  [FechaSaldoMaximo] [varchar](10) NULL,
  [SaldoMaximo] [varchar](9) NULL,
  [SaldoPromedio] [varchar](9) NULL,
  [FechaSaldoVencidoMaximo] [varchar](10) NULL,
  [SaldoVencidoMaximo] [varchar](9) NULL,
  [SaldoVencidoPromedio] [varchar](9) NULL,
  CONSTRAINT [PK_tCcRespuestaEstadisticaFinanciera] PRIMARY KEY CLUSTERED ([IdEstadistica], [IdCC])
)
ON [PRIMARY]
GO

GRANT SELECT ON [dbo].[tCcRespuestaEstadisticaFinanciera] TO [public]
GO