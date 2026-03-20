CREATE TABLE [dbo].[tCcRespuestaScore_QA] (
  [IdScore] [int] IDENTITY,
  [IdCC] [int] NOT NULL,
  [NombreScore] [varchar](20) NULL,
  [Codigo] [varchar](3) NULL,
  [Valor] [varchar](4) NULL,
  [Razon1] [varchar](3) NULL,
  [Razon2] [varchar](3) NULL,
  [Razon3] [varchar](3) NULL,
  [Razon4] [varchar](3) NULL,
  [Error] [varchar](3) NULL,
  [Indicadores] [varchar](10) NULL
)
ON [PRIMARY]
GO