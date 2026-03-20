CREATE TABLE [dbo].[tBcInformeConsultaRespuesta] (
  [IdRespuesta] [int] IDENTITY,
  [IdInforme] [int] NULL,
  [Respuesta] [varchar](4000) NULL,
  CONSTRAINT [PK_tBcInformeConsultaRespuesta] PRIMARY KEY CLUSTERED ([IdRespuesta])
)
ON [PRIMARY]
GO

GRANT SELECT ON [dbo].[tBcInformeConsultaRespuesta] TO [public]
GO