CREATE TABLE [dbo].[tBuroCreditoParametros] (
  [IdParametro] [int] IDENTITY,
  [Tipo] [varchar](20) NOT NULL,
  [Valor] [varchar](50) NOT NULL,
  [Descripcion] [varchar](80) NOT NULL,
  [FechaAlta] [smalldatetime] NULL,
  [FechaModificacion] [smalldatetime] NULL,
  [UsuarioAlta] [varchar](20) NULL,
  [UsuarioModificacion] [varchar](20) NULL,
  [Activo] [tinyint] NOT NULL,
  CONSTRAINT [PK_tBuroCreditoParametros] PRIMARY KEY CLUSTERED ([IdParametro])
)
ON [PRIMARY]
GO

GRANT SELECT ON [dbo].[tBuroCreditoParametros] TO [public]
GO