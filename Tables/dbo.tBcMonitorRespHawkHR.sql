CREATE TABLE [dbo].[tBcMonitorRespHawkHR] (
  [IdMonitor] [int] NOT NULL,
  [IdHR] [int] IDENTITY,
  [FechaReporte] [varchar](8) NULL,
  [CodigoPrevencion] [varchar](8) NULL,
  [TipoUsuario] [varchar](16) NULL,
  [Mensaje] [varchar](48) NULL,
  CONSTRAINT [PK_tBcMonitorRespHawkHR] PRIMARY KEY CLUSTERED ([IdMonitor], [IdHR])
)
ON [PRIMARY]
GO

GRANT SELECT ON [dbo].[tBcMonitorRespHawkHR] TO [public]
GO