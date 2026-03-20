SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

create procedure [dbo].[pBcMonitorRespCuentas] (@idmonitor int)
as
begin
	
	select 
	IdMonitor, IdCuenta,    
	dbo.fBcFechaFormato(isnull(FechaActualizacion,'')) as FechaActualizacion, isnull(RegistroImpugnado,'') as RegistroImpugnado, isnull(ClaveUsuario,'') as ClaveUsuario, 
	isnull(NombreUsuario,'') as NombreUsuario, isnull(TelefonoUsuario,'') as TelefonoUsuario, isnull(CreditoActual,'') as CreditoActual,             
	isnull(TipoResponsabilidad,'') as TipoResponsabilidad, 
	case isnull(TipoResponsabilidad,'') 
	when 'A' then 'Usuario Autorizado (Adicional)'
	when 'I' then 'Individual'
	when 'J' then 'Mancomunado'
	when 'C' then 'Obligado Solidario'
	else ''
	end as TipoResponsabilidadDesc,
	isnull(TipoCuenta,'') as TipoCuenta, 
	case isnull(TipoCuenta,'') 
	when 'I' then 'Pagos Fijos'
	when 'M' then 'Hipoteca'
	when 'O' then 'Sin Límite Pre-establecido'
	when 'R' then 'Revolvente'
	when 'X' then 'Reportado en Dun & Bradstreet (Personas Morales)'
	else ''
	end as TipoCuentaDesc,
	isnull(TipoContrato,'') as TipoContrato, 
	case isnull(TipoContrato,'')
	when 'AF' then 'Aparatos /Muebles'
	when 'AG' then 'Agropecuario (PFAE)'
	when 'AL' then 'Arrendamiento Automotriz'
	when 'AP' then 'Aviación'
	when 'AU' then 'Compra de Automóvil'
	when 'BD' then 'Fianza'
	when 'BT' then 'Bote / Lancha'
	when 'CC' then 'Tarjeta de Crédito'
	when 'CE' then 'Cartas de Crédito (PFAE)'
	when 'CF' then 'Crédito fiscal'
	when 'CL' then 'Línea de Crédito'
	when 'CO' then 'Consolidación'
	when 'CS' then 'Crédito Simple (PFAE)'
	when 'CT' then 'Con Colateral (PFAE)'
	when 'DE' then 'Descuentos (PFAE)'
	when 'EQ' then 'Equipo'
	when 'FI' then 'Fideicomiso (PFAE)'
	when 'FT' then 'Factoraje'
	when 'HA' then 'Habilitación o Avío (PFAE)'
	when 'HE' then 'Préstamo tipo “Home Equity”'
	when 'HI' then 'Mejoras a la casa'
	when 'LS' then 'Arrendamiento'
	when 'LR' then 'Línea de Crédito Reinstalable'
	when 'MI' then 'Otros'
	when 'OA' then 'Otros adeudos vencidos (PFAE)'
	when 'PA' then 'Préstamo para Personas Físicas con Actividad Empresarial (PFAE)'
	when 'PB' then 'Editorial'
	when 'PG' then 'PGUE - Préstamo como garantía de unidades industriales para PFAE'
	when 'PL' then 'Préstamo personal'
	when 'PN' then 'Préstamo de nómina'
	when 'PQ' then 'Quirografario (PFAE)'
	when 'PR' then 'Prendario (PFAE)'
	when 'PS' then 'Pago de Servicios'
	when 'RC' then 'Reestructurado (PFAE)'
	when 'RD' then 'Redescuento (PFAE)'
	when 'RE' then 'Bienes Raíces'
	when 'RF' then 'Refaccionario (PFAE)'
	when 'RN' then 'Renovado (PFAE)'
	when 'RV' then 'Vehículo Recreativo'
	when 'SC' then 'Tarjeta garantizada'
	when 'SE' then 'Préstamo garantizado'
	when 'SG' then 'Seguros'
	when 'SM' then 'Segunda hipoteca'
	when 'ST' then 'Préstamo para estudiante'
	when 'TE' then 'Tarjeta de Crédito Empresarial'
	when 'UK' then 'Desconocido'
	when 'US' then 'Préstamo no garantizado'
	else ''
	end as TipoContratoDesc,
	isnull(MonedaCredito,'') as MonedaCredito, isnull(ImporteAvaluo,'') as ImporteAvaluo, isnull(NumeroPagos,'') as NumeroPagos, 
	isnull(FrecuenciaPagos,'') as FrecuenciaPagos, 
	
	case isnull(FrecuenciaPagos,'')
	when 'B' then 'Bimestral (Cada 2 meses)'
	when 'D' then 'Diario'
	when 'H' then 'Semestral'
	when 'K' then 'Catorcenal'
	when 'M' then 'Mensual'
	when 'P' then 'Deducción del salario (cada que reciba su sueldo O Salario)'
	when 'Q' then 'Trimestral (Cada 3 meses)'
	when 'S' then 'Quincenal (2 veces al mes)'
	when 'V' then 'Variable'
	when 'W' then 'Semanal'
	when 'Z' then 'Pago mínimo'
	else ''
	end as FrecuenciaPagosDesc,
	
	isnull(MontoPagar,'') as MontoPagar, dbo.fBcFechaFormato(isnull(FechaApertura,'')) as FechaApertura, 
	dbo.fBcFechaFormato(isnull(FechaUltimoPago,'')) as FechaUltimoPago, dbo.fBcFechaFormato(isnull(FechaUltimaCompra,'')) as FechaUltimaCompra, dbo.fBcFechaFormato(isnull(FechaCierre,'')) as FechaCierre, 
	dbo.fBcFechaFormato(isnull(FechaReporteInfo,'')) as FechaReporteInfo, isnull(ModoReportar,'') as ModoReportar, isnull(UltFecSaldoCero,'') as UltFecSaldoCero, 
	isnull(Garantia,'') as Garantia, isnull(CredMaxAutorizado,'') as CredMaxAutorizado, isnull(SaldoActual,'') as SaldoActual, 
	isnull(LimiteCredito,'') as LimiteCredito, isnull(SaldoVencido,'') as SaldoVencido, isnull(NumPagosVencidos,'') as NumPagosVencidos, 
	isnull(MOP,'') as MOP, 
	
	case isnull(MOP,'')
	when 'UR' then 'Cuenta sin información. La Cuenta o Crédito no tuvo actividad. No tuvo movimientos de compra o pago. Los saldos son igual a cero. Principalmente para cuentas revolventes que no tienen saldos pendientes y no tuvieron actividad de compra o pago en el período.'
	when '00' then 'Muy reciente para ser calificada. La Cuenta o Crédito es de recién apertura y aún no tiene actividad o movimientos en máxim meses. Si tiene más de 3 meses sin actividad desde su apertura, usar el MOP=UR.'
	when '01' then ' Cuenta al corriente, 0 días de atraso de su fecha límite de pago (1 a 29 días transcurridos de su fecha de facturación)'
	when '02' then ' Cuenta con atraso de 1 a 29 días de su fecha fecha de corte o facturación).'
	when '03' then ' Cuenta con atraso de 30 a 59 días de su fecha límite de pago (60 a 89 días transcurridos de su fecha de corte o facturación).'
	when '04' then ' Cuenta con atraso de 60 a 89 días de su fecha de corte o facturación).'
	when '05' then ' Cuenta con atraso de 90 a 119 días de su fecha límite de pago (120 a 149 días transcurridos desu fecha de corte o facturación).'
	when '06' then ' Cuenta con atraso de 120 a 149 transcurridos de su fecha de corte o facturación).'
	when '07' then ' Cuenta con atraso de 150 días hasta 12 meses de su fecha límite de pago (181 días a 12 meses transcurridos de su fecha de corte o facturación).'
	when '96' then ' Cuenta con atraso de más de 12 meses de su fecha de pago y corte o facturación.'
	when '97' then ' Cuenta con deuda parcial o total sin recuperar.'
	when '99' then ' Fraude cometido por el Cliente'
	end as MOPDesc,
		
	isnull(HistoricoPagos,'') as HistoricoPagos, dbo.fBcFechaFormato(isnull(FecRecienteHistPag,'')) as FecRecienteHistPag, 
	dbo.fBcFechaFormato(isnull(FecAntiguaHistPag,'')) as FecAntiguaHistPag, isnull(ClaveObservacion,'') as ClaveObservacion, isnull(TotaPagosReportados,'') as TotaPagosReportados, 
	isnull(TotalPagosMOP02,'') as TotalPagosMOP02, isnull(TotalPagosMOP03,'') as TotalPagosMOP03, isnull(TotalPagosMOP04,'') as TotalPagosMOP04, 
	isnull(TotalPagosMOP05Mas,'') as TotalPagosMOP05Mas, isnull(SaldoMorosidadHistAlta,'') as SaldoMorosidadHistAlta, dbo.fBcFechaFormato(isnull(FecMorosidadHistAlta,'')) as FecMorosidadHistAlta, 
	isnull(MOPMorosidadAlta,'') as MOPMorosidadAlta, dbo.fBcFechaFormato(isnull(FecIniReestructura,'')) as FecIniReestructura, isnull(MontoUltPago,'') as  MontoUltPago
	from tBcMonitorRespCuentas with(nolock)
	where idmonitor = @idmonitor

end
GO