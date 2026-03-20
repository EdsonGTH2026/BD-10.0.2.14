CREATE TABLE [dbo].[tSolicitudCurpExterno] (
  [IdSolicitud] [int] IDENTITY,
  [Nombres] [varchar](50) NULL,
  [Paterno] [varchar](50) NULL,
  [Materno] [varchar](50) NULL,
  [Genero] [char](1) NULL,
  [FNacimiento] [varchar](10) NULL,
  [EntidadFederativa] [char](2) NULL,
  [Existe] [char](1) NULL CONSTRAINT [DF__tCaSolici__Exist__07F6335A] DEFAULT ('0'),
  [CURP] [varchar](18) NULL,
  [CodigoRptaCCB] [varchar](10) NULL,
  [DescripcionRptaCCB] [varchar](500) NULL,
  [FechaRegistro] [datetime] NULL,
  [FechaModificacion] [datetime] NULL,
  [Usuario] [varchar](15) NULL,
  [Activo] [bit] NULL CONSTRAINT [DF_tSolicitudCurpExterno_Activo] DEFAULT (1),
  [idSolicitudCecoban] [varchar](25) NULL,
  CONSTRAINT [PK__tCaSolicitudCurp__07020F21] PRIMARY KEY CLUSTERED ([IdSolicitud])
)
ON [PRIMARY]
GO

EXEC sys.sp_addextendedproperty N'MS_Description', N'Estado del registro, colocar 0 para que no se consulte', 'SCHEMA', N'dbo', 'TABLE', N'tSolicitudCurpExterno', 'COLUMN', N'Activo'
GO