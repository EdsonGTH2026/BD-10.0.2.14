SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE FUNCTION [dbo].[fCC_PersonaNombre] (@codusuario varchar(20))
returns varchar(300)
AS 
BEGIN
--ver 14-11-2020
declare @cadena varchar(300)

SELECT @cadena =
--	Apellido	C	30	!	!	Reportar el Apellido Paterno completo, no usar abreviaturas o iniciales
--	Paterno						Cuando solo se reporte un Apellido, este debe ser puesto en Apellido Paterno y el Apellido Materno contendrá “NO
'<ApellidoPaterno>' +
(case when rtrim(ltrim(u.Paterno)) <> '' then left(u.Paterno, 30)
    else left(u.Materno, 30)
	end) +	
'</ApellidoPaterno>' +

--	Apellido Materno	C	30	!	!	PROPORCIONADO”.
'<ApellidoMaterno>' + 
(case when rtrim(ltrim(u.Paterno)) <> '' then
	(case when ltrim(u.Materno) <> '' then left(u.Materno, 30)
	    else left('NO PROPORCIONADO', 30)
	end)
 else
    left('NO PROPORCIONADO', 30)
 end) +
'</ApellidoMaterno>'	+					
						
--	Apellido Adicional	C	30			Puede utilizarse para reporta el Apellido de casada.
--<ApellidoAdicional><ApellidoAdicional>						

--						Reportar Primer Nombre, Segundo Nombre y/o Nombres compuestos del consumidor.
--	Nombres	C	50	!	!	No se aceptan abreviaciones.
'<Nombres>' +
--left(rtrim(case when PATINDEX ('% %',u.Nombres ) = 0 then u.Nombres else substring(u.Nombres, 1, PATINDEX ('% %',u.Nombres )) end), 50) + 
left(rtrim(u.Nombres), 50) + 										
'</Nombres>' +

--						Formato: AAAA-MM-DD
--	Fecha de Nacimiento	N	10	!	!	Nota: No se deben de reportar fechas de nacimiento menores de 15 años y mayores de 100 años.
'<FechaNacimiento>' + 
convert(varchar,FechaNacimiento,23) + 
'</FechaNacimiento>' +	
				
/*	Reglas:
	- Las primeras 4 posiciones deben ser
	alfabéticas.
	- 5 y 6 deben contener un número de 00 y
	99
	- 7 y 8 deben contener un número de 01 a
	Clave de RFC	A	13	!		12
	- 9 y 10 deben contener un número de 01
	31
	- 11 -13 Homo clave
	La homoclave, es opcional.
	Este elemento es requerido para los
	productos de reporte consolidado
	(5,6,9,26,27,28,76,78) */
'<RFC>' +
left(us.UsRUC, 13) +
'</RFC>' +				
	
/*					Reglas:
					-  1 a 4 posiciones deben ser alfabéticas.
					-    5 y 6 posiciones deben contener un número entre 00 y 99 (año).
					-    7 y 8 posiciones deben contener un número entre 01 y 12 (mes).
					-    9 y 10 posiciones deben contener un número entre 01 y 31 (día).
	CURP	A	18	-  11-16 posiciones deben ser alfabéticas.
					-  17 numérico (Homoclave).
					-  18 numérico (Digito Verificador). */
--<CURP></CURP>						
												
--Nacionalidad	C	2	!	Debe contener la clave de la nacionalidad del consumidor						
--Ver Anexos A: Tabla de Nacionalidades						
'<Nacionalidad>' +
+ left((case when codpais = '4024' then 'MX' else '' end), 2) + 						
'</Nacionalidad>' 

--Residencia	N	1			Valores posibles para este campo: 1 = Propietario 2 = Renta 3 = Vive con familiares 4 = Vivienda Hipotecada			
--<Residencia></Residencia>		
				
--						Valores posibles para este campo: D = Divorciado
--						L = Unión Libre C = Casado
--						S = Soltero V = Viudo
--Estado Civil	C	1	E = Separado
--<EstadoCivil></EstadoCivil>		
				
--Sexo	C	1			Valores para este campo:
--						F = Femenino
--						M = Masculino
--<Sexo></Sexo>

--	Clave de Elector (IFE)	A	20						
--<ClaveElectorIFE></ClaveElectorIFE>		
									
-- Número de Dependientes	N	2	Se debe de reportar el número de Dependientes Económicos del Consumidor		
--<NumeroDependientes><NumeroDependientes>	
					
--Fecha de Defunción		N	10			Debe reportarse la fecha en que el consumidor falleció.			
--<FechaDefuncion></FechaDefuncion>						

from Finmas..tususuarios as u 
inner join Finmas..tUsUsuarioSecundarios us on us.codusuario = u.codusuario
where u.codusuario = @codusuario --'ESM690703F3FG2'  --COMEMTAR

return @cadena

END
GO