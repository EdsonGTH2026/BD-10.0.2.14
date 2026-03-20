SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[pSDBuscarRutaDocsRiesgoCliente](@NroSolicitud VARCHAR(15), @CodOficina VARCHAR(4))
AS
BEGIN
	SELECT ee.RutaDestino FROM Finmas.dbo.tAhEvento e WITH (NOLOCK)
	INNER JOIN Finmas.dbo.tAhEventoEvidencia ee WITH (NOLOCK) ON e.idevento = ee.idevento
	WHERE CodCuenta = @NroSolicitud
	AND CodOficina = @CodOficina
	AND ee.idtipodocumento = 58
	AND ee.activa = 1
END
GO