CREATE TABLE [dbo].[tHeadersServiciosExternos] (
  [idHeader] [int] IDENTITY,
  [idServicio] [int] NULL,
  [nombre] [varchar](30) NULL,
  [valor] [varchar](200) NULL,
  [servicioPrevio] [int] NULL,
  [idServicioPrevio] [int] NULL,
  PRIMARY KEY CLUSTERED ([idHeader])
)
ON [PRIMARY]
GO