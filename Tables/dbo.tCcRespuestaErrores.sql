CREATE TABLE [dbo].[tCcRespuestaErrores] (
  [IdError] [int] IDENTITY,
  [IdCC] [int] NOT NULL,
  [DescripcionError] [varchar](200) NULL,
  CONSTRAINT [PK_tCcRespuestaErrores] PRIMARY KEY CLUSTERED ([IdError], [IdCC])
)
ON [PRIMARY]
GO

GRANT SELECT ON [dbo].[tCcRespuestaErrores] TO [public]
GO