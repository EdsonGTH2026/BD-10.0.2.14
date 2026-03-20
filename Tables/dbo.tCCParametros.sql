CREATE TABLE [dbo].[tCCParametros] (
  [IdParametro] [int] IDENTITY,
  [Tipo] [varchar](20) NOT NULL,
  [Valor] [varchar](100) NOT NULL,
  [Descripcion] [varchar](150) NOT NULL,
  [FechaAlta] [smalldatetime] NULL,
  [FechaModificacion] [smalldatetime] NULL,
  [UsuarioAlta] [varchar](20) NULL,
  [UsuarioModificacion] [varchar](20) NULL,
  [Activo] [smallint] NOT NULL,
  CONSTRAINT [PK_tCCParametros] PRIMARY KEY CLUSTERED ([IdParametro])
)
ON [PRIMARY]
GO

GRANT SELECT ON [dbo].[tCCParametros] TO [public]
GO