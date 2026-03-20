CREATE TABLE [dbo].[tVSEClienteCategoria] (
  [idCliente] [int] IDENTITY,
  [idCategoria] [int] NOT NULL,
  [cliente] [varchar](30) NULL,
  PRIMARY KEY CLUSTERED ([idCliente])
)
ON [PRIMARY]
GO