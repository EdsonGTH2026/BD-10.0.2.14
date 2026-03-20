CREATE TABLE [dbo].[tLpProveedorRecursos] (
  [IdProveedorRecursos] [int] IDENTITY,
  [IdProceso] [int] NOT NULL,
  [AhorroInversion] [bit] NOT NULL,
  [PrestacionServicios] [bit] NOT NULL,
  [Prestamo] [bit] NOT NULL,
  [PremioSorteo] [bit] NOT NULL,
  [VentaBienes] [bit] NOT NULL,
  [HerenciaDonacion] [bit] NOT NULL,
  [Asalariado] [bit] NOT NULL,
  [NombreEmpresa] [varchar](60) NOT NULL,
  [PuestoOcupa] [varchar](30) NOT NULL,
  [Antiguedad] [varchar](10) NOT NULL,
  [Remesa] [bit] NOT NULL,
  [Otro] [bit] NOT NULL,
  [OtroDesc] [varchar](20) NOT NULL,
  [FechaAlta] [smalldatetime] NOT NULL,
  [CodUsAlta] [varchar](20) NOT NULL,
  CONSTRAINT [PK_tLpProveedorRecursos] PRIMARY KEY CLUSTERED ([IdProveedorRecursos])
)
ON [PRIMARY]
GO