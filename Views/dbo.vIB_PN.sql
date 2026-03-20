SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

/*
Segmento de Nombre del Cliente - PN
Este Segmento se utiliza para inclui r el nombre completo del Cliente, para obtener Monitor.
Este segmento es requerido y debe presentar una sola vez por cada Informe solicitado.
La Etiqueta o Nombre debe present arse antes del dato indicado por cada campo.
*/

CREATE VIEW [dbo].[vIB_PN]
as

select 
u.codusuario, 
/*			### APELLIDO PATERNO					
			Indicar el apellido paterno co mpleto del Cliente, sin abreviaturas.					
			Si el apellido paterno contiene múltiples palabras, deberá separarse con					
			espacios. Ejemplo: Pérez Nieto, Del Campo, Martínez de Escobar, De la O.					
			Debe contener 3 letr as o más					
PN		    No debe contener caracteres especiales	A	2 6	V	R
			No debe haber más de un espacio entre palabras				
									
			No debe contener pr efijos personales o profesionales: Jr., Tercero o III,					
				Lic., Ing., etc.					
			Reportar tal como está en los documentos oficiales de identificación					
				como la credencial del IFE, pasaporte vigente, forma FM2 para					
				extranjeros.					
			Si no se incluye un dato válido, se rechazará la solicitud de este Cliente.		*/	

(case when rtrim(ltrim(u.Paterno)) <> '' then 'PN' + dbo.fLongitudCampoINTL(u.Paterno, 26)
    else 'PN' + dbo.fLongitudCampoINTL(u.Materno, 26)
end) +		
--'PN' + dbo.fLongitudCampoINTL(u.Paterno, 26) + 								
/*			### APELLIDO MATERNO					
			Indicar el apellido materno completo del Cliente, sin abreviaturas.					
			Si el apellido materno contiene múltiples palabras, deberá separarse con					
			espacios. Por ejemplo: Pérez Nieto, Del Campo, Martínez de Escobar, De la O.					
			Si no existe apellido materno o el paterno debido a que es extranjero o no lo					
			lleva en sus documentos oficiales, deberá colocarse el único apellido en el					
			campo de “Apellido Paterno” e incluirse en este campo la frase “NO					
			PROPORCIONADO”					
00				Debe contener 3 letr as o más	A	2 6	V	R
									
			No debe contener caracteres especiales					
				No debe haber más de un espacio entre palabras					
			No reportar el apellido de casada					
			Reportar tal como está en los documentos oficiales de identificación					
				como la credencial del IFE, pasaporte vigente, forma FM2 para					
				extranjeros.					
			Si no se incluye un dato válido, se rechazará la solicitud de este Cliente.		*/	

(case when rtrim(ltrim(u.Paterno)) <> '' then
	(case when ltrim(u.Materno) <> '' then '00' + dbo.fLongitudCampoINTL(u.Materno, 26)
	    else '00' + dbo.fLongitudCampoINTL('NO PROPORCIONADO', 26)
	end)
 else
    '00' + dbo.fLongitudCampoINTL('NO PROPORCIONADO', 26)
 end) 
 +
--'00' + dbo.fLongitudCampoINTL(u.Materno, 26) + 								
/*			### APELLIDO ADICIONAL					
			Para mujeres, se puede indic ar el apellido de casada, sin abreviaturas.					
01			Si el apellido adicional contien e dos o más palabras deberán separarse con	A	2 6	V	O
			espacios. Por ejemplo: Pérez Nieto, Del Campo, Martínez de Escobar, De la O.					
			Si no se cuenta con este dato o no existe, no es necesario incluirlo.					*/


/*			### PRIMER NOMBRE							
				Indicar el primer	nombre completo del Cliente, solo letras					
02				Sin abreviaturas			A	2 6	V	R
										
			Debe contener 3 letras o más					
			Si no se incluye un dato, se rechazará el registro completo de la					
			consulta.								*/
'02' + dbo.fLongitudCampoINTL((case when PATINDEX ('% %',u.Nombres ) = 0 then u.Nombres else substring(u.Nombres, 1, PATINDEX ('% %',u.Nombres )) end), 26) + 										
/*			### SEGUNDO NOMBRE							
			Si el Cliente tiene 2 o más  ombres, del segundo en adelante indicarlos en					
			este campo separándose c on espacios. Por ejemplo: del Rosario, de la					
			Asunción, Silvia Inés.							
03				Reportar el segu	do o más nombre(s) completo(s) del Cliente, si	A	2 6	V	O
										
				existe(n)							
				Sin abreviaturas							
			Debe contener 3 letras o más					*/
(case when PATINDEX ('% %',u.Nombres ) > 1 then '03' + dbo.fLongitudCampoINTL(substring(u.Nombres, PATINDEX ('% %',u.Nombres )+1, 20), 26) else '' end) + 										
/*			### FECHA DE NACIMIENTO							
			Indicar la fecha de nacimie	to del Cliente. Este dato es altamente					
			recomendable que se infor me ya que es importante para asegurar la					
			localización del Cliente correcto.					
			El formato es DDMMAAAA:							
04				DD: número entr	01- 31		N	8		F	O
											
			MM: número entre 01-12					
				AAAA: año							
			Nota: No se deben reportar fechas de nacimiento para menores de 18 años.					
			Si no se tiene disponible, no reportar.			*/		
'04' + dbo.fLongitudCampoINTL(replace(convert(varchar,FechaNacimiento,103),'/',''), 8) + 											
/*			### RFC								
			Indicar el RFC (Registro Federal de Contribuyentes) del Cliente, al menos					
			las 10 primeras posiciones y si es posible con los 3 caracteres de la					
			homoclave.							
			Para cuentas con fecha de apertura posterior a enero de 1998, el RFC del					
05			Cliente es requerido			AN	1 3	V	O
										
			Se validará que tenga la sig uiente estructura:					
			AAAANNNNNNZZZ							
			A – Alfabético (Letras del nombre)					
			N – Número (Fecha d e nacimiento)					
			Z – Alfanumérico (Homoclave)			*/		
'05' + dbo.fLongitudCampoINTL(us.UsRUC, 13) + 									
/*			### PREFIJO PERSONAL O PROFESIONAL					
06			Indicar la profesión del Clie nte, si se tiene el dato, de acuerdo a los valores	A	4		V	O
			mostrados en el Anexo 8 de	“Prefijos personales y profesionales.				*/	
'' +
/*			### SUFIJO PERSONAL DEL CLIENTE					
			Indicar el sufijo, si se tiene el dato.					
07			Algunos valores posibles so n:	A	4		V	O
			JR = Junior					
								
			II	= Segundo					
			III	= Tercero			*/		
'' +									
/*			### NACIONALIDAD					
08			Indicar la Nacionalidad del Cliente de acuerdo al Anexo 9 de “Países y	A	2		F	O
			monedas”.						*/		
'08' + dbo.fLongitudCampoINTL((case when codpais = '4024' then 'MX' else '' end), 4) + 									
/*			### TIPO DE RESIDENCIA					
			Indicar si la vivienda que oc upa el Cliente es propietario, renta o vive con					
09			familiares o pensión.	N	1		F	O
			Los valores permitidos son:					
								
			1 = Propietario.					
			2 = Renta.					
			3 = Pensión / Vive con familiares		*/
'' + 
/*			
10			### NÚMERO DE LICENCIA DE CONDUCIR	AN	2 0	V	O
			Indicar el número de licencia de conducir.				*/
								
'' + 									
/*			### ESTADO CIVIL					
			Indicar, si la información está disponible.					
			Los valores son:					
11			D	=	Divorciado	A	1		F	O
			F	=	Unión Libre					
										
			M  =	Casado					
			S	=	Soltero					
			W  =	Viudo				*/	
'' + 											
/*			### GÉNERO								
12			Indicar	los valores que pueden ser:	A	1		F	O
			F	=	Femenino					
										
			M	=	Masculino				*/	
'' +	
/*								
13			### NÚMERO DE CÉDULA PROFESIONAL	AN	2 0	V	O
			Indicar el dato si se tiene disponible.			*/	
								
									
/*			### NÚMERO DE REGISTRO ELECTORAL (IFE)					
			Indicar el dato si se tiene disponible.					
			El dato a reportar se encue ntra ubicado en las partes marcadas de las					
			imágenes.							
14								AN	2 0	V	O    */
'' +
/*			### CLAVE DE IDENTIFICACIÓN ÚNICA (CURP EN MEXICO)									
			Indicar el número de ide ntificación única, si se tiene disponible, esto								
15		dependerá de la Nacionaalidad del Cliente.				AN	20		V	O
		Si el Cliente es de México, se podrá capturar la CURP.							
												
			Si se reporta un dato en este campo, será requerido el campo 16								
			“CLAVE DE PAÍS”.			*/										
'' +																	
/*			### CLAVE DE PAÍS														
16		Indicar la clave del país de ciudadanía del Cliente, si se tiene disponible,			A	2		F	O
			de acuerdo al Anexo 9 de “Países y monedas”.			*/							
'' +															
/*			### NÚMERO DE DEPENDIENTES												
17		Indicar el número de personas que dependen económicamente del			N	2		F	O
		Cliente, hasta 15 depend ientes.											
															
			Si el número es de solo un dígito, colocar un cero (0) a la izquierda.				*/				
'' +														
/*			### EDADES DE LOS DEPE NDIENTES											
			Son las edades de los d ependientes mencionados en el campo anterior								
			y se pueden indicar hasta 15 dependientes.										
18		Estas edades se deberá n indicar de forma consecutiva usando 2				N	30		V	O
		caracteres por cada edad del dependiente, por ejemplo, si son tres								
			dependientes y la edad de uno de ellos es menor a 1 año, la edad del								
			segundo es de 19 años y la edad del tercero es de 75 años, entonces,								
			se deberá indicar 01197 5 de forma consecutiva y sin espacios.									
			Las edades menores de 1 año se indican como 01.					*/				
'' 
as PN
from Finmas..tususuarios as u 
inner join Finmas..tUsUsuarioSecundarios us on us.codusuario = u.codusuario

--where u.codusuario = 'ESM690703F3FG2'  --COMEMTAR
GO