CREATE TABLE [dbo].[tServiciosExternos] (
  [idServicio] [int] IDENTITY,
  [idProducto] [varchar](3) NULL,
  [externo] [varchar](30) NULL,
  [idCatServicio] [int] NULL,
  [url] [varchar](200) NULL,
  [contentType] [varchar](50) NULL,
  [metodo] [varchar](20) NULL,
  PRIMARY KEY CLUSTERED ([idServicio])
)
ON [PRIMARY]
GO