CREATE TABLE [dbo].[tQuiubasEnvioSMS] (
  [IdRegistro] [int] IDENTITY,
  [FechaHora] [smalldatetime] NOT NULL,
  [Sistema] [varchar](2) NOT NULL,
  [CodCliente] [varchar](20) NULL,
  [Telefono] [varchar](10) NOT NULL,
  [MensajeSMS] [varchar](200) NOT NULL,
  [Procesado] [smallint] NULL,
  [FechaProceso] [smalldatetime] NULL,
  [Respuesta] [varchar](500) NULL,
  [NumIntentos] [int] NULL,
  [Activo] [bit] NOT NULL,
  CONSTRAINT [PK_tQuiubasEnvioSMS] PRIMARY KEY CLUSTERED ([IdRegistro])
)
ON [PRIMARY]
GO