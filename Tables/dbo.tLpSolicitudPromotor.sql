CREATE TABLE [dbo].[tLpSolicitudPromotor] (
  [IdSolicitudPromotor] [int] IDENTITY,
  [NombreCompleto] [varchar](50) NOT NULL,
  [CURP] [varchar](18) NOT NULL,
  [FechaNacimiento] [smalldatetime] NULL,
  [NumCelular] [varchar](10) NOT NULL,
  [CodPromotor] [varchar](20) NOT NULL,
  [FechaRegistro] [datetime] NULL,
  [IdEstado] [int] NOT NULL,
  [FechaProceso] [datetime] NULL,
  [Activo] [bit] NOT NULL,
  CONSTRAINT [PK_tLpSolicitudPromotor] PRIMARY KEY CLUSTERED ([IdSolicitudPromotor])
)
ON [PRIMARY]
GO