CREATE TABLE [dbo].[STPMovimientos] (
  [fecha] [smalldatetime] NULL,
  [hora] [datetime] NULL,
  [destino] [varchar](50) NULL,
  [descripcion] [varchar](500) NULL,
  [abono] [money] NULL,
  [cargo] [money] NULL,
  [saldo] [money] NULL,
  [Procesado] [tinyint] NULL CONSTRAINT [DF_STPMovimientos_Procesado] DEFAULT (0)
)
ON [PRIMARY]
GO