CREATE TABLE [dbo].[IMSS_Transacciones] (
  [id] [int] NOT NULL,
  [curp] [char](18) NULL,
  [fecha_hora_reg] [datetime] NULL,
  [consulta_nss] [tinyint] NULL DEFAULT (0),
  [consulta_histo] [tinyint] NULL DEFAULT (0),
  [registra_bd] [tinyint] NULL DEFAULT (0),
  [fh_respuesta_nss] [datetime] NULL,
  [fh_respuesta_histo] [datetime] NULL,
  [codsistema] [varchar](5) NULL,
  [id_control] [int] NULL
)
ON [PRIMARY]
GO