CREATE TABLE [dbo].[tCcRespuestaEmpleo] (
  [IdEmpleo] [int] IDENTITY,
  [IdCC] [int] NOT NULL,
  [NombreEmpresa] [varchar](40) NULL,
  [Direccion] [varchar](80) NULL,
  [ColoniaPoblacion] [varchar](65) NULL,
  [DelegacionMunicipio] [varchar](65) NULL,
  [Ciudad] [varchar](65) NULL,
  [Estado] [varchar](4) NULL,
  [CP] [varchar](5) NULL,
  [NumeroTelefono] [varchar](20) NULL,
  [Extension] [varchar](8) NULL,
  [Fax] [varchar](20) NULL,
  [Puesto] [varchar](60) NULL,
  [FechaContratacion] [varchar](10) NULL,
  [ClaveMoneda] [varchar](2) NULL,
  [SalarioMensual] [varchar](9) NULL,
  [FechaUltimoDiaEmpleo] [varchar](10) NULL,
  [FechaVerificacionEmpleo] [varchar](10) NULL,
  CONSTRAINT [PK_tCcRespuestaEmpleo] PRIMARY KEY CLUSTERED ([IdEmpleo], [IdCC])
)
ON [PRIMARY]
GO

GRANT SELECT ON [dbo].[tCcRespuestaEmpleo] TO [public]
GO