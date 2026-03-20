CREATE TABLE [dbo].[tAhHistoricoClabeSTP] (
  [idRegistro] [int] NOT NULL,
  [item] [int] NOT NULL,
  [altaStp] [int] NULL,
  [idStp] [varchar](5) NULL,
  [descricionIdSTP] [varchar](200) NULL,
  [fechaReg] [datetime] NULL,
  PRIMARY KEY CLUSTERED ([idRegistro], [item])
)
ON [PRIMARY]
GO