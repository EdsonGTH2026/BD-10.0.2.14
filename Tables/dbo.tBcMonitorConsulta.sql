CREATE TABLE [dbo].[tBcMonitorConsulta] (
  [IdMonitor] [int] IDENTITY,
  [CodUsuario] [varchar](20) NOT NULL,
  [FechaRegistro] [smalldatetime] NOT NULL,
  [Consulta] [varchar](1000) NOT NULL,
  [Procesado] [smallint] NOT NULL,
  [FechaRespuesta] [smalldatetime] NULL,
  [Respuesta] [varchar](8000) NULL,
  [Respuesta2] [varchar](4000) NULL,
  [RutaPDF] [varchar](150) NULL,
  [ArchivoPDF] [varchar](30) NULL,
  [Activo] [smallint] NOT NULL,
  [Tipo] [varchar](1) NULL,
  [Cuenta] [varchar](20) NULL,
  [CodOficina] [varchar](3) NULL,
  [IdClasificacion] [int] NULL,
  [CopiadoPDF] [smallint] NULL,
  [UsuarioRegistro] [varchar](20) NULL,
  [NumConsultas] [int] NULL,
  CONSTRAINT [PK_tBcMonitorConsulta] PRIMARY KEY CLUSTERED ([IdMonitor])
)
ON [PRIMARY]
GO

GRANT
  INSERT,
  REFERENCES,
  SELECT,
  UPDATE
ON [dbo].[tBcMonitorConsulta] TO [public]
GO