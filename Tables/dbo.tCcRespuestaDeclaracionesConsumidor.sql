CREATE TABLE [dbo].[tCcRespuestaDeclaracionesConsumidor] (
  [IdCC] [int] NOT NULL,
  [DeclaracionesConsumidor] [varchar](1000) NULL,
  CONSTRAINT [PK_tCcRespuestaDeclaracionesConsumidor] PRIMARY KEY CLUSTERED ([IdCC])
)
ON [PRIMARY]
GO

GRANT SELECT ON [dbo].[tCcRespuestaDeclaracionesConsumidor] TO [public]
GO