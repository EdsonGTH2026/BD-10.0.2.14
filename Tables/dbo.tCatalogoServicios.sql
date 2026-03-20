CREATE TABLE [dbo].[tCatalogoServicios] (
  [idCatServicio] [int] IDENTITY,
  [descripcionServicio] [varchar](100) NULL,
  [nombreCorto] [varchar](30) NULL,
  PRIMARY KEY CLUSTERED ([idCatServicio])
)
ON [PRIMARY]
GO