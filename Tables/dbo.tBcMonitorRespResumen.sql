CREATE TABLE [dbo].[tBcMonitorRespResumen] (
  [IdMonitor] [int] NOT NULL,
  [IdResumen] [int] IDENTITY,
  [FecIntegracionBD] [varchar](8) NULL,
  [MensajeAlerta] [varchar](8) NULL,
  CONSTRAINT [PK_tBcMonitorRespResumen] PRIMARY KEY CLUSTERED ([IdMonitor], [IdResumen])
)
ON [PRIMARY]
GO

GRANT SELECT ON [dbo].[tBcMonitorRespResumen] TO [public]
GO