CREATE TABLE [dbo].[tAhTransaccionDiariaRetiraSPEI] (
  [IdTransaccion] [int] NULL,
  [CodCuenta] [varchar](30) NULL,
  [jsonenvio] [varchar](1500) NULL,
  [jsonrespueta] [varchar](1500) NULL,
  [IdSTP] [int] NULL,
  [Estado] [varchar](20) NULL,
  [Detalle] [varchar](200) NULL,
  [DescripcionError] [varchar](200) NULL,
  [FechaHoraTran] [datetime] NULL,
  [Firma] [varchar](500) NULL,
  [Empresa] [varchar](20) NULL,
  [Monto] [money] NULL,
  [FolioOrigen] [varchar](100) NULL,
  [FechaHoraEstado] [datetime] NULL
)
ON [PRIMARY]
GO