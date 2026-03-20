SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE procedure [dbo].[pCsCACCMontos]
as
set nocount on
create table #so(   
       codprestamo varchar(20),  
       codsolicitud varchar(20),  
       codoficina varchar(4)
)  
  
insert into #so  
select codprestamo,codsolicitud,codoficina
from finmas.dbo.tcaprestamos with(nolock)  
--where codprestamo='308-170-06-05-05417'
where codprestamo in(select codprestamo from tmpprestamos17)
and estado<>'ANULADO'   
and codoficina not in('97','98','999')

SELECT x.cuenta,x.codoficina,max(idcc) idcc
into #tmp
FROM tCcConsulta x with(nolock)
inner join #so y on x.cuenta=y.codsolicitud and x.codoficina=y.codoficina
group by x.cuenta,x.codoficina

select p.*,c.idcc
into #CC
from tCcConsulta c with(nolock)
inner join #so p on c.cuenta=p.codsolicitud and c.codoficina=p.codoficina
inner join #tmp a on c.cuenta=a.cuenta and c.codoficina=a.codoficina and c.idcc=a.idcc

SELECT idcc,max(cast(creditomaximo as decimal(16,3))) creditomaximo
into #crem
FROM tCcRespuestaCuenta with(nolock)
where idcc in(select idcc from #CC) and creditomaximo<>0
group by idcc

select c.idcc,sum(cast(case when rtrim(ltrim(creditomaximo))='' or creditomaximo is null  then '0' else creditomaximo end as decimal(16,3))) ultmomonto
--select c.idcc,case when rtrim(ltrim(creditomaximo))='' or creditomaximo is null  then '0' else creditomaximo end creditomaximo
into #cremoma
FROM tCcRespuestaCuenta c with(nolock)
inner join(
	SELECT idcc,max(cast(fechaaperturacuenta as smalldatetime)) fm
	FROM tCcRespuestaCuenta with(nolock)
	where idcc in(select idcc from #CC)  and creditomaximo<>0
	group by idcc
) a on c.idcc=a.idcc and cast(c.fechaaperturacuenta as smalldatetime)=a.fm
--where c.idcc in(9257,
--19326,
--29583
--)
group by c.idcc

select c.codprestamo,crem.creditomaximo,cremoma.ultmomonto
from #CC c
left outer join #crem crem on crem.idcc=c.idcc
left outer join #cremoma cremoma on cremoma.idcc=c.idcc

drop table #cc
drop table #cremoma
drop table #crem
drop table #so
drop table #tmp
GO