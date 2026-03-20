CREATE TABLE [dbo].[tOPRRegion] (
  [IdRegion] [int] IDENTITY,
  [IdDoc] [int] NOT NULL,
  [X1] [int] NOT NULL,
  [Y1] [int] NOT NULL,
  [X2] [int] NOT NULL,
  [Y2] [int] NOT NULL,
  [Tipo] [varchar](20) NOT NULL,
  [Texto] [varchar](50) NOT NULL,
  CONSTRAINT [PK_tOPRRegion] PRIMARY KEY CLUSTERED ([IdRegion])
)
ON [PRIMARY]
GO