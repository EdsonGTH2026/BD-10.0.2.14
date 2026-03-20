CREATE TABLE [dbo].[tLpClEstado] (
  [IdEstado] [int] NOT NULL,
  [Descripcion] [varchar](20) NULL,
  [Activo] [bit] NOT NULL,
  CONSTRAINT [PK_tLpClEstado] PRIMARY KEY CLUSTERED ([IdEstado])
)
ON [PRIMARY]
GO