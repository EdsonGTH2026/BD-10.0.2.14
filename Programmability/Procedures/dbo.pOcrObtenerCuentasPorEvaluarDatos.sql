SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
create procedure [dbo].[pOcrObtenerCuentasPorEvaluarDatos] (@IdTipoDoc int)
as
BEGIN
	set nocount on
	select IdImagen, codigocuenta, TipoDoc 
	from finamigodocs.dbo.tocrdatosimagen as d 
	where d.TipoDoc = @IdTipoDoc 
	and d.envio = 1 and len(isnull(d.texto,'')) > 30 
	and d.TextoProcesado = 1
	and isnull(d.EvaluacionDatos,'') = ''
END
GO