CREATE TABLE [dbo].[tLpBeneficiario] (
  [IdBeneficiario] [int] IDENTITY,
  [IdProceso] [int] NOT NULL,
  [APaterno] [varchar](20) NULL,
  [AMaterno] [varchar](20) NULL,
  [Nombres] [varchar](20) NULL,
  [FecNacimiento] [smalldatetime] NULL,
  [Genero] [varchar](1) NULL,
  [BeneCodParentesco] [varchar](5) NULL,
  [FechaAlta] [smalldatetime] NOT NULL,
  [CodUsAlta] [varchar](20) NOT NULL,
  CONSTRAINT [PK_tLpBeneficiario] PRIMARY KEY CLUSTERED ([IdBeneficiario])
)
ON [PRIMARY]
GO