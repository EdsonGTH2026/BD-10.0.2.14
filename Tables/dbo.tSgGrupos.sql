CREATE TABLE [dbo].[tSgGrupos] (
  [CodGrupo] [varchar](5) NOT NULL,
  [Grupo] [varchar](50) NULL,
  [Descripcion] [varchar](50) NULL,
  [FechaReg] [smalldatetime] NULL,
  [Activo] [bit] NULL,
  [FechaInactivo] [smalldatetime] NULL,
  [Perfil] [varchar](10) NULL
)
ON [PRIMARY]
GO