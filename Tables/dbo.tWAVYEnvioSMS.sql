CREATE TABLE [dbo].[tWAVYEnvioSMS] (
  [IdRegistro] [int] IDENTITY,
  [FechaHora] [datetime] NULL,
  [Sistema] [varchar](2) NOT NULL,
  [CodCliente] [varchar](20) NULL,
  [Telefono] [varchar](10) NOT NULL,
  [MensajeSMS] [varchar](200) NOT NULL,
  [FechaProceso] [datetime] NULL,
  [Respuesta] [varchar](500) NULL,
  [NumIntentos] [int] NULL,
  [Activo] [bit] NOT NULL,
  [consultado] [char](1) NULL DEFAULT ('0'),
  [fechaRespuesta] [datetime] NULL,
  PRIMARY KEY CLUSTERED ([IdRegistro])
)
ON [PRIMARY]
GO