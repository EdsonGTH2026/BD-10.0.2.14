CREATE TABLE [dbo].[tCaReporteSolicitudSimple] (
  [Id] [int] IDENTITY,
  [CodSolicitud] [varchar](20) NULL,
  [CodOficina] [varchar](3) NULL,
  [FechaRegistro] [smalldatetime] NULL,
  [Procesado] [tinyint] NULL,
  [ArchivoLocal] [varchar](100) NULL,
  [RutaDestino] [varchar](150) NULL,
  [CopiadoPDF] [tinyint] NULL,
  [Activo] [bit] NULL,
  CONSTRAINT [PK_tCaReporteSolicitudSimple] PRIMARY KEY CLUSTERED ([Id])
)
ON [PRIMARY]
GO