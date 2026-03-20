CREATE TABLE [dbo].[tMSTareasRegistro] (
  [IdRegistro] [int] IDENTITY,
  [IdTareaSP] [int] NOT NULL,
  [FechaHora] [smalldatetime] NOT NULL,
  [Estatus] [varchar](15) NOT NULL,
  CONSTRAINT [PK_tMSTareasRegistro] PRIMARY KEY CLUSTERED ([IdRegistro])
)
ON [PRIMARY]
GO