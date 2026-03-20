CREATE TABLE [dbo].[tCcRespuestaEncabezado] (
  [IdCC] [int] NOT NULL,
  [FolioConsultaOtorgante] [varchar](25) NULL,
  [ClaveOtorgante] [varchar](10) NULL,
  [ExpedienteEncontrado] [varchar](1) NULL,
  [FolioConsulta] [varchar](10) NULL,
  CONSTRAINT [PK_tCcRespuestaEncabezado] PRIMARY KEY CLUSTERED ([IdCC])
)
ON [PRIMARY]
GO

GRANT SELECT ON [dbo].[tCcRespuestaEncabezado] TO [public]
GO