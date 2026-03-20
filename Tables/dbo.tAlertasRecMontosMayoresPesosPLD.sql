CREATE TABLE [dbo].[tAlertasRecMontosMayoresPesosPLD] (
  [Id] [int] IDENTITY,
  [Codigo] [varchar](25) NOT NULL,
  [Monto] [money] NOT NULL,
  [CodUsuario] [varchar](15) NULL,
  [NombreCliente] [varchar](120) NULL,
  [RptaRegla] [int] NOT NULL,
  [DictamenObservacion] [varchar](500) NULL,
  [CodSistema] [varchar](3) NOT NULL,
  [CodOficina] [varchar](4) NOT NULL,
  [FechaRespuesta] [datetime] NULL,
  [FechaSistema] [datetime] NOT NULL,
  [SecuenciaPago] [numeric] NULL,
  CONSTRAINT [PK_tAlertasRecMontosMayoresPesosPLD] PRIMARY KEY CLUSTERED ([Id])
)
ON [PRIMARY]
GO