CREATE TABLE [dbo].[tOcrDatosImagenValoresReferencia] (
  [IdImagenValor] [int] NOT NULL,
  [ValorReferencia] [varchar](100) NOT NULL,
  CONSTRAINT [PK_tOcrDatosImagenValoresReferencia] PRIMARY KEY CLUSTERED ([IdImagenValor])
)
ON [PRIMARY]
GO