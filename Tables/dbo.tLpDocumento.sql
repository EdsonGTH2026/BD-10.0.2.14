CREATE TABLE [dbo].[tLpDocumento] (
  [IdDocumento] [int] IDENTITY,
  [IdProceso] [int] NOT NULL,
  [IdTipoDocumento] [int] NOT NULL,
  [Descripcion] [varchar](100) NOT NULL,
  [RutaOriginal] [varchar](150) NOT NULL,
  [NombreOriginal] [varchar](50) NOT NULL,
  [RutaDestino] [varchar](150) NOT NULL,
  [NombreNuevo] [varchar](60) NOT NULL,
  [FechaCopiado] [smalldatetime] NULL,
  [ArchivoWebCopiado] [tinyint] NULL,
  [CodUsAlta] [varchar](20) NOT NULL,
  [FechaAlta] [smalldatetime] NOT NULL,
  [Activa] [tinyint] NOT NULL,
  [PorCorregir] [bit] NULL,
  [ComentarioCorreccion] [varchar](50) NULL,
  CONSTRAINT [PK_tLpDocumento] PRIMARY KEY CLUSTERED ([IdDocumento])
)
ON [PRIMARY]
GO