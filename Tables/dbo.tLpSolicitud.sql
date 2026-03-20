CREATE TABLE [dbo].[tLpSolicitud] (
  [IdSolicitud] [int] IDENTITY,
  [IdProceso] [int] NOT NULL,
  [CodProducto] [varchar](3) NOT NULL,
  [Plazo] [int] NOT NULL,
  [Monto] [money] NOT NULL,
  [CodTipoInteres] [varchar](2) NOT NULL,
  [FechaAlta] [smalldatetime] NOT NULL,
  [CodUsAlta] [varchar](20) NOT NULL,
  CONSTRAINT [PK_tLpSolicitud] PRIMARY KEY CLUSTERED ([IdSolicitud])
)
ON [PRIMARY]
GO