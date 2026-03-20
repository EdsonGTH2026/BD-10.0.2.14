CREATE TABLE [dbo].[tOcrFrenteINE] (
  [CodCuenta] [varchar](25) NOT NULL,
  [Nombre] [varchar](30) NULL,
  [ApPaterno] [varchar](30) NULL,
  [ApMaterno] [varchar](30) NULL,
  [FechaNacimiento] [smalldatetime] NULL,
  [Vigencia] [varchar](4) NULL,
  [NombreArchivo] [varchar](200) NULL
)
ON [PRIMARY]
GO