CREATE TABLE [dbo].[tLpProcesoLlave] (
  [IdLlave] [int] IDENTITY,
  [IdProceso] [int] NOT NULL,
  [Llave] [varchar](20) NOT NULL,
  [UrlCorta] [varchar](100) NOT NULL,
  [UrlLarga] [varchar](250) NOT NULL,
  [Usuario] [varchar](20) NOT NULL,
  [Contrasena] [varchar](20) NOT NULL,
  [Token] [varchar](500) NOT NULL,
  [Activo] [bit] NOT NULL,
  [FechaHora] [smalldatetime] NOT NULL,
  [CodUsAlta] [varchar](20) NOT NULL,
  CONSTRAINT [PK_tLpProcesoLlave] PRIMARY KEY CLUSTERED ([IdLlave])
)
ON [PRIMARY]
GO