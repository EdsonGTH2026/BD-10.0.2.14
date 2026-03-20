CREATE TABLE [dbo].[tOcrDatosImagen] (
  [IdImagen] [int] IDENTITY,
  [Sistema] [varchar](2) NULL,
  [CodigoCuenta] [varchar](25) NOT NULL,
  [CodOficina] [varchar](3) NULL,
  [Ruta] [varchar](100) NOT NULL,
  [NombreArchivo] [varchar](200) NOT NULL,
  [TipoDoc] [varchar](2) NULL,
  [Envio] [int] NULL,
  [Texto] [varchar](1500) NULL,
  [FechaAlta] [smalldatetime] NULL,
  [FechaProceso] [smalldatetime] NULL,
  [CodUsAlta] [varchar](20) NULL,
  [TextoProcesado] [bit] NULL,
  [EvaluacionDatos] [varchar](30) NULL,
  [Activo] [bit] NOT NULL DEFAULT (1)
)
ON [PRIMARY]
GO