CREATE TABLE [dbo].[tCcRespuestaAutentificacion] (
  [IdCC] [int] NOT NULL,
  [NumeroAutenticacion] [varchar](10) NULL,
  [NumeroSolicitud] [varchar](25) NULL,
  [EstatusAutenticacion] [varchar](1) NULL,
  CONSTRAINT [PK_tCcRespuestaAutentificacion] PRIMARY KEY CLUSTERED ([IdCC])
)
ON [PRIMARY]
GO

GRANT SELECT ON [dbo].[tCcRespuestaAutentificacion] TO [public]
GO