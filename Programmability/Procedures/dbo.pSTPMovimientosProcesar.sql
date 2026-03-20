SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
create procedure [dbo].[pSTPMovimientosProcesar]
as
BEGIN
set nocount on

/* 1ro se suben tx*/
insert into STPMovimProcesados
select fecha,hora,destino,abono,cargo,saldo
--,descripcion
,case when ix_cliente=0 then '' else substring(descripcion,ix_cliente+9
											,case when ix_rfc=0 
												then ix_Concepto-(ix_cliente+9)
												else ix_rfc-(ix_cliente+9) end
											) end cliente
,case when ix_rfc=0 then '' else substring(descripcion,ix_rfc+5,ix_Concepto-(ix_rfc+5)) end rfc
,case when ix_Concepto=0 then '' else substring(descripcion,ix_Concepto+10,ix_Clave_Rastreo-(ix_Concepto+10)) end concepto
,case when ix_Clave_Rastreo=0 then '' else substring(descripcion,ix_Clave_Rastreo+15
											,case when ix_Bene<ix_Clave_Rastreo+15 
												then len(descripcion)-ix_Clave_Rastreo+15 -->??? ojo se asume que despues de clave de rastreo no hay otro dato
												else ix_Bene-(ix_Clave_Rastreo+15) end) end Clave_Rastreo
,case when ix_Bene=0 then '' else substring(descripcion,ix_Bene+11
											,case when ix_Ord<ix_Bene+11
												then len(descripcion)-ix_Bene+11 -->??? ojo se asume que despues de clave de rastreo no hay otro dato
												else ix_Ord-(ix_Bene+11) end) end CtaBeneficiario
,case when ix_Ord=0 then '' else substring(descripcion,ix_Ord+11
											,len(descripcion)-ix_Ord+11) -->??? ojo se asume que despues de clave de rastreo no hay otro dato
											 end CtaOrdenante
--into STPMovimProcesados
from (
	SELECT fecha,hora,descripcion,destino,abono,cargo,saldo
	,charindex('Cliente:',descripcion) ix_cliente
	,charindex('RFC:',descripcion) ix_rfc
	,charindex('Concepto:',descripcion) ix_Concepto
	,charindex('Clave Rastreo:',descripcion) ix_Clave_Rastreo
	,charindex('Cuenta Ben:',descripcion) ix_Bene
	,charindex('Cuenta Ord:',descripcion) ix_Ord
	FROM [FinamigoSTP].[dbo].[STPMovimientos] with(nolock)
	where procesado is null or procesado=0
) a


/* 2ro se quitan caracteres especiales*/
update STPMovimProcesados
set cliente=replace(replace(cliente,char(13),''),char(10),'')
,rfc=replace(replace(rfc,char(13),''),char(10),'')
,concepto=replace(replace(concepto,char(13),''),char(10),'')
,Clave_Rastreo=replace(replace(Clave_Rastreo,char(13),''),char(10),'')
,CtaBeneficiario=replace(replace(CtaBeneficiario,char(13),''),char(10),'')
,CtaOrdenante=replace(replace(CtaOrdenante,char(13),''),char(10),'')

update STPMovimProcesados
set cliente=ltrim(rtrim(cliente))
,rfc=ltrim(rtrim(rfc))
,concepto=ltrim(rtrim(concepto))
,Clave_Rastreo=ltrim(rtrim(Clave_Rastreo))
,CtaBeneficiario=ltrim(rtrim(CtaBeneficiario))
,CtaOrdenante=ltrim(rtrim(CtaOrdenante))

/* 3ro actualiza los que se procesaron*/
update [STPMovimientos]
set procesado=1
where procesado is null or procesado=0

END
GO