CREATE TABLE [dbo].[tEcClConfiguracion] (
  [IdConfiguracion] [int] IDENTITY,
  [Tipo] [varchar](30) NOT NULL,
  [Valor] [varchar](100) NOT NULL,
  [Activo] [bit] NOT NULL,
  CONSTRAINT [PK_IdConfiguracion] PRIMARY KEY CLUSTERED ([IdConfiguracion])
)
ON [PRIMARY]
GO