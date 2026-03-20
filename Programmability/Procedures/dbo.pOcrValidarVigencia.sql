SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
create procedure [dbo].[pOcrValidarVigencia](@CodigoCuenta varchar(20), @Vigencia varchar(10))
as
BEGIN
	set nocount on
	
	/*
	declare @Vigencia varchar(10)
	declare @CodigoCuenta varchar(20)
	set @Vigencia = 'dd 2013 xxx'
	set @CodigoCuenta = '098-113-06-2-0-00988'
*/
	
	declare @codsuario varchar(20)
	declare @FechaInicial smalldatetime
	declare @AñoVigencia varchar(4)
	declare @resultado varchar(2)

	select top 1 @FechaInicial = x.fecha 
	from (
		select fechasolicitud as fecha from finmas.dbo.tahsolicitud where nrosolicitud = @CodigoCuenta
		union
		select fechaapertura as fecha from finmas.dbo.tahcuenta where codcuenta = @CodigoCuenta
	) as x

	print '@FechaInicial [' + convert(varchar,@FechaInicial,112) + ']'
	
	select @AñoVigencia = substring(@Vigencia,
            patindex('%[1-2][0-9][0-9][0-9]%', @Vigencia),
            10) --as 'Fecha Extraida'
    print '@Vigencia [' + @Vigencia + '], @AñoVigencia ['+ @AñoVigencia+ '] '
    
    if left(convert(varchar,@FechaInicial,112),4) <= @AñoVigencia
		begin
			set @resultado = 'SI' 
		end
	else
		begin
			set @resultado =  'NO' 
		end
	
	select left(convert(varchar,@FechaInicial,112),4) as Referencia, @AñoVigencia as Valor, @resultado as Resultado
END
GO