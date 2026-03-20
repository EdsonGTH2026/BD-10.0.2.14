CREATE TABLE [dbo].[tListaArchivosPaisesCargados] (
  [Id] [int] IDENTITY,
  [IdArchivo] [int] NOT NULL,
  [Activo] [int] NOT NULL DEFAULT (1),
  [CodPais] [varchar](4) NOT NULL,
  [Pais] [varchar](80) NOT NULL,
  [Nacionalidad] [varchar](80) NOT NULL,
  [Continente] [varchar](20) NOT NULL,
  [Riesgo] [varchar](10) NOT NULL,
  [NombreArchivo] [varchar](50) NOT NULL,
  [FechaSistema] [datetime] NOT NULL,
  CONSTRAINT [PK_tListaArchivosPaisesCargados] PRIMARY KEY CLUSTERED ([Id])
)
ON [PRIMARY]
GO