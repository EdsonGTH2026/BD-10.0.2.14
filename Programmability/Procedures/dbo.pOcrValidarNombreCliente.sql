SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
create procedure [dbo].[pOcrValidarNombreCliente](@CodigoCuente varchar(20),  @nombre varchar(40))
as
BEGIN
	set nocount on
	/*
	declare @nombre varchar(40)
	declare @CodigoCuente varchar(20)
	set @nombre = 'rodriguez bolaños daniel' ---'c%s%t%r%o' --
	set @CodigoCuente = '098-113-06-2-0-00988'
*/
	declare @codsuario varchar(20)
	declare @nombrecompleto varchar(50)
	declare @resultado varchar(2)

	select top 1 @codsuario = x.codustitular 
	from (
		select codustitular from finmas.dbo.tahsolicitud where nrosolicitud = @CodigoCuente
		union
		select codustitular from finmas.dbo.tahcuenta where codcuenta = @CodigoCuente
	) as x

	select @nombrecompleto = nombrecompleto from finmas.dbo.tususuarios where codusuario = @codsuario
	print '@nombrecompleto [' + @nombrecompleto + ']'

	if @nombrecompleto like '' + @nombre + ''
		begin
			set @resultado = 'SI' 
		end
	else
		begin
			set @resultado = 'NO'
		end
		
	select @nombrecompleto as Referencia, @nombre as Valor, @resultado as Resultado

END
GO