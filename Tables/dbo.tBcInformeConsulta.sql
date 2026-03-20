CREATE TABLE [dbo].[tBcInformeConsulta] (
  [IdInforme] [int] IDENTITY,
  [CodUsuario] [varchar](20) NOT NULL,
  [FechaRegistro] [smalldatetime] NOT NULL,
  [Consulta] [varchar](1000) NOT NULL,
  [Procesado] [smallint] NOT NULL,
  [FechaRespuesta] [smalldatetime] NULL,
  [Respuesta] [varchar](1000) NULL,
  [Comentario] [varchar](1000) NULL,
  [RutaPDF] [varchar](150) NULL,
  [ArchivoPDF] [varchar](30) NULL,
  [Tipo] [varchar](1) NULL,
  [Cuenta] [varchar](20) NULL,
  [CodOficina] [varchar](3) NULL,
  [IdClasificacion] [int] NULL,
  [CopiadoPDF] [smallint] NULL,
  [UsuarioRegistro] [varchar](20) NULL,
  [NumConsultas] [int] NULL,
  [Activo] [smallint] NOT NULL,
  CONSTRAINT [PK_tBcInformeConsulta] PRIMARY KEY CLUSTERED ([IdInforme])
)
ON [PRIMARY]
GO

GRANT SELECT ON [dbo].[tBcInformeConsulta] TO [public]
GO