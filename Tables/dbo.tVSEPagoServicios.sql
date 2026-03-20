CREATE TABLE [dbo].[tVSEPagoServicios] (
  [idPago] [int] IDENTITY,
  [idServicio] [int] NOT NULL,
  [referencia] [varchar](100) NOT NULL,
  [descripcion] [varchar](100) NOT NULL,
  [monto] [money] NOT NULL,
  [orderId] [varchar](100) NULL,
  [usuario] [varchar](100) NULL,
  [fechaRegistro] [smalldatetime] NOT NULL,
  [codCuenta] [varchar](25) NULL,
  [referenciaPago] [varchar](100) NULL,
  [enviado] [int] NULL,
  [fechaOperacion] [smalldatetime] NULL,
  [mensaje] [varchar](100) NULL,
  [sistema] [varchar](30) NULL,
  PRIMARY KEY CLUSTERED ([idPago])
)
ON [PRIMARY]
GO