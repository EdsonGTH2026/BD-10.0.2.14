SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE procedure [dbo].[pLpSolicitudConsultar]( @IdProceso int)
as
BEGIN
	select IdSolicitud, IdProceso,CodProducto, Plazo,Monto,CodTipoInteres
	from tLpSolicitud where IdProceso = @IdProceso
END
GO