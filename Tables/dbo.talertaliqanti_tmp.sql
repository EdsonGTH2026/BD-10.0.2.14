CREATE TABLE [dbo].[talertaliqanti_tmp] (
  [sec] [int] IDENTITY,
  [codprestamo] [varchar](20) NULL,
  [monto] [money] NULL,
  [formulario] [varchar](50) NULL,
  [fechahora] [datetime] NULL CONSTRAINT [DF_talertaliqanti_tmp_fechahora] DEFAULT (getdate()),
  CONSTRAINT [PK_talertaliqanti_tmp] PRIMARY KEY CLUSTERED ([sec])
)
ON [PRIMARY]
GO