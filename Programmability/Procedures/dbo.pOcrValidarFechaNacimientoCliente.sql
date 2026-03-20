SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
create procedure [dbo].[pOcrValidarFechaNacimientoCliente](@CodigoCuenta varchar(20), @fecha varchar(30))
as
BEGIN
	set nocount on
	/*
	declare @fecha varchar(30)
	declare @CodigoCuenta varchar(20)
	set @fecha = ' NACIMIENTO 15-04-1989'
	set @CodigoCuenta = '098-113-06-2-0-00988'
*/
	declare @codsuario varchar(20)
	declare @FechaNacimiento smalldatetime
	declare @FechaNacimiento2 smalldatetime
	declare @fecha2 varchar(10)
	declare @resultado varchar(2)

	select top 1 @codsuario = x.codustitular 
	from (
		select codustitular from finmas.dbo.tahsolicitud where nrosolicitud = @CodigoCuenta
		union
		select codustitular from finmas.dbo.tahcuenta where codcuenta = @CodigoCuenta
	) as x

	select @FechaNacimiento = FechaNacimiento from finmas.dbo.tususuarios where codusuario = @codsuario
	print '@FechaNacimiento [' + convert(varchar,@FechaNacimiento,112) + ']'
	
	
	select @fecha2 = substring(@fecha,
            patindex('%[0-3][0-9]-[0-1][0-9]-[1-2][0-9][0-9][0-9]%', @fecha),
            10) --as 'Fecha Extraida'
    print '@fecha2 [' + @fecha2 + '] '
    
    SET DATEFORMAT dmy;         
    if isdate(@fecha2) = 0
    begin
		print 'no es fecha'
		select @fecha2 = substring(@fecha,
            patindex('%[0-3][0-9]/[0-1][0-9]/[1-2][0-9][0-9][0-9]%', @fecha),
            10) --as 'Fecha Extraida'
            
        print '@fecha2 [' + @fecha2 + '] '
            
        if isdate(@fecha2) = 0
		begin
			print 'no es fecha'
			set @fecha2 = '19000101'
		end
    end
    
    print '@fecha2 [' + @fecha2 + '] '
    set @FechaNacimiento2 = convert(smalldatetime,@fecha2)

	if convert(varchar,@FechaNacimiento,112) = convert(varchar,@FechaNacimiento2,112)
		begin
			set @resultado = 'SI'
		end
	else
		begin
			set @resultado = 'NO' 
		end

	select convert(varchar,@FechaNacimiento,111) as Referencia, convert(varchar,@FechaNacimiento2,111) as Valor, @resultado as Resultado
END
GO