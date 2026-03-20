CREATE TABLE [dbo].[tClCaLiqAntRangosDias] (
  [Id] [int] IDENTITY,
  [CodTipoPlazo] [char](1) NOT NULL,
  [Cuotas] [smallint] NOT NULL,
  [Dias] [smallint] NOT NULL,
  CONSTRAINT [PK_tClCaLiqAntRangosDias] PRIMARY KEY CLUSTERED ([Id])
)
ON [PRIMARY]
GO