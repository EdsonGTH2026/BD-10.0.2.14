CREATE TABLE [dbo].[tMSTareasSP] (
  [IdTareaSP] [int] IDENTITY,
  [Nombre] [varchar](30) NOT NULL,
  [Descripcion] [varchar](80) NOT NULL,
  [HoraIni] [smalldatetime] NOT NULL,
  [HoraFin] [smalldatetime] NOT NULL,
  [Dias] [varchar](20) NOT NULL,
  [RepetirNumMinutos] [int] NOT NULL,
  [Sp] [varchar](100) NOT NULL,
  [Correos] [varchar](400) NOT NULL,
  [Asunto] [varchar](200) NOT NULL,
  [Activo] [tinyint] NOT NULL,
  CONSTRAINT [PK_tMSTareasSP] PRIMARY KEY CLUSTERED ([IdTareaSP])
)
ON [PRIMARY]
GO