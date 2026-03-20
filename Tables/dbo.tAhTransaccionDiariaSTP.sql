CREATE TABLE [dbo].[tAhTransaccionDiariaSTP] (
  [IdTransaccion] [int] IDENTITY,
  [CodCuenta] [varchar](30) NOT NULL,
  [ClaveRastreo] [varchar](30) NULL,
  [ConceptoPago] [varchar](40) NULL,
  [CuentaBeneficiario] [varchar](20) NULL,
  [CuentaOrdenante] [varchar](20) NULL,
  [Empresa] [varchar](15) NULL,
  [FechaOperacion] [datetime] NULL,
  [InstitucionContraparte] [int] NULL,
  [InstitucionOperante] [int] NULL CONSTRAINT [DF__tAhTransa__Insti__2E1BDC42] DEFAULT (90646),
  [Monto] [money] NULL,
  [NombreBeneficiario] [varchar](60) NULL,
  [ReferenciaNumerica] [bigint] NULL,
  [RfcCurpBeneficiario] [varchar](18) NULL,
  [TipoCuentaBeneficiario] [int] NULL,
  [TipoPago] [varchar](2) NULL,
  [Enviado] [tinyint] NULL CONSTRAINT [DF__tAhTransa__Envia__2F10007B] DEFAULT (0),
  [FechaHoraTran] [datetime] NULL,
  [Estado] [smallint] NULL,
  [FechaProcesoFin] [datetime] NULL,
  [OrigenOperacion] [varchar](10) NULL,
  [nroSecuencial] [int] NULL,
  [numTrans] [int] NULL,
  CONSTRAINT [PK__tAhTransaccionDi__2D27B809] PRIMARY KEY CLUSTERED ([IdTransaccion])
)
ON [PRIMARY]
GO

GRANT
  DELETE,
  INSERT,
  REFERENCES,
  SELECT,
  UPDATE
ON [dbo].[tAhTransaccionDiariaSTP] TO [GPSipro]
GO

GRANT SELECT ON [dbo].[tAhTransaccionDiariaSTP] TO [public]
GO