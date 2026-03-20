CREATE TABLE [dbo].[tAlertasPersonasBloqueadas] (
  [Id] [int] IDENTITY,
  [IdPersonaBloqueada] [int] NOT NULL,
  [RptaRegla] [int] NOT NULL,
  [DictamenObservacion] [varchar](500) NULL,
  [CodSistema] [varchar](3) NOT NULL,
  [CodSolicitud] [varchar](15) NOT NULL,
  [CodOficina] [varchar](4) NOT NULL,
  [FechaRespuesta] [datetime] NULL,
  [FechaSistema] [datetime] NOT NULL,
  [CodUsuario] [varchar](15) NULL,
  CONSTRAINT [PK_tAlertasPersonasBloqueadas] PRIMARY KEY CLUSTERED ([Id])
)
ON [PRIMARY]
GO