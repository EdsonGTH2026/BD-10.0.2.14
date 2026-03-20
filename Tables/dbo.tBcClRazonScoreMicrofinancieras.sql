CREATE TABLE [dbo].[tBcClRazonScoreMicrofinancieras] (
  [CodigoRazon] [varchar](4) NOT NULL,
  [Descripcion] [varchar](200) NULL,
  [Mensaje] [varchar](30) NULL,
  [Tipo] [varchar](10) NULL,
  [Activo] [tinyint] NOT NULL,
  CONSTRAINT [PK_tBcClRazonScoreMicrofinancieras] PRIMARY KEY CLUSTERED ([CodigoRazon])
)
ON [PRIMARY]
GO

GRANT SELECT ON [dbo].[tBcClRazonScoreMicrofinancieras] TO [public]
GO