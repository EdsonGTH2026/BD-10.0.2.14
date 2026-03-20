CREATE TABLE [dbo].[tLpProcesoDet] (
  [IdProcesoDet] [int] IDENTITY,
  [IdProceso] [int] NOT NULL,
  [IdEstado] [int] NOT NULL,
  [Comentario] [varchar](300) NOT NULL,
  [FechaHora] [smalldatetime] NOT NULL,
  [CodUsAlta] [varchar](20) NOT NULL,
  CONSTRAINT [PK_tLpProcesoDet] PRIMARY KEY CLUSTERED ([IdProcesoDet])
)
ON [PRIMARY]
GO