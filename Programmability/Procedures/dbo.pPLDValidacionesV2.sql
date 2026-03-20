SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[pPLDValidacionesV2](@Codigo VARCHAR(25), @MontoDeposito MONEY, @CodSistema VARCHAR(3), 
										    @CodOficina VARCHAR(4), @Opcion VARCHAR(50), @SecPago NUMERIC(18,0), 
											@NombreCliente VARCHAR(200), @Ret INT OUTPUT)
AS
SET NOCOUNT ON;
BEGIN
	/*GDF-20220622
		Se validan los depositos en efectivo de los formularios de Finmas:
			- fAhCjDeposito
			- fAhCjDepositoDPF
			- fCaCjRecuperacion
			- fCaCjLiquidacion
		
		Se validan las liquidaciones anticipadas del formulario de Finmas:
			- fCaCjRecuperacion (Este se envía siempre y cuando las variables "lvBolLiquida"
								 y "lvBolCancelaTodo" estén en "true", pues indica que el
								 pago fue una liquidación (pues se llamó inicialmente al
								 formulario fCaCjLiquidacion)).
	*/

	BEGIN
		EXEC pSDValidaLimiteDepositosEfectivoV2 @Codigo, @MontoDeposito, @CodSistema, @CodOficina, @SecPago, @NombreCliente, @Ret OUTPUT

		IF UPPER(@Opcion) = UPPER('fCaCjLiquidacion')
			BEGIN
				--insert into talertaliqanti_tmp (codprestamo,monto,formulario) values(@Codigo,@MontoDeposito,@Opcion)
				EXEC pSDValidaLiquidacionAnticipadaV2 @Codigo, @MontoDeposito, @CodSistema, @CodOficina, @SecPago, @NombreCliente

				--GDF-20220629 Begin (Se agrega validación de recuperaciones montos mayores pesos)
				EXEC pSDValidaRecMontosMayoresPesosV2 @Codigo, @MontoDeposito, @CodSistema, @CodOficina, @SecPago, @NombreCliente
				--GDF-20220629 End
			END

		--GDF-20220629 Begin (Se agrega validación de recuperaciones montos mayores pesos)
		IF UPPER(@Opcion) = UPPER('fCaCjRecuperacion')
			BEGIN
				EXEC pSDValidaRecMontosMayoresPesosV2 @Codigo, @MontoDeposito, @CodSistema, @CodOficina, @SecPago, @NombreCliente
			END
		--GDF-20220629 End

		RETURN @Ret
	END
END
GO