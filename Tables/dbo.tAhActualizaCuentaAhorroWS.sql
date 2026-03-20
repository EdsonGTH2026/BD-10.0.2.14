CREATE TABLE [dbo].[tAhActualizaCuentaAhorroWS] (
  [IdRegistro] [int] IDENTITY,
  [FechaHora] [smalldatetime] NOT NULL,
  [Cliente] [varchar](20) NOT NULL,
  [Cuenta] [varchar](25) NOT NULL,
  [ParametrosWS] [varchar](2000) NOT NULL,
  CONSTRAINT [PK_tAhActualizaCuentaAhorroWS] PRIMARY KEY CLUSTERED ([IdRegistro])
)
ON [PRIMARY]
GO

CREATE INDEX [IX_tAhActualizaCuentaAhorroWS]
  ON [dbo].[tAhActualizaCuentaAhorroWS] ([Cuenta])
  WITH (PAD_INDEX = ON, FILLFACTOR = 50)
  ON [PRIMARY]
GO