SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

CREATE VIEW [dbo].[vES]
AS

select
/*	LONGITUD DEL REGISTRO									N 5 F R
ES	Indicar la longitud en bytes del registro de consulta que se transmitirá,
	incluyendo este segmento.
	Se deberá rellenar con ceros a la izquierda para cumplir con las 5
	posiciones.
	Si no se incluye un dato válido, se rechazará el proceso de la
	consulta. */
'ES00000' +  

/*	MARCA DE FIN									A 2 F R
00	Debe colocarse lo siguiente:
	Si no se incluye un dato válido se rechazará el proceso de consulta	 */
'0002**'
as 'ES'


GO