CREATE TABLE [dbo].[tBcMonitorConsultaRespuesta] (
  [IdRespuesta] [int] IDENTITY,
  [IdMonitor] [int] NULL,
  [Respuesta] [varchar](4000) NULL,
  CONSTRAINT [PK_tBcMonitorConsultaRespuesta] PRIMARY KEY CLUSTERED ([IdRespuesta])
)
ON [PRIMARY]
GO

GRANT SELECT ON [dbo].[tBcMonitorConsultaRespuesta] TO [public]
GO