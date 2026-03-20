CREATE TABLE [dbo].[tBcMonitorRespCierre] (
  [IdMonitor] [int] NOT NULL,
  [LongitudRegistro] [varchar](10) NULL,
  [MarcaFin] [varchar](10) NULL,
  CONSTRAINT [PK_tBcMonitorRespCierre] PRIMARY KEY CLUSTERED ([IdMonitor])
)
ON [PRIMARY]
GO

GRANT SELECT ON [dbo].[tBcMonitorRespCierre] TO [public]
GO