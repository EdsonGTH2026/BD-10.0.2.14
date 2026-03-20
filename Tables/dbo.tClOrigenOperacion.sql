CREATE TABLE [dbo].[tClOrigenOperacion] (
  [IdOrigen] [int] IDENTITY,
  [OrigenOperacion] [varchar](10) NULL,
  [Descripcion] [varchar](50) NULL,
  PRIMARY KEY CLUSTERED ([IdOrigen])
)
ON [PRIMARY]
GO