CREATE TABLE [dbo].[tParametrosServicios] (
  [idParametro] [int] IDENTITY,
  [idServicio] [int] NULL,
  [nombre] [varchar](30) NULL,
  [valor] [varchar](200) NULL,
  PRIMARY KEY CLUSTERED ([idParametro])
)
ON [PRIMARY]
GO