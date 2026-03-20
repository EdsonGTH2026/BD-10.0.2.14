CREATE TABLE [dbo].[tRespuestaConsultaCurp] (
  [idConsulta] [int] NOT NULL,
  [codUsuario] [varchar](50) NULL,
  [solcitudId] [varchar](18) NULL,
  [curp] [varchar](18) NULL,
  [fechaRespuesta] [datetime] NULL,
  [curpValido] [bit] NULL,
  [apellidoPaterno] [varchar](30) NULL,
  [apellidoMaterno] [varchar](30) NULL,
  [nombres] [varchar](100) NULL,
  [sexo] [varchar](1) NULL,
  [fechaNacimiento] [smalldatetime] NULL,
  [entidadFederativaNacimiento] [varchar](3) NULL,
  [claveNacionalidad] [varchar](10) NULL,
  [tipoDocumentoProbatorio] [int] NULL,
  [estatusCurp] [varchar](50) NULL,
  [digestivoEntrada] [varchar](50) NULL,
  [digestivoSalida] [varchar](50) NULL,
  [timeStampCadena] [varchar](50) NULL,
  [digestivoTimeStamp] [varchar](50) NULL,
  [fechaValidacion] [smalldatetime] NULL,
  [codigoRespuestaCCB] [varchar](10) NULL,
  [descripcionRespuestaCCB] [varchar](100) NULL,
  [servicioEnvio] [varchar](10) NULL,
  CONSTRAINT [PK_tRespuestaConsultaCurp] PRIMARY KEY CLUSTERED ([idConsulta])
)
ON [PRIMARY]
GO