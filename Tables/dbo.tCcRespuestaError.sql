CREATE TABLE [dbo].[tCcRespuestaError] (
  [IdCC] [int] NOT NULL,
  [ClaveOtorgante] [varchar](10) NULL,
  [FolioConsultaOtorgante] [varchar](25) NULL,
  [ProductoRequerido] [varchar](2) NULL,
  CONSTRAINT [PK_tCcRespuestaError] PRIMARY KEY CLUSTERED ([IdCC])
)
ON [PRIMARY]
GO

GRANT SELECT ON [dbo].[tCcRespuestaError] TO [public]
GO