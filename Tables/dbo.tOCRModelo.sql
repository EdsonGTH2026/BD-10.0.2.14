CREATE TABLE [dbo].[tOCRModelo] (
  [IdModelo] [int] IDENTITY,
  [Tipo] [varchar](10) NOT NULL,
  [Nombre] [varchar](20) NULL,
  [Descripcion] [varchar](80) NULL,
  [FechaAlta] [smalldatetime] NULL,
  [Activo] [bit] NOT NULL,
  CONSTRAINT [PK_tOCRModelo] PRIMARY KEY CLUSTERED ([IdModelo])
)
ON [PRIMARY]
GO