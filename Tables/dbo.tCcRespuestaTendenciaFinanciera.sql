CREATE TABLE [dbo].[tCcRespuestaTendenciaFinanciera] (
  [IdCC] [int] NOT NULL,
  [IdTendencia] [varchar](1) NOT NULL,
  [MontoPagar] [varchar](1) NULL,
  [SaldoActual] [varchar](1) NULL,
  [SaldoVencido] [varchar](1) NULL,
  CONSTRAINT [PK_tCcRespuestaTendenciaFinanciera] PRIMARY KEY CLUSTERED ([IdTendencia], [IdCC])
)
ON [PRIMARY]
GO

GRANT SELECT ON [dbo].[tCcRespuestaTendenciaFinanciera] TO [public]
GO