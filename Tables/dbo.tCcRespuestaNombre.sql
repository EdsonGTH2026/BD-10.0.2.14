CREATE TABLE [dbo].[tCcRespuestaNombre] (
  [IdCC] [int] NOT NULL,
  [ApellidoPaterno] [varchar](30) NULL,
  [ApellidoMaterno] [varchar](30) NULL,
  [ApellidoAdicional] [varchar](30) NULL,
  [Nombres] [varchar](50) NULL,
  [FechaNacimiento] [varchar](10) NULL,
  [RFC] [varchar](13) NULL,
  [CURP] [varchar](18) NULL,
  [NumeroSeguridadSocial] [varchar](11) NULL,
  [Nacionalidad] [varchar](2) NULL,
  [Residencia] [varchar](1) NULL,
  [EstadoCivil] [varchar](1) NULL,
  [Sexo] [varchar](1) NULL,
  [ClaveElectorIFE] [varchar](20) NULL,
  [NumeroDependientes] [varchar](2) NULL,
  [FechaDefuncion] [varchar](10) NULL,
  CONSTRAINT [PK_tCcRespuestaNombre] PRIMARY KEY CLUSTERED ([IdCC])
)
ON [PRIMARY]
GO

GRANT SELECT ON [dbo].[tCcRespuestaNombre] TO [public]
GO