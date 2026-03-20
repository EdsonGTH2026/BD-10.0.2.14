CREATE TABLE [dbo].[tAhTranDiariaRecibeSPEIDev] (
  [IdOperacion] [int] IDENTITY,
  [IdTransaccion] [int] NULL,
  [Estado] [varchar](20) NULL,
  [Motivo] [varchar](50) NULL,
  [FechaOperacion] [smalldatetime] NULL,
  [ClaveRastreo] [varchar](60) NULL,
  [Cadena] [varchar](5000) NULL,
  PRIMARY KEY CLUSTERED ([IdOperacion])
)
ON [PRIMARY]
GO