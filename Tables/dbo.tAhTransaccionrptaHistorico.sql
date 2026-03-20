CREATE TABLE [dbo].[tAhTransaccionrptaHistorico] (
  [idTransaccion] [int] NOT NULL,
  [item] [int] NOT NULL,
  [estado] [int] NULL,
  [respuesta] [varchar](300) NULL,
  [fecha] [datetime] NULL,
  CONSTRAINT [PK_tAhTransaccionrptaHistorico] PRIMARY KEY CLUSTERED ([idTransaccion], [item])
)
ON [PRIMARY]
GO