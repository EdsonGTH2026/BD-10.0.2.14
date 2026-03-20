SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE procedure [dbo].[pLpComentariosConsulta](@idproceso int)
as
BEGIN
--Ver. 18-02-2021
set nocount on
	declare @Resultado varchar(100)
	
	select top 1 pd.IdProcesoDet, pd.IdProceso, pd.IdEstado, pd.Comentario 
	from 
	tLpProceso as p with(nolock)
	inner join tLpProcesodet as pd with(nolock) on pd.idproceso = p.idproceso
	where p.idproceso = @idproceso
	and pd.IdEstado = 3
	order by IdProcesoDet desc
	
END	
GO