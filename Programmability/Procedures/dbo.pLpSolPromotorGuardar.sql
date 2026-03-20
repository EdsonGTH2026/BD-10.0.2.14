SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
create procedure [dbo].[pLpSolPromotorGuardar](@CodPromotor varchar(20), @NombreCliente varchar(50), @CURP varchar(18), @NumCelular varchar(10))
as
BEGIN
--ver 17-01-2021
--ver 17-02-2021, se quita fecha de nacimiento
	set nocount on

	insert into tLpSolicitudPromotor (NombreCompleto, CURP, NumCelular, CodPromotor, FechaRegistro, IdEstado, FechaProceso, Activo)
	values (@NombreCliente, @CURP, @NumCelular, @CodPromotor, getdate(), 0, null, 1)

	select top 1 IdSolicitudPromotor from tLpSolicitudPromotor 
	where IdEstado = 0 and NombreCompleto = @NombreCliente and CURP = @CURP and NumCelular = @NumCelular and CodPromotor = @CodPromotor
	order by IdSolicitudPromotor desc

END
GO