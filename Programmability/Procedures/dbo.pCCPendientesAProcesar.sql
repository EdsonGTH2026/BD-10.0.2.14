SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE procedure [dbo].[pCCPendientesAProcesar]
as
declare @tbl table (IdCC int, CodUsuario varchar(20),  FechaRegistro datetime, CodOficina varchar(4), Cuenta varchar(20))
insert into @tbl
select top 10 IdCC, CodUsuario,  FechaRegistro, CodOficina, Cuenta
from tCcConsulta with(nolock)
where  1= 1
and activo = 1 
and procesado = 2 
and encola=0
and FechaRegistro>='20220101'
order by FechaRegistro --desc

update tCcConsulta
set encola=1
where idcc in(select idcc from @tbl)

select * from @tbl
GO