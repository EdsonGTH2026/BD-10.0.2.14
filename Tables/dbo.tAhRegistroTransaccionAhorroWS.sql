CREATE TABLE [dbo].[tAhRegistroTransaccionAhorroWS] (
  [IdRegistro] [int] IDENTITY,
  [Fecha] [smalldatetime] NULL,
  [Cliente] [varchar](30) NULL,
  [ParametrosWS] [varchar](500) NULL
)
ON [PRIMARY]
GO