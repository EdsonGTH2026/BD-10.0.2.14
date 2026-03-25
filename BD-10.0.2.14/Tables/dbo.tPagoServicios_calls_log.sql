CREATE TABLE [dbo].[tPagoServicios_calls_log] (
  [IdPagoServicio] [int] NOT NULL,
  [Item] [int] NOT NULL,
  [Registro] [datetime] NULL,
  [XConsulta] [varchar](500) NOT NULL,
  [XRespuesta] [varchar](1000) NOT NULL,
  CONSTRAINT [PK_tPagoServicios_calls_log] PRIMARY KEY CLUSTERED ([IdPagoServicio], [Item])
)
ON [PRIMARY]
GO