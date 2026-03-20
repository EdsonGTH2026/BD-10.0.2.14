CREATE TABLE [dbo].[tCcConsulta] (
  [IdCC] [int] IDENTITY,
  [CodUsuario] [varchar](20) NOT NULL,
  [FechaRegistro] [smalldatetime] NOT NULL,
  [Consulta] [varchar](2000) NOT NULL,
  [Procesado] [smallint] NOT NULL,
  [FechaRespuesta] [smalldatetime] NULL,
  [Respuesta] [varchar](200) NULL,
  [Comentario] [varchar](200) NULL,
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
  [ClienteExterno] [varchar](20) NULL,
  [Notificado] [smallint] NULL DEFAULT (0),
  [EnCola] [tinyint] NULL CONSTRAINT [DF_tCcConsulta_EnCola] DEFAULT (0),
  [EnColaCC] [tinyint] NULL CONSTRAINT [DF_tCcConsulta_EnColaCC] DEFAULT (0),
  CONSTRAINT [PK_tCcConsulta] PRIMARY KEY CLUSTERED ([IdCC])
)
ON [PRIMARY]
GO

CREATE INDEX [CodUsuario_[Cuenta]
  ON [dbo].[tCcConsulta] ([CodUsuario], [Cuenta])
  ON [PRIMARY]
GO

GRANT
  DELETE,
  INSERT,
  SELECT,
  UPDATE
ON [dbo].[tCcConsulta] TO [Admin]
GO

GRANT
  INSERT,
  REFERENCES,
  SELECT,
  UPDATE
ON [dbo].[tCcConsulta] TO [public]
GO