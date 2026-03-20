CREATE TABLE [dbo].[tOPRDoc] (
  [IdDoc] [int] IDENTITY,
  [NombreArchivo] [varchar](50) NULL,
  [RutaArchivo] [varchar](200) NULL,
  [FechaAlta] [smalldatetime] NULL,
  [Procesado] [int] NULL,
  [FechaProceso] [smalldatetime] NULL,
  [Activo] [bit] NULL,
  CONSTRAINT [PK_tOPRDoc] PRIMARY KEY CLUSTERED ([IdDoc])
)
ON [PRIMARY]
GO