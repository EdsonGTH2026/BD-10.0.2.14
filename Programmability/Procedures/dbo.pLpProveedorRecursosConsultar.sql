SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE procedure [dbo].[pLpProveedorRecursosConsultar]( @IdProceso int)
as
BEGIN
	select IdProveedorRecursos, IdProceso,AhorroInversion, PrestacionServicios, Prestamo, PremioSorteo, VentaBienes, 
	HerenciaDonacion, Asalariado, NombreEmpresa,PuestoOcupa,Antiguedad, Remesa, Otro,OtroDesc
	from tLpProveedorRecursos where IdProceso = @IdProceso
END
GO