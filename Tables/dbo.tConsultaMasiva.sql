CREATE TABLE [dbo].[tConsultaMasiva] (
  [codcuenta] [varchar](20) NOT NULL,
  [codusuario] [varchar](15) NULL,
  [curp] [varchar](20) NULL,
  [cliente] [varchar](250) NULL,
  [estado] [tinyint] NULL CONSTRAINT [DF_tConsultaMasiva_estado] DEFAULT (1),
  [fecharegistro] [datetime] NULL,
  [fechaconsulta] [datetime] NULL,
  CONSTRAINT [PK_tConsultaMasiva] PRIMARY KEY CLUSTERED ([codcuenta])
)
ON [PRIMARY]
GO

CREATE INDEX [IX_tConsultaMasiva]
  ON [dbo].[tConsultaMasiva] ([codcuenta], [curp])
  WITH (FILLFACTOR = 80)
  ON [PRIMARY]
GO