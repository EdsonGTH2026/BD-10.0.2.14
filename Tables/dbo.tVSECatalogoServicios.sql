CREATE TABLE [dbo].[tVSECatalogoServicios] (
  [idServicio] [int] NULL,
  [descripcion] [varchar](30) NULL,
  [categoria] [varchar](100) NULL,
  [avatar] [varchar](100) NULL,
  [activo] [int] NULL,
  [fechaUltimaAct] [smalldatetime] NULL
)
ON [PRIMARY]
GO