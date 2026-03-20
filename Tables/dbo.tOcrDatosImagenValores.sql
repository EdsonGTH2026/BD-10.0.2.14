CREATE TABLE [dbo].[tOcrDatosImagenValores] (
  [IdImagenValor] [int] IDENTITY,
  [IdImagen] [int] NOT NULL,
  [IdTipoDoc] [int] NOT NULL,
  [IdCampo] [int] NOT NULL,
  [Valor] [varchar](100) NOT NULL,
  [EsCorrecto] [varchar](20) NULL,
  CONSTRAINT [PK_tOcrDatosImagenValores] PRIMARY KEY CLUSTERED ([IdImagenValor])
)
ON [PRIMARY]
GO