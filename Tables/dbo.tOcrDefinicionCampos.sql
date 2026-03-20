CREATE TABLE [dbo].[tOcrDefinicionCampos] (
  [IdCampo] [int] NOT NULL,
  [IdModelo] [int] NOT NULL,
  [IdTipoDocumento] [int] NOT NULL,
  [Campo] [varchar](30) NOT NULL,
  [Orden] [int] NOT NULL,
  [Validar] [bit] NOT NULL,
  [SP] [varchar](50) NULL,
  [Activo] [bit] NOT NULL,
  CONSTRAINT [PK_tOcrDefinicionCampos] PRIMARY KEY CLUSTERED ([IdCampo])
)
ON [PRIMARY]
GO