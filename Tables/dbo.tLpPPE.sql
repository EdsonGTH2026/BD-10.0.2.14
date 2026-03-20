CREATE TABLE [dbo].[tLpPPE] (
  [IdPPE] [int] IDENTITY,
  [IdProceso] [int] NOT NULL,
  [EsPersonaExpuesta] [varchar](2) NOT NULL,
  [CargoPublico] [varchar](60) NOT NULL,
  [DependenciaCargo] [varchar](60) NOT NULL,
  [TieneParentesco] [varchar](2) NOT NULL,
  [ParienteApePat] [varchar](20) NOT NULL,
  [ParienteApeMat] [varchar](20) NOT NULL,
  [ParienteNombres] [varchar](30) NOT NULL,
  [ParienteParentesco] [varchar](20) NOT NULL,
  [ParienteCargoPublico] [varchar](60) NOT NULL,
  [ParienteDependenciaCargo] [varchar](60) NOT NULL,
  [FechaAlta] [smalldatetime] NOT NULL,
  [CodUsAlta] [varchar](20) NOT NULL,
  CONSTRAINT [PK_tLpPPE] PRIMARY KEY CLUSTERED ([IdPPE])
)
ON [PRIMARY]
GO