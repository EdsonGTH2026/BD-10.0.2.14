CREATE TABLE [dbo].[tAhCuentasTercero] (
  [IdCuenta] [int] IDENTITY,
  [CodCuenta] [varchar](20) NOT NULL,
  [ClaveBanco] [varchar](6) NOT NULL,
  [NombreBeneficiarioTercero] [varchar](40) NOT NULL,
  [CuentaBeneficiarioTercero] [varchar](20) NOT NULL,
  [claveTipoCta] [varchar](3) NOT NULL,
  [Consepto] [varchar](20) NOT NULL,
  [Alias] [varchar](20) NOT NULL,
  [FechaAlta] [smalldatetime] NULL,
  PRIMARY KEY CLUSTERED ([IdCuenta])
)
ON [PRIMARY]
GO