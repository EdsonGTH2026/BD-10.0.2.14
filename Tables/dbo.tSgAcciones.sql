CREATE TABLE [dbo].[tSgAcciones] (
  [CodSistema] [char](2) NOT NULL,
  [CodGrupo] [varchar](5) NOT NULL,
  [Opcion] [varchar](10) NOT NULL,
  [Acceder] [bit] NOT NULL,
  [Anadir] [bit] NOT NULL,
  [Editar] [bit] NOT NULL,
  [Grabar] [bit] NOT NULL,
  [Cancelar] [bit] NOT NULL,
  [Eliminar] [bit] NOT NULL,
  [Imprimir] [bit] NOT NULL,
  [Cerrar] [bit] NOT NULL
)
ON [PRIMARY]
GO