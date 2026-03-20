CREATE TABLE [dbo].[tCcConsultaRespuesta] (
  [IdRespuesta] [int] IDENTITY,
  [IdCC] [int] NOT NULL,
  [Respuesta] [varchar](4000) NULL,
  CONSTRAINT [PK_tCcConsultaRespuesta] PRIMARY KEY CLUSTERED ([IdRespuesta], [IdCC]) WITH (FILLFACTOR = 80)
)
ON [PRIMARY]
GO

CREATE INDEX [IX_tCcConsultaRespuesta]
  ON [dbo].[tCcConsultaRespuesta] ([IdCC])
  WITH (PAD_INDEX = ON, FILLFACTOR = 80)
  ON [PRIMARY]
GO

GRANT SELECT ON [dbo].[tCcConsultaRespuesta] TO [public]
GO