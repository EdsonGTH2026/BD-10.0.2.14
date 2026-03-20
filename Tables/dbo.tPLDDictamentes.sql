CREATE TABLE [dbo].[tPLDDictamentes] (
  [IdRegistro] [int] NOT NULL,
  [Tipo] [varchar](15) NOT NULL,
  [CodUsuario] [varchar](15) NOT NULL,
  [CodSolicitud] [varchar](20) NOT NULL,
  [CodOficina] [varchar](3) NOT NULL,
  [DescripcionAlerta] [varchar](500) NULL,
  [ArchivoDictamenLocal] [varchar](200) NULL,
  [ArchivoDictamenServidor] [varchar](200) NULL,
  [FechaDictamen] [datetime] NULL,
  [ReportarAComision] [varchar](2) NULL,
  [FechaReporteComisión] [datetime] NULL,
  [CodUsuarioAlta] [varchar](15) NULL,
  [FechaAlta] [datetime] NULL,
  [Activo] [bit] NULL,
  [Coincidencia] [varchar](20) NULL,
  [ProcedeOperacionInusual] [varchar](2) NULL,
  [Dictamen] [varchar](1000) NULL,
  [FechaModifica] [smalldatetime] NULL,
  [UsuarioModifica] [varchar](20) NULL,
  CONSTRAINT [PK_tPLDDictamentes] PRIMARY KEY CLUSTERED ([IdRegistro])
)
ON [PRIMARY]
GO