CREATE TABLE [dbo].[tBcMonitorRespNombre] (
  [IdMonitor] [int] NOT NULL,
  [ApePaterno] [varchar](26) NULL,
  [ApeMaterno] [varchar](26) NULL,
  [ApeAdicional] [varchar](26) NULL,
  [PrimerNombre] [varchar](26) NULL,
  [SegundoNombre] [varchar](26) NULL,
  [FechaNacimiento] [varchar](8) NULL,
  [RFC] [varchar](13) NULL,
  [PrefijoPersona] [varchar](4) NULL,
  [SufijoPersona] [varchar](4) NULL,
  [Nacionalidad] [varchar](2) NULL,
  [TipoResidencia] [varchar](1) NULL,
  [NumLicenciaCond] [varchar](20) NULL,
  [EstadoCivil] [varchar](1) NULL,
  [Genero] [varchar](1) NULL,
  [CedulaProfesional] [varchar](20) NULL,
  [IFE] [varchar](20) NULL,
  [CURP] [varchar](20) NULL,
  [ClavePais] [varchar](2) NULL,
  [NumeroDependientes] [int] NULL,
  [EdadesDependientes] [varchar](30) NULL,
  [FechaRecepcion] [varchar](8) NULL,
  [FechaDefuncion] [varchar](8) NULL,
  CONSTRAINT [PK_tBcMonitorRespNombre] PRIMARY KEY CLUSTERED ([IdMonitor])
)
ON [PRIMARY]
GO

GRANT SELECT ON [dbo].[tBcMonitorRespNombre] TO [public]
GO