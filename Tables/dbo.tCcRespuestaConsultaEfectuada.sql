CREATE TABLE [dbo].[tCcRespuestaConsultaEfectuada] (
  [IdConsulta] [int] IDENTITY,
  [IdCC] [int] NOT NULL,
  [FechaConsulta] [varchar](10) NULL,
  [ClaveOtorgante] [varchar](10) NULL,
  [NombreOtorgante] [varchar](40) NULL,
  [DireccionOtorgante] [varchar](80) NULL,
  [TelefonoOtorgante] [varchar](20) NULL,
  [TipoCredito] [varchar](2) NULL,
  [ImporteCredito] [varchar](9) NULL,
  [TipoResponsabilidad] [varchar](1) NULL,
  [IdDomicilio] [varchar](20) NULL,
  [Servicios] [varchar](1) NULL,
  [ClaveUnidadMonetaria] [varchar](2) NULL,
  CONSTRAINT [PK_tCcRespuestaConsultaEfectuada] PRIMARY KEY CLUSTERED ([IdConsulta], [IdCC])
)
ON [PRIMARY]
GO

GRANT SELECT ON [dbo].[tCcRespuestaConsultaEfectuada] TO [public]
GO