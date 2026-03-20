CREATE TABLE [dbo].[tLpClConfiguracion] (
  [IdConfiguracion] [int] IDENTITY,
  [Tipo] [varchar](30) NOT NULL,
  [Valor] [varchar](50) NOT NULL,
  [Descripcion] [varchar](500) NOT NULL,
  [Activo] [bit] NOT NULL,
  CONSTRAINT [PK_tLpClConfiguracion] PRIMARY KEY CLUSTERED ([IdConfiguracion])
)
ON [PRIMARY]
GO