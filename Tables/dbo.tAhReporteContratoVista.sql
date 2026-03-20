CREATE TABLE [dbo].[tAhReporteContratoVista] (
  [Id] [int] IDENTITY,
  [Cuenta] [varchar](20) NULL,
  [CodOficina] [varchar](3) NULL,
  [FechaRegistro] [smalldatetime] NULL,
  [Procesado] [tinyint] NULL,
  [FechaProceso] [smalldatetime] NULL,
  [ArchivoLocal] [varchar](100) NULL,
  [RutaDestino] [varchar](150) NULL,
  [CopiadoPDF] [tinyint] NULL,
  [Activo] [bit] NULL,
  CONSTRAINT [PK_tAhReporteContratoVista] PRIMARY KEY CLUSTERED ([Id])
)
ON [PRIMARY]
GO