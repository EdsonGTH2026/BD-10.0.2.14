SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

CREATE FUNCTION [dbo].[fCC_PersonaDomicilio] (@codusuario varchar(20))
returns varchar(400)
AS 
begin
declare @cadena varchar(400)

select
@cadena = '<Domicilio>' +
/*						Reportar el nombre de la calle, número exterior, número interior. Deben considerarse avenida, cerrada, manzana, lote, edificio, departamento etc. Debe contener por lo menos dos cadenas de caracteres para que el registro sea válido, de lo contrario el registro será rechazado
	Dirección			!	!		A	80				*/
'<Direccion>' + left(replace(replace(d.direc,'SN SN','SN'),'S/N','SN'),80) + '</Direccion>' +
						
--	Colonia o Población	A	65	!	Reportar la colonia a la cual pertenece la dirección contenida en el Elemento dirección. Este elemento es requerido para los productos de reporte consolidado (5,6,9,26,27,28,76,78)
'<ColoniaPoblacion>' + left(d.Colonia,65) + '</ColoniaPoblacion>' +						
						
/*						Reportar la delegación a la cual pertenece la dirección contenida en el Elemento Dirección. Este elemento es requerido para los productos de reporte consolidado (5,6,9,26,27,28,76,78)
Delegación o Municipio		A	65	!	!	*/				
'<DelegacionMunicipio>'+ left(d.Municipio,65) + '</DelegacionMunicipio>'	+					
						
						
--Ciudad	A	65	!	! Reportar la Ciudad a la cual pertenece la dirección contenida en el Elemento Dirección. Este elemento es requerido para los productos de reporte consolidado (5,6,9,26,27,28,76,78)
'<Ciudad>' + left(d.Ciudad,65) + '</Ciudad>'	+					

--Estado	C	4	!	!	**Ver en Tabla: Estados de la República
'<Estado>'+ left(d.edo,4) +'</Estado>'	+	
						
--Código Postal N	5	!	!	El código postal reportado debe estar compuesto por 5 dígitos. Para que el código postal sea válido deberá corresponder al Estado Reportado. Ver Tabla: Rangos Códigos Postales						
'<CP>' + left(d.cp,5) + '</CP>' +
'</Domicilio>'
from finmas..tUsUsuarioDireccion as ud 
inner join (
	select  distinct 
	u.CodUsuario,
	dir.IdDireccion,
	dir.Direccion as Calle, 
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
	when '01' then 'AGS' when '02' then 'BC'when '03' then 'BCS' when '04' then 'CAMP' 
	when '07' then 'CHIS' when '08' then 'CHIH' when '09' then 'CDMX' when '05' then 'COAH'
	when '06' then 'COL' when '10' then 'DGO' when '15' then 'MEX' when '11' then 'GTO'
	when '12' then 'GRO' when '13' then 'HGO' when '14' then 'JAL' when '16' then 'MICH'
	when '17' then 'MOR' when '18' then 'NAY' when '19' then 'NL' when '20' then 'OAX'
	when '21' then 'PUE' when '22' then 'QRO' when '23' then 'QROO' when '24' then 'SLP'
	when '25' then 'SIN' when '26' then 'SON' when '27' then 'TAB' when '28' then 'TAMP'
	when '29' then 'TLAX' when '30' then 'VER' when '31' then 'YUC' when '32' then 'ZAC'
	else ''
	end) as Edo,
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
and ud.codusuario = @codusuario --'CGB901111F6415'
order by ud.FamiliarNegocio

set @cadena = isnull(@cadena,'')

return @cadena
END
GO