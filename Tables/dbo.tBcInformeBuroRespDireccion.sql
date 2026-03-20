CREATE TABLE [dbo].[tBcInformeBuroRespDireccion] (
  [IdInforme] [int] NOT NULL,
  [IdDireccion] [int] IDENTITY,
  [Direccion1] [varchar](40) NULL,
  [Direccion2] [varchar](40) NULL,
  [Colonia] [varchar](40) NULL,
  [Municipio] [varchar](40) NULL,
  [Ciudad] [varchar](40) NULL,
  [Estado] [varchar](4) NULL,
  [CP] [varchar](5) NULL,
  [FechaRecidencia] [varchar](8) NULL,
  [Telefono] [varchar](11) NULL,
  [Ext] [varchar](8) NULL,
  [Fax] [varchar](11) NULL,
  [TipoDomicilio] [varchar](1) NULL,
  [IndicadorEspecial] [varchar](1) NULL,
  [FechaReporteDir] [varchar](8) NULL,
  [OrigenDomicilio] [varchar](2) NULL,
  CONSTRAINT [PK_tBcInformeBuroRespDireccion] PRIMARY KEY CLUSTERED ([IdInforme], [IdDireccion])
)
ON [PRIMARY]
GO

GRANT SELECT ON [dbo].[tBcInformeBuroRespDireccion] TO [public]
GO