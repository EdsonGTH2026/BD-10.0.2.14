CREATE TABLE [dbo].[tAhTransaccionDiariaRecibeSPEI] (
  [IdTransaccion] [int] NULL,
  [FechaOperacion] [smalldatetime] NULL,
  [InstitucionOrdenante] [int] NULL,
  [InstitucionBeneficiaria] [int] NULL,
  [ClaveRastreo] [varchar](30) NULL,
  [Monto] [money] NULL,
  [NombreOrdenante] [varchar](120) NULL,
  [tipoCuentaOrdenante] [int] NULL,
  [CuentaOrdenante] [varchar](20) NULL,
  [RfcCurpOrdenante] [varchar](18) NULL,
  [NombreBeneficiario] [varchar](40) NULL,
  [TipoCuentaBeneficiario] [int] NULL,
  [CuentaBeneficiario] [varchar](20) NULL,
  [RfcCurpBeneficiario] [varchar](18) NULL,
  [ConceptoPago] [varchar](40) NULL,
  [referenciaNumerica] [int] NULL,
  [empresa] [varchar](15) NULL,
  [FechaHoraOpracion] [smalldatetime] NULL,
  [Notificado] [smallint] NULL DEFAULT (0),
  [FechaNotificacion] [smalldatetime] NULL,
  [IntentosNotifica] [smallint] NULL DEFAULT (0)
)
ON [PRIMARY]
GO