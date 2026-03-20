CREATE TABLE [dbo].[tWAVYEnvioSMSAPI] (
  [idRegistro] [int] IDENTITY,
  [fechaHora] [datetime] NULL,
  [sistema] [varchar](3) NULL,
  [codCliente] [varchar](20) NULL,
  [telefono] [varchar](10) NULL,
  [textoSMS] [varchar](200) NULL,
  [respuesta] [varchar](500) NULL,
  [fechaRespuesta] [datetime] NULL,
  PRIMARY KEY CLUSTERED ([idRegistro])
)
ON [PRIMARY]
GO