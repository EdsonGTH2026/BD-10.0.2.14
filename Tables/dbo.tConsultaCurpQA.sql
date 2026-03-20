CREATE TABLE [dbo].[tConsultaCurpQA] (
  [codUsuario] [varchar](50) NOT NULL,
  [solicitudId] [varchar](18) NULL,
  [institucionId] [varchar](3) NULL,
  [tipoProceso] [varchar](5) NULL,
  [curp] [varchar](18) NULL,
  [enviado] [int] NULL,
  [fechaRegistro] [datetime] NULL,
  [fechaEnvio] [datetime] NULL,
  [servicioEnviado] [varchar](3) NULL,
  PRIMARY KEY CLUSTERED ([codUsuario])
)
ON [PRIMARY]
GO