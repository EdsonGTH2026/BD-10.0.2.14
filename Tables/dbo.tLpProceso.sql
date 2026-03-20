CREATE TABLE [dbo].[tLpProceso] (
  [IdProceso] [int] IDENTITY,
  [IdSolicitudPromotor] [int] NOT NULL,
  [CodSupervisor] [varchar](20) NOT NULL,
  [FechaRegistro] [datetime] NOT NULL,
  [IdEstado] [int] NOT NULL,
  [FechaProceso] [datetime] NULL,
  [Activo] [bit] NOT NULL,
  [AvisoPrivacidadAceptado] [bit] NULL,
  [AvisoPrivacidadFecha] [smalldatetime] NULL,
  CONSTRAINT [PK_tLpProceso] PRIMARY KEY CLUSTERED ([IdProceso])
)
ON [PRIMARY]
GO