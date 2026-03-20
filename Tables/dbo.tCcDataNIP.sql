CREATE TABLE [dbo].[tCcDataNIP] (
  [Id] [int] IDENTITY,
  [CodSolicitud] [varchar](20) NOT NULL,
  [CodOficina] [varchar](3) NOT NULL,
  [CodSistema] [varchar](20) NOT NULL,
  [Celular] [varchar](10) NOT NULL,
  [FechaAceptacionTyC] [datetime] NOT NULL,
  [FechaCapturaNIP] [datetime] NOT NULL,
  [NIPCapturado] [varchar](4) NULL,
  CONSTRAINT [PK_tCcDataNIP] PRIMARY KEY CLUSTERED ([Id])
)
ON [PRIMARY]
GO