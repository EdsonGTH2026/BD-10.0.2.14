CREATE TABLE [dbo].[tSegmentosMonitorRespuestaINTL] (
  [IdSegmento] [int] NOT NULL,
  [Segmento] [varchar](4) NOT NULL,
  [Descripcion] [varchar](20) NOT NULL,
  [NumVeces] [int] NOT NULL,
  [SqlTabla] [varchar](50) NULL,
  [Activo] [tinyint] NOT NULL,
  CONSTRAINT [PK_tSegmentosMonitorRespuestaINTL] PRIMARY KEY CLUSTERED ([IdSegmento])
)
ON [PRIMARY]
GO

GRANT SELECT ON [dbo].[tSegmentosMonitorRespuestaINTL] TO [public]
GO