CREATE TABLE [dbo].[tCcRespuestaMensaje] (
  [IdMensaje] [int] IDENTITY,
  [IdCC] [int] NOT NULL,
  [TipoMensaje] [varchar](2) NULL,
  [Leyenda] [varchar](100) NULL,
  CONSTRAINT [PK_tCcRespuestaMensaje] PRIMARY KEY CLUSTERED ([IdMensaje], [IdCC])
)
ON [PRIMARY]
GO

GRANT SELECT ON [dbo].[tCcRespuestaMensaje] TO [public]
GO