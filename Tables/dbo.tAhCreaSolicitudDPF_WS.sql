CREATE TABLE [dbo].[tAhCreaSolicitudDPF_WS] (
  [IdRegistro] [int] IDENTITY,
  [FechaHora] [smalldatetime] NOT NULL,
  [Cliente] [varchar](20) NOT NULL,
  [ParametrosWS] [varchar](2000) NOT NULL,
  CONSTRAINT [PK_tAhCreaSolicitudDPF_WS] PRIMARY KEY CLUSTERED ([IdRegistro])
)
ON [PRIMARY]
GO