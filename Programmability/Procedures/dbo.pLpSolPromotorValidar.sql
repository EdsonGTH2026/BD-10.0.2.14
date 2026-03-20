SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
create procedure [dbo].[pLpSolPromotorValidar](@CodPromotor varchar(20), @NombreCliente varchar(50), @CURP varchar(18), @NumCelular varchar(10))
as
BEGIN
--ver 17-01-2021
--ver 17-02-2021, se quito fecha de nacimiento
	set nocount on
	declare @NumRegistros int
	declare @Resultado varchar(100)
	set @Resultado = ''
	
	select @NumRegistros = count(*) from tLpSolicitudPromotor where curp = @CURP and IdEstado = 0
	set @NumRegistros = isnull(@NumRegistros,0)
	
	if @NumRegistros > 0
	begin
		set @Resultado = 'El CURP ya ha sido registrado y tiene un proceso vigente'
		select @Resultado as Resultado
		return
	end
	else
	begin
		set @Resultado = 'OK'
		select @Resultado as Resultado
		return
	end
	
	select @Resultado as Resultado
END
GO