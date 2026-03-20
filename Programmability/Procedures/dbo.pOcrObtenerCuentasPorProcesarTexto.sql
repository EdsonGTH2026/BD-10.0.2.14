SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
create procedure [dbo].[pOcrObtenerCuentasPorProcesarTexto] (@IdTipoDoc int)
as
BEGIN
	set nocount on
	select codigocuenta,TipoDoc 
	from finamigodocs.dbo.tocrdatosimagen as d 
	where d.TipoDoc = @IdTipoDoc 
	and d.envio = 1 and len(isnull(d.texto,'')) > 30 
	and isnull(d.TextoProcesado,0) = 0
END
GO