SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
/*
Segmento de Encabe zado o Inicio - INTL
El Segmento de Encabezado o de Inicio debe ser el primer segmento por cada registro a consultar, es un segmento requerido 
y solo debe reportarse por única vez por cada registro por consultar.
*/

CREATE VIEW [dbo].[vIB_INTL]
AS

select
u.codusuario,

--### ETIQUETA DEL SEGMENTO						
--Debe contener las letras INTL	A	4	F		R	1 - 4
--Si falta o se reporta algo diferente, se rechazará la Consulta del registro.	
'INTL' + 					
--### VERSIÓN						
--Indica la versión del formato de registro de consulta. Para Monitor es el número 12.	N	2	F		R	5 - 6
--Si falta o se reporta algo diferente, se rechazará la Consulta del registro.	
'13' + 					
--### NÚMERO DE REFERENCIA DEL OPER ADOR						
--Indicar una referencia para identificar la consulta, si la referencia es menor de 25	AN	25	F		R	7 - 31
--caracteres, incluir espacios o blancos a la izquierda hasta tener 25 caracteres.						
--Si no requiere indicar una referencia, colocar 25 espacios o blancos.						
--Si falta o se reporta algo diferente, se rechazará la Consulta del registro.	
--'                         ' +		
left(dbo.fLongitudCampoINTL(u.codusuario ,25) + '                         ',25) + 			

--### CLAVE DEL PRODUCTO REQUERIDO						
--Se debe indicar el código del producto q ue se requiere de acuerdo con el Catálogo						
--de producto requerido ubicado en el anexo 11 del presente manual.						
--Importante:						
--•   Para usar el producto indicado en esta etiqueta, es necesario contar con el	N	3	F		R	32 - 34
--    privilegio en la clave de consulta.						
--•   Para obtener el permiso de solicit ud de Score es necesario contactar a su						
--    Ejecutivo de Cuenta.						
--•   El código de producto consta de tres dígitos.		
'041' +			--reporte buro cbc score + SCORE Microfinancieras	
--### CLAVE DE PAÍS						
--Deberá contener las letras MX.	A	2	F		R	35 - 36
--Si falta o se reporta algo diferente, se rechazará la Consulta del registro.	
'MX' + 					
--### RESERVADO						
--Indicar cuatro ceros.	N	4	F		R	37 - 40
--Si falta o se reporta algo diferente, se rechazará la Consulta del registro.		
'0000' +				
--### CLAVE DEL USUARIO o MEMBER CODE						
--Contiene la clave única del Usuario para consulta, la cual fue asignada por Buró de						
--Crédito.						
--Esta clave está formada como sigue:						
--Las primeras 2 posiciones son alfab éticas y corresponden a la clave de Tipo de	AN	10	F		R	41 - 50
--Negocio o KOB (Kind of Business) del Usuario y se refiere al sector de negocio						
--descritas en el Anexo 1 de Tipos de Negocio o KOB”.						
--Los siguientes 4 números identifica  l Usuario.						
--Los últimos 4 números puede identif icar: producto y sucursales o área interna						
--del Usuario.						
--Si falta o se reporta incorrecto, se rechazará la Consulta del registro.						
--'MI25571303' + 
(select Valor from FinamigoSIC.dbo.tBuroCreditoParametros where Tipo = 'MemberCode') +

--### CONTRASEÑA O PASSWORD DE AC CESO							
--Incluir la “Contraseña” o “Password” cifra da o encriptada.							
--Para obtener y dar mantenimiento a e sta contraseña o password, seguir las						
--indicaciones de manual del Portal de Autoservicio ubicado en		AN	8	F		R	51 - 58
--BCNET>PersonasFísicas>Admin istracióndeClaves>Portal	de												
--Autoservicio>Manual  o  en  nuestro  sitio  web,  www.burodecredito.com.mx,						
--sección Otorgantes de Crédito, se ingre sa al Portal de Autoservicio y dentro de						
--la aplicación se observa el link llamado  Manual de Portal de Autoservicio.							
--Si falta o se reporta incorrecto, se rechazará la Consulta del registro.	
--'prpntxou' + 	
(select Valor from FinamigoSIC.dbo.tBuroCreditoParametros where Tipo = 'MemberPassword') +
					
--### TIPO DE RESPONSABILIDAD							
--Indicar si la solicitud del Monitor es para un crédito individual o mancomunado,						
--los valores que se pueden reportar son:		A	1	F		R	59
--A = Usuario Autorizado (Adicional)							
--I = Individual							
--J = Mancomunado							
--Si falta o se reporta incorrecto, se rechazará la Consulta del registro.
'I' +							
--### TIPO DE CONTRATO O PRODUCTO							
--Indicar el producto de la solicitud del Clie nte, los valores que pueden reportarse	A	2	F		R	60 – 61
--en este campo están indicados en el An exo 2 de “Tipo de Contrato o Producto”.							
--Si falta o se reporta incorrecto, se rechazará la Consulta del registro.	
'PL' + 						
--### MONEDA DEL CREDITO							
--Indica la moneda del crédito que solicita el Cliente, los posibles valores que							
--puede reportarse son:		A	2	F		R	62 – 63
--MX = Pesos Mexicanos    N$ = Pesos Mexicanos							
--UD = Unidades de Inversión (UDI’ s) US = Dólares Americanos							
--Si falta o se reporta incorrecto, se rechazará la Consulta del registro.							
'MX' +
--### IMPORTE DEL CONTRATO							
--Indicar nueve ceros.		N	9	F		R	64 - 72
--Si falta o se reporta incorrecto, se rechazará la Consulta del registro.							
'000000000' +
--### IDIOMA							
--Indica el idioma en que deberá emitirse los informes de Monitor del archivo.							
--EN = Inglés		A	2	F		R	73 - 74
--SP = Español							
--Si falta o se reporta incorrecto, se inc luirá SP	
'SP' +						
--### TIPO DE SALIDA							
--Indica el tipo de formato en el que se ent regarán el Reporte Monitor.							
--Los valores permitidos son:							
--01 = Archivo de cadena de da tos		N	2	F		R	75 - 76
--02 = Formato para Impresión							
--03 = Ambos							
--Si falta o se reporta incorrecto, se inc luye 01.							
'01' +
--### TAMAÑO DEL BLOQUE DEL REGISTRRO DE RESPUESTA									
--Indicar 1 blanco o espacio.						A		1	F		R		77
--Si falta o se reporta incorrecto, se rechazará la Consulta del registro.									
' ' +												
--### IDENTIFICACIÓN DE LA IMPRESORA												
--Deberá reportarse 4 espacios o blancos.					AN		4	F		R		78 – 81
--Si falta o se reporta incorrecto, se rechazará la Consulta del registro.									
'    ' +												
--### RESERVADO PARA USO FUTUROO												
--Indicar siete ceros.						N		7	F		R		82 – 88												
--Si  falta  o  se  reporta  incorrectoo,  se  rechazará  la  Consulta  del									
--registro.													
'0000000'
as 'INTL'
from Finmas..tususuarios as u 
--where u.codusuario = 'CGB901111F6415'
GO