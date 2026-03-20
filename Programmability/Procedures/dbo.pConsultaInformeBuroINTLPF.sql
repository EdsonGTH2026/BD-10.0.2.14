SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
create procedure [dbo].[pConsultaInformeBuroINTLPF] (@codusuario varchar(20))
as
BEGIN
/*
--<<<<comentar
declare @codusuario varchar(20)
set @codusuario = 'UZF840524F2872'
-->>>>>>>>>>>>
*/
declare @cadena1 varchar(500)
declare @cadena2 varchar(500)
declare @longitud1 int
declare @longitud2 int
declare @longitudTot int

select 
--vPN.codusuario,

@cadena1 = 
intl.INTL + pn,

@cadena2 =
isnull(vPA_F.pa,vPA_N.pa) +
--pi+ 
es
from 

FinamigoSIC.dbo.vIB_ES as vES,
FinamigoSIC.dbo.vIB_PN as vPN 
inner join FinamigoSIC.dbo.vIB_INTL as INTL on INTL.codusuario = vpn.codusuario
left join FinamigoSIC.dbo.vIB_PA as vPA_F on vPA_F.TipoDir = 'FAMILIAR' and vPA_F.codusuario = vpn.codusuario
left join FinamigoSIC.dbo.vIB_PA as vPA_N on vPA_N.TipoDir = 'NEGOCIO' and vPA_N.codusuario = vpn.codusuario
--inner join FinamigoSIC.dbo.vPI as vPI on vPI.codusuario = vPN.codusuario
where vPN.codusuario = @codusuario --'CGB901111F6415'

--select @cadena1  --comentar
--select @cadena1  --comentar

--Obtiene la longitud de las cadenas
set @longitud1 = len(@cadena1)
set @longitud2 = len(@cadena2)
set @longitudTot = @longitud1 + @longitud2

--Actualiza la seccion correspondiente a la longitud de la cedena
set @cadena2 = replace(@cadena2,'ES000000002**','ES' + right('00000'+ convert(varchar,@longitudTot),5) + '0002**')

select isnull(@cadena1,'') as 'cadena1', isnull(@cadena2,'') as  'cadena2'

END

GO