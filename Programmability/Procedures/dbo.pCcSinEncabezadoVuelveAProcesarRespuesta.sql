SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
create procedure [dbo].[pCcSinEncabezadoVuelveAProcesarRespuesta]
as
BEGIN
	update c set
	procesado = 2
	from  
	finamigosic..tCcConsulta as c 
	left join finamigosic..tCcRespuestaEncabezado as re on c.idcc = re.idcc
	left join finamigosic.dbo.tCcRespuestaScore as sc on sc.idcc = c.idcc
	where c.procesado= 1
	and isnull(re.idcc,0) = 0
	--and isnull(sc.idscore,0) = 0
	and len(c.respuesta) > 23
	and c.fecharespuesta > '20200801'
END
GO