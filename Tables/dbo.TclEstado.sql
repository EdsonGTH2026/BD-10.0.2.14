CREATE TABLE [dbo].[TclEstado] (
  [IdEstado] [int] IDENTITY,
  [CodEstado] [smallint] NULL,
  [Descripcion] [varchar](50) NULL,
  PRIMARY KEY CLUSTERED ([IdEstado])
)
ON [PRIMARY]
GO