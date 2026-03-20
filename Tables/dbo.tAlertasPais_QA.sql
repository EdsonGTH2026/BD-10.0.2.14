CREATE TABLE [dbo].[tAlertasPais_QA] (
  [Id] [int] IDENTITY,
  [CodUsuario] [varchar](15) NULL,
  [RptaRegla] [int] NOT NULL,
  [DictamenObservacion] [varchar](500) NULL,
  [CodSistema] [varchar](3) NOT NULL,
  [CodOficina] [varchar](4) NOT NULL,
  [codpais] [varchar](4) NULL,
  [FechaRespuesta] [datetime] NULL,
  [FechaSistema] [datetime] NOT NULL,
  CONSTRAINT [pktAlertasPais_QA] PRIMARY KEY CLUSTERED ([Id])
)
ON [PRIMARY]
GO