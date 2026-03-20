SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE procedure [dbo].[pLpDocumentoConsultar](@IdProceso int)
as
BEGIN
	select  
	IdDocumento, IdProceso, IdTipoDocumento, Descripcion, RutaOriginal,NombreOriginal 
	from tLpDocumento where idproceso = @IdProceso and Activa = 1
END
GO