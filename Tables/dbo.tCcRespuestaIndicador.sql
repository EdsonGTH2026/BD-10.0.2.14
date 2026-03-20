CREATE TABLE [dbo].[tCcRespuestaIndicador] (
  [IdIndicador] [int] IDENTITY,
  [IdCC] [int] NOT NULL,
  [DescripcionInd] [varchar](30) NULL,
  [ValorInd] [varchar](6) NULL,
  CONSTRAINT [PK_tCcRespuestaIndicador] PRIMARY KEY CLUSTERED ([IdIndicador], [IdCC])
)
ON [PRIMARY]
GO

GRANT SELECT ON [dbo].[tCcRespuestaIndicador] TO [public]
GO