CREATE TABLE [dbo].[tEcCorreoEnvio] (
  [IdCorreoEnvio] [int] IDENTITY,
  [FechaHoraProgramado] [smalldatetime] NOT NULL,
  [Destinatarios] [varchar](500) NOT NULL,
  [DestinatariosCC] [varchar](500) NOT NULL,
  [DestinatariosCO] [varchar](500) NOT NULL,
  [Asunto] [varchar](400) NOT NULL,
  [Mensaje] [varchar](8000) NOT NULL,
  [UsuarioRegistro] [varchar](20) NOT NULL,
  [FechaHoraRegistro] [smalldatetime] NOT NULL,
  [Estado] [int] NULL,
  [FechaProceso] [smalldatetime] NULL,
  [DescProceso] [varchar](200) NULL,
  [Activo] [bit] NOT NULL,
  [ArchivosAdjuntos] [varchar](500) NULL,
  [NotaCorreo] [varchar](150) NULL,
  CONSTRAINT [PK_IdCorreoEnvio] PRIMARY KEY CLUSTERED ([IdCorreoEnvio])
)
ON [PRIMARY]
GO