CREATE TABLE [dbo].[tListaPersonasBloqueadas] (
  [Id] [int] IDENTITY,
  [IdArchivo] [int] NOT NULL,
  [Activo] [int] NOT NULL DEFAULT (1),
  [IdTipo] [int] NOT NULL,
  [Tipo] [varchar](50) NOT NULL,
  [FechaOficio] [smalldatetime] NOT NULL,
  [Nombre] [varchar](100) NOT NULL,
  [ApellidoPaterno] [varchar](50) NULL,
  [ApellidoMaterno] [varchar](50) NULL,
  [RFC] [varchar](50) NULL,
  [FechaNacimiento] [smalldatetime] NULL,
  [Motivo] [varchar](50) NULL,
  [NombreArchivo] [varchar](50) NULL,
  [FechaSistema] [datetime] NOT NULL,
  CONSTRAINT [PK_tListaPersonasBloqueadas] PRIMARY KEY CLUSTERED ([Id])
)
ON [PRIMARY]
GO