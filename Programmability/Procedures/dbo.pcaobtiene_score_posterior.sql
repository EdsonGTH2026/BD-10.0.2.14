SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE procedure [dbo].[pcaobtiene_score_posterior] @codprestamo varchar(20)
as 
set nocount on
--declare @codprestamo varchar(20)
--set @codprestamo='310-170-06-08-05184'
declare @codsolicitud varchar(20)
declare @codoficina varchar(4)
select @codsolicitud=codsolicitud,@codoficina=codoficina
from finmas.dbo.tcaprestamos with(nolock)
where codprestamo=@codprestamo

declare @idcc int
SELECT @idcc=idcc
FROM tCcConsulta with(nolock)
where cuenta=@codsolicitud and codoficina=@codoficina

--select len('NombreScore><Codigo>77</Codigo><Valor>')
insert into tCcRespuestaScore (idcc,nombrescore,valor,razon1,razon2,razon3,razon4)
select idcc,'FICO',max(xx) xx,max(razon1) razon1,max(razon2) razon2,max(razon3) razon3,max(razon4) razon4
from (
SELECT idcc--,respuesta
--,CHARINDEX ('NombreScore><Codigo>77</Codigo><Valor>',respuesta) x
--, CHARINDEX('</valor>',respuesta,CHARINDEX('NombreScore><Codigo>77</Codigo><Valor>',respuesta)) y
,case when CHARINDEX ('NombreScore><Codigo>77</Codigo><Valor>',respuesta)>0 then 
	substring(respuesta,CHARINDEX ('NombreScore><Codigo>77</Codigo><Valor>',respuesta)+38
	,CHARINDEX('</v',respuesta,CHARINDEX('NombreScore><Codigo>77</Codigo><Valor>',respuesta)) - CHARINDEX ('NombreScore><Codigo>77</Codigo><Valor>',respuesta) - 38
	) else '' end xx
	--,CHARINDEX('</valor>',respuesta,CHARINDEX('NombreScore><Codigo>77</Codigo><Valor>',respuesta)) - CHARINDEX ('NombreScore><Codigo>77</Codigo><Valor>',respuesta) - 38 t
,case when CHARINDEX('<Razon1>',respuesta)>0 then substring(respuesta,CHARINDEX('<Razon1>',respuesta)+8,2) else '' end Razon1
,case when CHARINDEX('<Razon2>',respuesta)>0 then substring(respuesta,CHARINDEX('<Razon2>',respuesta)+8,2) else '' end Razon2
,case when CHARINDEX('<Razon3>',respuesta)>0 then substring(respuesta,CHARINDEX('<Razon3>',respuesta)+8,2) else '' end Razon3
,case when CHARINDEX('<Razon4>',respuesta)>0 then substring(respuesta,CHARINDEX('<Razon4>',respuesta)+8,2) else '' end Razon4
FROM tCcConsultaRespuesta with(nolock)
where idcc=@idcc--211473
) a
group by idcc
--where xx<>''

GO