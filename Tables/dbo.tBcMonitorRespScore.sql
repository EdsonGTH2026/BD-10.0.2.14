CREATE TABLE [dbo].[tBcMonitorRespScore] (
  [IdMonitor] [int] NOT NULL,
  [IdScore] [int] IDENTITY,
  [NombreScore] [varchar](30) NULL,
  [CodigoScore] [varchar](3) NULL,
  [ValorScore] [varchar](4) NULL,
  [CodigoRazon1] [varchar](3) NULL,
  [CodigoRazon2] [varchar](3) NULL,
  [CodigoRazon3] [varchar](3) NULL,
  [CodigoError] [varchar](2) NULL,
  CONSTRAINT [PK_tBcMonitorRespScore] PRIMARY KEY CLUSTERED ([IdMonitor], [IdScore])
)
ON [PRIMARY]
GO

GRANT SELECT ON [dbo].[tBcMonitorRespScore] TO [public]
GO