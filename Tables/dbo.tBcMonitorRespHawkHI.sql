CREATE TABLE [dbo].[tBcMonitorRespHawkHI] (
  [IdMonitor] [int] NOT NULL,
  [IdHI] [int] IDENTITY,
  [FechaReporte] [varchar](8) NULL,
  [CodigoPrevencion] [varchar](8) NULL,
  [TipoUsuario] [varchar](16) NULL,
  [Mensaje] [varchar](48) NULL,
  CONSTRAINT [PK_tBcMonitorRespHawkHI] PRIMARY KEY CLUSTERED ([IdMonitor], [IdHI])
)
ON [PRIMARY]
GO

GRANT SELECT ON [dbo].[tBcMonitorRespHawkHI] TO [public]
GO