SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE procedure [dbo].[pLpProveedorRecursosGrabar](
    @IdProceso int,
	@CodPromotor varchar(20),
	
	@AhorroInversion bit,
	@PrestacionServicios bit,
	@Prestamo bit,
	@PremioSorteo bit,
	@VentaBienes bit,
	@HerenciaDonacion bit,
	@Asalariado bit,
	@NombreEmpresa varchar(60),
	@PuestoOcupa varchar(30),
	@Antiguedad varchar(10),
	@Remesa bit,
	@Otro bit,
	@OtroDesc varchar(20)
	) 
as
BEGIN
	--Ver. 26-01-2021
	set nocount on

	if not exists(select * from tLpProveedorRecursos with(nolock) where IdProceso = @IdProceso)
		begin
			insert into tLpProveedorRecursos(IdProceso,AhorroInversion, PrestacionServicios, Prestamo, PremioSorteo, VentaBienes, HerenciaDonacion, Asalariado, NombreEmpresa,PuestoOcupa,Antiguedad, Remesa, Otro,OtroDesc, FechaAlta,CodUsAlta)
			values (@IdProceso,@AhorroInversion, @PrestacionServicios, @Prestamo, @PremioSorteo, @VentaBienes, @HerenciaDonacion, @Asalariado, @NombreEmpresa,@PuestoOcupa,@Antiguedad, @Remesa, @Otro,@OtroDesc,getdate(),@CodPromotor)
		end
	else
		begin
			update tLpProveedorRecursos set
			AhorroInversion=@AhorroInversion, PrestacionServicios=@PrestacionServicios, Prestamo=@Prestamo, 
			PremioSorteo=@PremioSorteo, VentaBienes=@VentaBienes, HerenciaDonacion=@HerenciaDonacion, 
			Asalariado=@Asalariado, NombreEmpresa=@NombreEmpresa,PuestoOcupa=@PuestoOcupa,
			Antiguedad=@Antiguedad, Remesa=@Remesa, Otro=@Otro,
			OtroDesc=@OtroDesc
			--FechaAlta,CodUsAlta,
			where  IdProceso = @IdProceso
		end

	select IdProveedorRecursos from tLpProveedorRecursos with(nolock) where IdProceso = @IdProceso
END
GO