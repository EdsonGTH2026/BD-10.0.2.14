CREATE TABLE [dbo].[tBcClRazonScore] (
  [CodigoRazon] [varchar](3) NOT NULL,
  [Descripcion] [varchar](100) NULL,
  [Activo] [tinyint] NOT NULL,
  CONSTRAINT [PK_tBcClRazonScore] PRIMARY KEY CLUSTERED ([CodigoRazon])
)
ON [PRIMARY]
GO

GRANT SELECT ON [dbo].[tBcClRazonScore] TO [public]
GO