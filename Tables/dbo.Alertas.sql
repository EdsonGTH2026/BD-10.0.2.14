CREATE TABLE [dbo].[Alertas] (
  [IdAlerta] [int] IDENTITY,
  [Mensaje] [varchar](100) NOT NULL,
  [Tipo] [varchar](5) NOT NULL,
  [Activo] [bit] NULL,
  [FechaCreacion] [smalldatetime] NULL,
  PRIMARY KEY CLUSTERED ([IdAlerta])
)
ON [PRIMARY]
GO