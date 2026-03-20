CREATE TABLE [dbo].[tCcRespuestaDomicilio] (
  [IdDom] [int] IDENTITY,
  [IdCC] [int] NOT NULL,
  [Direccion] [varchar](80) NULL,
  [ColoniaPoblacion] [varchar](65) NULL,
  [DelegacionMunicipio] [varchar](65) NULL,
  [Ciudad] [varchar](65) NULL,
  [Estado] [varchar](4) NULL,
  [CP] [varchar](5) NULL,
  [FechaResidencia] [varchar](10) NULL,
  [NumeroTelefono] [varchar](20) NULL,
  [TipoDomicilio] [varchar](1) NULL,
  [TipoAsentamiento] [varchar](2) NULL,
  [FechaRegistroDomicilio] [varchar](10) NULL,
  [TipoAltaDomicilio] [varchar](1) NULL,
  [NumeroOtorgantesCarga] [varchar](2) NULL,
  [NumeroOtorgantesConsulta] [varchar](2) NULL,
  [IdDomicilio] [varchar](2) NULL,
  CONSTRAINT [PK_tCcRespuestaDomicilio] PRIMARY KEY CLUSTERED ([IdDom], [IdCC])
)
ON [PRIMARY]
GO

GRANT SELECT ON [dbo].[tCcRespuestaDomicilio] TO [public]
GO