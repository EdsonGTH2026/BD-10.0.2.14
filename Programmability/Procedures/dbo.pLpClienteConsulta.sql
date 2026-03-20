SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE procedure [dbo].[pLpClienteConsulta](@IdProceso int)
as
BEGIN
--declare @IdProceso int
--set @IdProceso=10

	--Ver. 20-01-2021
	--Ver. 09-01-2021: modificado por Christofer
	set nocount on
	
	select  
	lp.IdCliente,p.IdProceso,lp.APaterno,lp.AMaterno,lp.Nombres,
	
	isnull(lp.FecNacimiento,(
	(case when substring(sp.CURP,5,1) in ('0','1','2','3') then '20' + substring(sp.CURP,5,2)
	else '19' + substring(sp.CURP,5,2) end) + substring(sp.CURP,7,2) + substring(sp.CURP,9,2)
	) ) as FecNacimiento,	

	--substring(sp.CURP,5,2) as a,
	--substring(sp.CURP,7,2) as m,
	--substring(sp.CURP,9,2) as d,	
	--(substring(sp.CURP,9,2) + '/' + substring(sp.CURP,7,2) + '/' +
	--(case when substring(sp.CURP,5,1) in ('0','1','2','3') then '20' + substring(sp.CURP,5,2)
	--else '19' + substring(sp.CURP,5,2) end))  as xx,
	
	lp.CodDocIden,lp.DI,
	lp.CodEstadoCivil,
	(case lp.CodEstadoCivil 
	when 'S' then 'SOLTERO'
	when 'C' then 'CASADO'
	when 'U' then 'UNION LIBRE'
	else 'OTRO' end
	) as EstadoCivil,
	lp.Genero,
	(case lp.Genero 
	when 'M' then 'MASCULINO'
	when 'F' then 'FEMENINO'
	else '' end
	) as GeneroDesc,
	lp.FamiliarNegocio,lp.Direccion,lp.NumExterno,lp.NumInterno,lp.Ubicacion,lp.CodPostal,lp.localidad,lp.EsPrincipal,
	lp.TiempoDirDesde,lp.TiempoCiudad
	,lp.Telefono
	,lp.Observaciones,lp.EstadoNacimiento,
	isnull(lp.CURP,sp.CURP) as CURP,
	--lp.RFC,
	isnull(lp.RFC,substring(sp.CURP,1,10)) RFC
	--RFC= dbo.fduCalculoRFC2017(@BeneNombres,@BeneAPaterno,@BeneAMaterno,@BeneFecNacimiento),
	,isnull(lp.Celular,sp.NumCelular) as Celular,
	lp.LabActividad,
	lp.Correo,
	lp.ClaveBancoSTP, 
	lp.CLABE
	from tLpProceso as p with(nolock)
	inner join tLpSolicitudPromotor as sp with(nolock) on sp.IdSolicitudPromotor = p.IdSolicitudPromotor
	left join tLpCliente as lp with(nolock) on lp.idproceso = p.idproceso
	where p.idproceso = @IdProceso
END	
GO