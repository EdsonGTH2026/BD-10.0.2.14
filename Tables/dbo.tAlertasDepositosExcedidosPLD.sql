CREATE TABLE [dbo].[tAlertasDepositosExcedidosPLD] (
  [Id] [int] IDENTITY,
  [Codigo] [varchar](25) NOT NULL,
  [FraccionCuenta] [varchar](8) NULL,
  [Renovado] [tinyint] NULL,
  [SecuenciaPago] [numeric] NULL,
  [Monto] [money] NULL,
  [CodUsuario] [varchar](15) NULL,
  [RptaRegla] [int] NOT NULL,
  [DictamenObservacion] [varchar](500) NULL,
  [CodSistema] [varchar](3) NOT NULL,
  [CodOficina] [varchar](4) NOT NULL,
  [FechaRespuesta] [datetime] NULL,
  [FechaSistema] [datetime] NOT NULL,
  CONSTRAINT [PK_tAlertasDepositosExcedidosPLD] PRIMARY KEY CLUSTERED ([Id])
)
ON [PRIMARY]
GO