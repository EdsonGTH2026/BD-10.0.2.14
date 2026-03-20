CREATE TABLE [dbo].[tBcInformeBuroRespEncabezado] (
  [IdInforme] [int] NOT NULL,
  [Etiqueta] [varchar](4) NULL,
  [Version] [int] NULL,
  [Referencia] [varchar](25) NULL,
  [Pais] [varchar](2) NULL,
  [Reservado] [int] NULL,
  [ClaveUsuario] [varchar](10) NULL,
  [ClaveRespuesta] [varchar](1) NULL,
  [Reservado2] [varchar](1) NULL,
  CONSTRAINT [PK_tBcInformeBuroRespEncabezado] PRIMARY KEY CLUSTERED ([IdInforme])
)
ON [PRIMARY]
GO

GRANT SELECT ON [dbo].[tBcInformeBuroRespEncabezado] TO [public]
GO