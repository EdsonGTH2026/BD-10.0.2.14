CREATE TABLE [dbo].[tCaSolicitudCurpExterno] (
  [IdSolicitud] [int] IDENTITY,
  [Nombres] [varchar](50) NULL,
  [Paterno] [varchar](50) NULL,
  [Materno] [varchar](50) NULL,
  [Genero] [char](1) NULL,
  [FNacimiento] [varchar](10) NULL,
  [EntidadFederativa] [char](2) NULL,
  [Existe] [char](1) NULL,
  [CURP] [varchar](18) NULL,
  [CodigoRptaCCB] [varchar](10) NULL,
  [DescripcionRptaCCB] [varchar](100) NULL,
  [FechaRegistro] [datetime] NULL,
  [FechaModificacion] [datetime] NULL,
  [Usuario] [varchar](15) NULL
)
ON [PRIMARY]
GO