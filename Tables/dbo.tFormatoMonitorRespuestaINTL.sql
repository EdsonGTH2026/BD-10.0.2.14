CREATE TABLE [dbo].[tFormatoMonitorRespuestaINTL] (
  [IdSegmento] [int] NOT NULL,
  [Orden] [int] NOT NULL,
  [Etiqueta] [varchar](4) NOT NULL,
  [Descripcion] [varchar](30) NOT NULL,
  [Longitud] [int] NOT NULL,
  [PosIni] [int] NULL,
  [PosFin] [int] NULL,
  [Valor] [varchar](20) NULL,
  [Activo] [tinyint] NOT NULL,
  [SqlCampo] [varchar](30) NULL,
  [SqlTipo] [varchar](2) NULL,
  CONSTRAINT [PK_tFormatoMonitorRespuestaINTL] PRIMARY KEY CLUSTERED ([IdSegmento], [Orden])
)
ON [PRIMARY]
GO

GRANT SELECT ON [dbo].[tFormatoMonitorRespuestaINTL] TO [public]
GO