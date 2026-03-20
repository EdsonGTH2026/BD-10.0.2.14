SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
create procedure [dbo].[pCC_Consultaxid] @idcc int
as
select IdCC, CodUsuario, Consulta, Procesado, FechaRespuesta, isnull(CodOficina,'') as CodOficina, isnull(Cuenta,'') as Cuenta, 
 isnull(NumConsultas,0) as NumConsultas 
, isnull(Tipo,'') as Tipo 
from tCcConsulta with(nolock) 
where Activo = 1 and IdCC = @idcc--167601
GO