CREATE TABLE [dbo].[tOCRModeloSeccion] (
  [IdSeccion] [int] IDENTITY,
  [IdModelo] [int] NOT NULL,
  [Seccion] [varchar](30) NOT NULL,
  [X1] [money] NOT NULL,
  [Y1] [money] NOT NULL,
  [X2] [money] NOT NULL,
  [Y2] [money] NOT NULL,
  [Campo] [varchar](20) NULL,
  [Activo] [bit] NOT NULL,
  CONSTRAINT [PK_tOCRModeloSeccion] PRIMARY KEY CLUSTERED ([IdSeccion])
)
ON [PRIMARY]
GO