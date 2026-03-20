SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

CREATE FUNCTION [dbo].[fCC_PersonaCuentas] (@codusuario varchar(20))
returns varchar(250)
AS 
begin
	--'<CuentasReferencia><NumeroCuenta /><NumeroCuenta /><NumeroCuenta /></CuentasReferencia> '
	declare @cadena varchar(250)
	set @cadena = ''

	select top 4
	@cadena = @cadena + '<NumeroCuenta>' + rtrim(codprestamo) +'</NumeroCuenta>'
	 from 
	(
		select codprestamo, fechadesembolso from finmas.dbo.tcaprestamos as c with(nolock)
		where codusuario = @codusuario
		union
		select codprestamo, fechadesembolso from finmas.dbo.tcahprestamos as ch with(nolock) 
		where codusuario = @codusuario
	) as x
	order by x.fechadesembolso desc

	select @cadena = ltrim(rtrim(@cadena))

	if len(@cadena) < 10
	begin
		set @cadena = '<NumeroCuenta /><NumeroCuenta /><NumeroCuenta />'
	end

	--select @cadena
	return @cadena
END 
GO