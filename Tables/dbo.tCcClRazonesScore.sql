CREATE TABLE [dbo].[tCcClRazonesScore] (
  [IdRazon] [varchar](2) NOT NULL,
  [Descripcion] [varchar](200) NULL,
  CONSTRAINT [PK_tCcClRazonesScore] PRIMARY KEY CLUSTERED ([IdRazon])
)
ON [PRIMARY]
GO

GRANT SELECT ON [dbo].[tCcClRazonesScore] TO [public]
GO