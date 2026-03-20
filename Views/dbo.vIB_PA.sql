SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE VIEW [dbo].[vIB_PA]
as 
select --top 1
ud.codusuario, d.TipoDir,
/*	PRIMER LÍNEA DE DIRECCIÓN												AN	40	V	R
PA	Indicar la dirección de la ca sa del Cliente.											
	Incluir: calle o similar, número exterior e interior cuando existan.				
	En caso de report ar únicamente la calle sin el número la dirección será rechazada. 
	Si el domicilio no tiene número, especificar “SN”.				
	Para un domicilio “conocido” reportar como: “DOMICLIO CONOCIDO SN”				
	Si no se incluye un dato, se rechazará la consulta del Cliente.				*/
'PA' + dbo.fLongitudCampoINTL(replace(d.direc,'SN SN','SN'),40) +
/*	SEGUNDA LÍNEA DE DIREECCIÓN												AN	40	V	O	
00	Este campo es usado cuan do no es suficiente el campo anterior 
	de “Primer Línea de Dirección”				*/

/*	COLONIAO POBLACIÓN														AN	40	V	O			
01	Indicar la Colonia o poblaci ón si se tiene disponible.			*/	
'01' + dbo.fLongitudCampoINTL(d.Colonia,40) + 
/*	DELEGACIÓN O MUNICIPIO													AN	40	V	C
02	Indicar la Delegación o el Municipio si es que se tiene disponible.				
	En caso de no reportar la Delegación o el Municipio, el campo 03 de 
	Ciudad se hace requerido.				
	En caso de no reportar la Ciudad, el campo de Delegación o				
	Municipio se hace requerido.				
	Si no se aplica u no de los 2 puntos anteriores, la consulta se rechazará.		*/		
'02' + dbo.fLongitudCampoINTL(d.Municipio,40) + 
/* 	CIUDAD																	AN	40	V	C		
03	Indicar el nombre de la ciudad.						
	En caso de no re portar el campo 02 de “Delegación o						
	Municipio”, el ca mpo de Ciudad se hace requerido.						
	En caso de no re portar la Ciudad, el campo de Delegación o						
	Municipio se ha ce requerido.							
	Si no se aplica uno de los 2 puntos anteriores, la consulta se rechazará				*/
--'03' + dbo.fLongitudCampoINTL(d.Ciudad,40) +

/*		ESTADO								
		Indicar el código del estado de la República Mexicana donde tiene su					
		residencia el Cliente.					
04		El Anexo 10 de “Estados d e la República Mexicana” que contiene la lista de los	A	4		V	R
		códigos válidos.					
		Si no se incluye un dato o se coloca otra clave diferente se rechazará la					
		consulta.		*/						
'04' + dbo.fLongitudCampoINTL(d.edo,4) +									
/*		CÓDIGO POSTAL					
		Indicar el Código Postal correspondiente, debe ser de exactamente 5					
05		posiciones, incluyendo cer os (0) a la izquierda si así lo indica el código.	N	5		F	R
		Este dato se validará de ac uerdo a la lista de SEPOMEX, disponible en												
		Internet, y concordar con el Estado, Delegación o Municipio y Ciudad.					
		Si no concuerda o no se incluye un dato se rechazará la consulta.			*/		
'05' + dbo.fLongitudCampoINTL(d.cp,5) +									
/*		FECHA DE RESIDENCIA					
		Indicar la fecha desde la cu al el Cliente vive en la dirección reportada.					
06		El formato es DDMMAAAA:	N	8		F	O
		DD: número entre 01- 31										
		MM: número entr e 01-12					
		AAAA: año					*/
'' +									
/*		NÚMERO DE TELÉFONO					
		Indicar el número telefónic o de casa del Cliente, si se tiene el dato					
		El formato es:					
07		Código de área + hasta 8 d ígitos del teléfono	N	11		V	O
		Longitud mínima es de 5 dí gitos, no usar guiones, no repetir el mismo número,					
		ejemplo: 00000 ó 33333 ó 77777, etc.					
		Ejemplo: número telefónico de la CD. de México se reporta: 5554494949			*/		
'' +									
/*		EXTENSIÓN TELEFÓNIC A	N	8		V	O
08		Reportar si se cuenta con  l dato.		*/			
'' +												
/*		NÚMERO DE FAX EN ES TA DIRECCIÓN					
		Indicar el número telefónic o del Fax en casa del Cliente, si se tiene el dato					
		El formato es:					
09		Código de área + hasta 8 d ígitos del teléfono	N	11		V	O
		Longitud mínima es de 5 dí gitos, no usar guiones, no repetir el mismo número,					
		ejemplo: 00000 ó 33333 ó 77777, etc.					
		Ejemplo: número telefónico de la CD. de México se reporta: 5554494949			*/		
'' +		
/*		TIPO DE DOMICILIO						
		Indicar, si se tiene disponible el tipo de Domicilio que el Cliente ha proporcionado.
		Debe contener uno de los siguientes valores si es que se tiene disponible el dato:
10		B = Negocio																			A	1	F	O 
		C	= Domicilio del Usuario H = Casa
		P = Apartado Postal
		Si se incluye un valor inváli do, se tomará como blanco. */
'' +
/*		INDICADOR ESPECIAL DEE DOMICILIO				
11		Indicar el tipo de ubicación del domicilio del Cliente.				
		Debe contener uno de los siguientes valores si es que se tiene disponible el				
		dato:																			A	1	F	O
		M = Militar				
		R = Rural				
		K = Domicilio conocido			*/	
'' +
/*12	FECHA DE REPORTE DE LA DIRECCIÓN
		Indica la fecha en que se reportó la dirección en BURO DE CREDITO.
		El formato es DDMMAAAA:										N 8 F O
		 DD: número entre 01- 31
		 MM: número entre 01-12
		 AAAA: año  */	
'' +
/* 13	ORIGEN DEL DOMICILIO (PAÍS) (nueva etiqueta)								A 2 F R
		· Indicar el origen de la dirección del Acreditado.
		· El origen (país) del domicilio del Cliente se clasifica de acuerdo con el
		catálogo “Países” (ver Anexo 9 – Códigos de Países).
		NOTA:
		· La etiqueta queda activa a partir del 01 de diciembre 2015*/		
'1302MX'			
as 'PA' 
from finmas..tUsUsuarioDireccion as ud 
inner join (
	select  distinct 
	u.CodUsuario,
	--us.UsRUC as RFC,
	--u.Paterno as ApellidoPaterno,                        
	--u.Materno as ApellidoMaterno,                        
	--u.Nombres as Nombre,
	--us.UsCURP as curp,
	--convert(varchar,u.FechaNacimiento,111) as 'FechaNacimiento',
	--(select pais from tclpaises where codpais = u.codpais) as Nacionalidad,
	dir.IdDireccion,
	dir.Direccion as Calle, 
	--dir.localidad as Colonia,
	replace(replace(dir.localidad,'(',''),')','') as Colonia,
	--isnull(dir.NumInterno,'') as 'NumInt',
	--isnull(dir.NumExterno,'') as 'NumExt',
replace(dir.Direccion,'SIN NUMERO','SN') + ' ' +
	--dir.Direccion +  ' ' +
	(case when len(ltrim(rtrim(isnull(dir.NumExterno,'') + ' ' + isnull(dir.NumInterno,'')))) > 0
	then ltrim(rtrim(isnull(dir.NumExterno,'') + ' ' + isnull(dir.NumInterno,'') ))
	else 'SN'
	end) as direc,
	dir.cp as CP,
	dir.municipio as Municipio,
	replace(replace(dir.ciudad,'(',''),')','') as Ciudad,
	dir.estado as Estado,
	dir.CodEstado, 
	(case dir.codestado
	when '01' then 'AGS' when '02' then 'BCN'when '03' then 'BCS' when '04' then 'CAM' 
	when '07' then 'CHS' when '08' then 'CHI' when '09' then 'CDMX' when '05' then 'COA'
	when '06' then 'COL' when '10' then 'DGO' when '15' then 'EM' when '11' then 'GTO'
	when '12' then 'GRO' when '13' then 'HGO' when '14' then 'JAL' when '16' then 'MICH'
	when '17' then 'MOR' when '18' then 'NAY' when '19' then 'NL' when '20' then 'OAX'
	when '21' then 'PUE' when '22' then 'QRO' when '23' then 'QR' when '24' then 'SLP'
	when '25' then 'SIN' when '26' then 'SON' when '27' then 'TAB' when '28' then 'TAM'
	when '29' then 'TLAX' when '30' then 'VER' when '31' then 'YUC' when '32' then 'ZAC'
	else ''
	end) as Edo,
	--(select top 1 replace(Telefono,'_','') from dbo.tUsUsuarioDireccion where CodUsuario = u.CodUsuario) as Teléfono,
	--(case u.Sexo when 1 then 'MASCULINO' else 'FEMENINO' end) as Sexo,
	--(case u.CodEstadoCivil 
	-- when 'C' then 'CASADO' 
	-- when 'S' then 'SOLTERO' 
	-- when 'U' then 'UNION LIBRE' 
	-- else 'DESCONOCIDO' end) as EstadoCivil
	-- ,d.tiempodirdesde,d.codtipoprodirec,
	--d.FamiliarNegocio,
	dir.TipoDir	
	from finmas..tususuarios as u 
	inner join finmas..tUsUsuarioSecundarios as us on us.CodUsuario = u.CodUsuario
	inner join finmas..tClPaises as p on p.CodPais = u.CodPais
	inner join finmas..tUsUsuarioDireccion as d on d.CodUsuario = u.CodUsuario
	left join
	(	select 
		usu.codusuario, 
		usu.IdDireccion,
		( case when FamiliarNegocio = 'F' then 'FAMILIAR'
	      when FamiliarNegocio = 'N' then 'NEGOCIO'
		  else ''
		  end	) as TipoDir,
		usu.CodUbiGeo,
		ue.CodEstado,
		ue.DescUbiGeo as estado,
		um.DescUbiGeo as municipio,
		ul.DescUbiGeo as localidad,
	    ul.nomubigeo as ciudad,
		usu.Direccion, 
		isnull(usu.NumExterno, '' ) as NumExterno, 
		isnull(usu.NumInterno, '' ) as NumInterno,
		usu.Telefono as Tel,
		isnull(usu.CodPostal,'') as cp 
		from finmas..tUsUsuarioDireccion as usu 
		left outer join finmas..tclubigeo uL with(nolock) on uL.codubigeo=usu.CodUbiGeo
		left outer join finmas..tclubigeo uM with(nolock) on uM.codubigeotipo='MUNI' and uM.codarbolconta=substring(uL.codarbolconta,1,19) 
		left outer join finmas..tclubigeo uE with(nolock) on uE.codubigeotipo='ESTA' and uE.codarbolconta=substring(uL.codarbolconta,1,13) 
	) as dir on dir.codusuario = u.codusuario and dir.IdDireccion = d.IdDireccion

) as d on d.codusuario = ud.codusuario and d.iddireccion = ud.iddireccion
where 1= 1
--and ud.codusuario = 'CGB901111F6415'
--order by ud.FamiliarNegocio
GO