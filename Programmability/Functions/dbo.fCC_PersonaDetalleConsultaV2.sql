SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE FUNCTION [dbo].[fCC_PersonaDetalleConsultaV2] (@codusuario varchar(20), @Tipo varchar(1))
returns varchar(300)
AS 
begin
declare @cadena varchar(300)

select top 1 -- s.codusuario, s.fechasolicitud,
@cadena = 
--						Es el identificador de la consulta realizada por parte del Otorgante. Este folio se regresa de manera íntegra en el elemento de respuesta.
--	Folio de Consulta Otorgante		 		A	25	!	!						Contiene la clave del Producto solicitado
'<FolioConsultaOtorgante>' + rtrim(CodUsuario) + '</FolioConsultaOtorgante>'+		--VARIBALE
						
--	Producto Requerido					Consultar el id de producto con
--		N	2	!	!	el ejecutivo comercial de la cuenta.
--9   Reporte de Crédito Consolidado
--26  Reporte de Crédito Consolidado con FICO Score
--'<ProductoRequerido>26</ProductoRequerido>' +

(case 
 when @Tipo = 'R' then '<ProductoRequerido>' + (select rtrim(valor) from tCCParametros where tipo = 'NumProdReporte' and activo = 1) + '</ProductoRequerido>' 
 when @Tipo = 'M' then '<ProductoRequerido>' + (select rtrim(valor) from tCCParametros where tipo = 'NumProdRenueva' and activo = 1) + '</ProductoRequerido>' 
 when @Tipo = 'E' then '<ProductoRequerido>' + (select rtrim(valor) from tCCParametros where tipo = 'NumProdEspecial' and activo = 1) + '</ProductoRequerido>' 
 else '<ProductoRequerido>26</ProductoRequerido>'
 end) +

--	Tipo de Cuenta					Valores posibles para este campo: Tabla: Tipo de Cuenta
--		C	2	!	!				Este campo puede contener solo los siguientes valores:
'<TipoCuenta>E</TipoCuenta>' +

--		C	2			UD = Unidades de Inversión US = Dólares
--			!	!	Contiene un valor numérico entero positivo que indica el importe total del crédito solicitado, el valor será tomado conforme al tipo de moneda que tiene el campo Clave de Unidad Monetaria del Contrato.
'<ClaveUnidadMonetaria>MX</ClaveUnidadMonetaria>'+	
						
--	Importe del Contrato	N	9	!	!		Es el número de Firma asociado a la autorización del Consumidor para ser consultado. Este número nos permite conciliar la autorización de la consulta con el sistema.
'<ImporteContrato>' + convert(varchar,convert(int,MontoAprobado)) + '</ImporteContrato>'  +    --VARIBALE

						
--	Número de Firma		A	25	!	!		C 10				Es el identificador de la autenticación por parte del Otorgante. Este número se regresa de manera íntegra en el elemento de respuesta.
--						Nota:Requerido solo si el ProductoRequerido solicita Autenticación en cualquiera de sus					combinaciones.
'<NumeroFirma>' + rtrim(s.codusuario) + '</NumeroFirma>'

-- Número de Solicitud						
--'<NumeroSolicitud></NumeroSolicitud>'
--as 'DetalleConsulta'

from finmas.dbo.tcasolicitud as s with(nolock)
where
s.fechasolicitud >= '20190101'
and s.codusuario = @codusuario --'DOE840328F8169'
order by s.fechasolicitud desc

return @cadena
end
GO