CREATE TABLE [dbo].[tTAE_calls_log] (
  [idtae] [int] NOT NULL,
  [item] [int] NOT NULL,
  [registro] [datetime] NULL,
  [xconsulta] [varchar](500) NULL,
  [xrespuesta] [varchar](1000) NULL,
  CONSTRAINT [PK_tTAE_calls_log] PRIMARY KEY CLUSTERED ([idtae], [item])
)
ON [PRIMARY]
GO