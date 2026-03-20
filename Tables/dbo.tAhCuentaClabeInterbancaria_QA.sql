CREATE TABLE [dbo].[tAhCuentaClabeInterbancaria_QA] (
  [IdRegistro] [int] IDENTITY,
  [IdConsecutivo] [varchar](6) NULL CONSTRAINT [DF__tAhCuenta__IdCon__24927208_QA] DEFAULT ('000000'),
  [ClabeInterbancaria] [varchar](18) NULL,
  [CodCuenta] [varchar](25) NULL,
  [CodUsario] [varchar](20) NULL,
  [FechaReg] [datetime] NULL,
  [AltaSTP] [int] NULL CONSTRAINT [DF__tAhCuenta__AltaS__208CD6FA_QA] DEFAULT (0),
  [FechaAltaSTP] [datetime] NULL,
  [IdSTP] [varchar](5) NULL,
  [DescripcionIdSTP] [varchar](100) NULL,
  [Empresa] [varchar](15) NULL,
  PRIMARY KEY CLUSTERED ([IdRegistro])
)
ON [PRIMARY]
GO