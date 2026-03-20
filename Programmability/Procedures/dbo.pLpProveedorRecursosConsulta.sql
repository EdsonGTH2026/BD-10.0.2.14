SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
create procedure [dbo].[pLpProveedorRecursosConsulta](@IdProceso int)
as
BEGIN	
	--Ver. 20-01-2021
	set nocount on
	
	select  
	AhorroInversion, PrestacionServicios, Prestamo, PremioSorteo, VentaBienes, 
	HerenciaDonacion, Asalariado, NombreEmpresa,
	PuestoOcupa,Antiguedad, Remesa, Otro,  OtroDesc            
	from tLpProveedorRecursos
	where idproceso = @IdProceso

END
GO