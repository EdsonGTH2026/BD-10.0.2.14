CREATE TABLE [dbo].[tMSTareasResultados] (
  [IdResultado] [int] IDENTITY,
  [IdTareaSP] [int] NOT NULL,
  [FechaHora] [smalldatetime] NOT NULL,
  [Resultado] [varchar](8000) NOT NULL,
  CONSTRAINT [PK_tMSTareasResultados] PRIMARY KEY CLUSTERED ([IdResultado])
)
ON [PRIMARY]
GO