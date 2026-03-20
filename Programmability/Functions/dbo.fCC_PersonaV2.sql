SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE FUNCTION [dbo].[fCC_PersonaV2](@codusuario varchar(20), @Tipo varchar(1))
returns varchar(1500)
AS 
begin
declare @cadena varchar(1500)

select 	@cadena = 	
'<Personas><Persona>' +		
--	Nombre	!	!	1	Contiene datos para la Consulta.
'<DetalleConsulta>' + ( dbo.fCC_PersonaDetalleConsultaV2(@codusuario, @Tipo) ) +
'</DetalleConsulta>' +

--	Nombre	!	!	1	Contiene todos los datos Personales del Consumidor
'<Nombre>' + dbo.fCC_PersonaNombre(@codusuario) +
'</Nombre>'+			
					
--	Domicilios	!	!	1	Contiene de 1 ó hasta 3 elementos Domicilio
'<Domicilios>' + dbo.fCC_PersonaDomicilio(@codusuario) +  
'</Domicilios>' +
			
--	Empleos	!	!	1	Puede contener hasta 3 elementos Empleo o ninguno
'<Empleos><Empleo></Empleo></Empleos>' +		

--		!	!	1	Cuentas de Referencia				Puede contener hasta 4 Elementos Número de Cuenta
--					Contiene los datos de créditos necesarios para realizar la Autenticación.
--'<CuentasReferencia><NumeroCuenta /><NumeroCuenta /><NumeroCuenta /></CuentasReferencia> ' +
(case 
      when @Tipo = 'R' then '<CuentasReferencia><NumeroCuenta /><NumeroCuenta /><NumeroCuenta /></CuentasReferencia> '
      when @Tipo = 'M' then '<CuentasReferencia>' + dbo.fCC_PersonaCuentas(@codusuario) +'</CuentasReferencia>' 
      when @Tipo = 'E' then '<CuentasReferencia><NumeroCuenta /><NumeroCuenta /><NumeroCuenta /></CuentasReferencia> '
 end) +


--					Nota:
--	Autenticación			1	Requerido solo si el ProductoRequerido solicita Autenticación en cualquiera de sus combinaciones. Ver Tabla: Producto solicitado
--'<Autenticacion> </Autenticacion>' +


'</Persona></Personas>'	
--as 'Persona'

return @cadena	
end
GO