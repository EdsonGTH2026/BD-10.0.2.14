CREATE TABLE [dbo].[tAhCuentaClabeInterbancaria] (
  [IdRegistro] [int] IDENTITY,
  [IdConsecutivo] [varchar](6) NULL DEFAULT ('000000'),
  [ClabeInterbancaria] [varchar](18) NULL,
  [CodCuenta] [varchar](25) NULL,
  [CodUsario] [varchar](20) NULL,
  [FechaReg] [datetime] NULL,
  [AltaSTP] [int] NULL DEFAULT (0),
  [FechaAltaSTP] [datetime] NULL,
  [IdSTP] [varchar](5) NULL,
  [DescripcionIdSTP] [varchar](100) NULL,
  [Empresa] [varchar](15) NULL,
  PRIMARY KEY CLUSTERED ([IdRegistro])
)
ON [PRIMARY]
GO

GRANT SELECT ON [dbo].[tAhCuentaClabeInterbancaria] TO [public]
GO