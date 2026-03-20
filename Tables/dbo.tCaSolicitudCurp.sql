CREATE TABLE [dbo].[tCaSolicitudCurp] (
  [IdSolicitud] [int] IDENTITY,
  [Codusuario] [varchar](20) NOT NULL,
  [CodSolicitud] [varchar](20) NOT NULL,
  [CodOficina] [varchar](3) NULL,
  [Existe] [char](1) NULL DEFAULT ('0'),
  [CURP] [varchar](18) NULL,
  [CodigoRespuestaCCB] [varchar](10) NULL,
  [DescripcionRespuestaCCB] [varchar](500) NULL,
  [Estado] [smallint] NULL,
  [FechaRegistro] [smalldatetime] NULL,
  [FechaModificacion] [smalldatetime] NULL,
  [CodUSRegistro] [varchar](20) NULL,
  [CodUSUltimaModificacion] [varchar](20) NULL,
  [Activo] [bit] NULL,
  [CodSistema] [char](2) NULL,
  [idSolicitudCecoban] [varchar](25) NULL,
  PRIMARY KEY CLUSTERED ([IdSolicitud])
)
ON [PRIMARY]
GO

GRANT
  DELETE,
  INSERT,
  REFERENCES,
  SELECT,
  UPDATE
ON [dbo].[tCaSolicitudCurp] TO [public]
GO