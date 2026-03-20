CREATE TABLE [dbo].[tSgUsuarios] (
  [Usuario] [varchar](20) NOT NULL,
  [CodUsuario] [char](15) NULL,
  [NombreCompleto] [varchar](100) NULL,
  [Descripcion] [text] NULL,
  [Contrasena] [varchar](100) NOT NULL,
  [FechaAlta] [smalldatetime] NULL,
  [FechaVigencia] [smalldatetime] NULL,
  [CambiaContrasena] [bit] NOT NULL,
  [RenuevaVigencia] [bit] NOT NULL,
  [Activo] [bit] NULL,
  [CodOficina] [varchar](4) NULL,
  [TodasOficinas] [bit] NULL,
  [PerfilRegistrado] [varchar](50) NULL
)
ON [PRIMARY]
TEXTIMAGE_ON [PRIMARY]
GO