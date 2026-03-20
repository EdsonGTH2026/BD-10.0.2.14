CREATE TABLE [dbo].[STPMovimProcesados] (
  [fecha] [smalldatetime] NULL,
  [hora] [datetime] NULL,
  [destino] [varchar](50) NULL,
  [abono] [money] NULL,
  [cargo] [money] NULL,
  [saldo] [money] NULL,
  [cliente] [varchar](500) NULL,
  [rfc] [varchar](500) NULL,
  [concepto] [varchar](500) NULL,
  [Clave_Rastreo] [varchar](500) NULL,
  [CtaBeneficiario] [varchar](500) NULL,
  [CtaOrdenante] [varchar](500) NULL
)
ON [PRIMARY]
GO