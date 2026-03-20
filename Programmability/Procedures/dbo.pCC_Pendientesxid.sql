SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE procedure [dbo].[pCC_Pendientesxid]
as
declare @tbl table (IdCC int, CodUsuario varchar(20),  FechaRegistro datetime, Tipo varchar(20))
insert into @tbl

select top 10 IdCC, CodUsuario,  FechaRegistro, isnull(Tipo,'') as Tipo 
from tCcConsulta  with(nolock)
where  1= 1
and isnull(tipo,'') in ('R' ,'M', 'E')
and activo = 1 
and procesado = 0 
and encolacc=0
and comentario not like '%AUT SP%' 
order by fecharespuesta 

update tCcConsulta
set encolacc=1
where idcc in(select idcc from @tbl)

select * from @tbl
GO