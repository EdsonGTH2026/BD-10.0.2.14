SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE FUNCTION [dbo].[fCC_Encabezado_Especial]()
returns varchar(200)
AS 
begin
declare @cadena varchar(200)

	select @cadena = '<Encabezado>' +
	/*						La Clave de Otorgante está constituida por:						
							Posiciones 1- 6 … Corresponde a la Clave de Negocio del Otorgante
							Posiciones 7- 10 … Corresponde al Producto o Sucursal del Otorgante.
							Nota: Esta Clave es proporcionada por Círculo de Crédito
							 Clave de Otorgante	N	10	!	! */
	'<ClaveOtorgante>'+ (select rtrim(valor) from tCCParametros where tipo = 'ClaveOtorgante' and activo = 1) + -- '0000081008'+	  	
	'</ClaveOtorgante>' +
												
	/*    Nombre de Usuario					Contiene el nombre del usuario que realiza la Consulta..
			A	12	!	!	*/
	'<NombreUsuario>' + (select rtrim(valor) from tCCParametros where tipo = 'NombreUsuario' and activo = 1) + -- 'IHG8728CCO' + 	
	'</NombreUsuario>' +

	/*						El Password para acceso a la Base de Datos es asignada por el Círculo de Crédito
				!	!			A	16	 */
	'<Password>' + (select rtrim(valor) from tCCParametros where tipo = 'Password' and activo = 1) + --'pru3ba00' +
	'</Password>'+	

	/*						Contiene el valor de la versión de XML requerida. En caso de no contener esta etiqueta el valor de fault será 1. La versión mas reciente
							actualmente es 2.
		Version XML	N	3	!	!	
				*/			
	'<VersionXML>2</VersionXML>' +
	
	'</Encabezado>' 
	--as Encabezado
	
	return @cadena
end
GO