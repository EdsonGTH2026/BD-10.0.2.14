CREATE TABLE [dbo].[tOcrDatosImagenBKP] (
  [IdDatosImagen] [int] NULL,
  [CodCuenta] [varchar](25) NOT NULL,
  [Envio] [int] NULL,
  [Ruta] [varchar](100) NOT NULL,
  [NombreArchivo] [varchar](200) NOT NULL,
  [TipoDoc] [varchar](2) NULL,
  [Texto] [varchar](1500) NULL,
  [FechaAlta] [smalldatetime] NULL,
  [FechaProceso] [smalldatetime] NULL,
  [CodUsAlta] [varchar](20) NULL,
  [TextoProcesado] [bit] NULL,
  [EvaluacionDatos] [varchar](30) NULL
)
ON [PRIMARY]
GO