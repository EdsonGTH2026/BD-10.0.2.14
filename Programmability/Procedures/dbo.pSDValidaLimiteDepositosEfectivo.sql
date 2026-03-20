SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[pSDValidaLimiteDepositosEfectivo](@Codigo VARCHAR(25), @MontoDeposito MONEY, @CodSistema VARCHAR(3), 
		 												  @CodOficina VARCHAR(4), @Ret INT OUTPUT)
AS
SET NOCOUNT ON;
BEGIN
	DECLARE @Id INT
	DECLARE @Count INT
	DECLARE @RptaRegla INT
	DECLARE @Subject VARCHAR(200)
	DECLARE @Msg VARCHAR(500)

	DECLARE @FechaProceso DATETIME
	DECLARE @MontoMaximoDepEfeUSD MONEY
	DECLARE @TipoCambio MONEY
	DECLARE @MontoMaximoDepEfePesos MONEY

	DECLARE @FraccionCuenta VARCHAR(8)
	DECLARE @Renovado TINYINT
	DECLARE @SecuenciaPago NUMERIC(18,0)
	DECLARE @CodUsuario VARCHAR(15)
	DECLARE @NombreCliente VARCHAR(120)

	-- GDF: El código comentado es para una versión posterior dónde se 
	--		requiera que el SP devuelva otro valor distinto a 0 para que
	--		en Finmas no se pueda continuar con el proceso hasta que PLD
	--		autorice la transacción

	/*SELECT @RptaRegla = RptaRegla 
	FROM tAlertasDepositosExcedidosPLD WITH (NOLOCK)
	WHERE Codigo = @Codigo
	AND Monto = @MontoDeposito

	IF @RptaRegla IS NOT NULL
		BEGIN
			IF @RptaRegla = 2
				BEGIN
					SET @Ret = 0
				END
			ELSE
				BEGIN
					SET @Ret = -1
				END
		END
	ELSE*/
		BEGIN
			SELECT @FechaProceso = FechaProceso 
			FROM [Finmas].[dbo].tClParametros WITH (NOLOCK)
			WHERE CodOficina = @CodOficina

			SELECT TOP 1 @TipoCambio = TipoCambio 
			FROM [Finmas].[dbo].tTcTipoCambio WITH (NOLOCK)
			WHERE Periodo <= @FechaProceso
			--WHERE Periodo <= GETDATE() --QUITAR Y DEJAR LA FECHA DE PROCESO
			ORDER BY FechaAlta DESC

			SELECT @MontoMaximoDepEfeUSD = CAST(Valor AS MONEY) 
			FROM [Finmas].[dbo].tSgConfigGeneral WITH (NOLOCK)
			WHERE Tipo = 'MontoLimiteDepEfePLD'
			
			SET @MontoMaximoDepEfePesos = @MontoMaximoDepEfeUSD * @TipoCambio

			IF @MontoDeposito <= @MontoMaximoDepEfePesos
				BEGIN
					SET @Ret = 0
				END
			ELSE
				BEGIN
					SELECT @FraccionCuenta = a.FraccionCta, @Renovado = a.Renovado, @CodUsuario = a.CodUsTitular, @NombreCliente = b.NombreCompleto
					FROM [Finmas].[dbo].tAhCuenta a WITH (NOLOCK)
					LEFT JOIN Finmas.dbo.tUsUsuarios b WITH (NOLOCK) ON a.CodUsTitular = b.CodUsuario
					WHERE a.CodCuenta = @Codigo

					INSERT INTO tAlertasDepositosExcedidosPLD (Codigo, FraccionCuenta, Renovado, SecuenciaPago, 
																			   Monto, CodUsuario, RptaRegla, CodSistema, CodOficina, 
																			   FechaSistema)
					VALUES (@Codigo, @FraccionCuenta, @Renovado, @SecuenciaPago, @MontoDeposito, @CodUsuario, 1, @CodSistema, 
							@CodOficina, GETDATE())

					SET @Msg = 'Se detectó un depósito por ' + CAST(@MontoDeposito AS VARCHAR) + ', el cual supera el límite máximo de depósitos establecido por PLD (' + 
							   CAST(@MontoMaximoDepEfePesos AS VARCHAR) + ')'
					SET @Subject = 'Operación relevante (' + @NombreCliente + ')'
					SET @Ret = 0	-- GDF: Genera la alerta pero devuelve siempre 0 para que se pueda continuar en Finmas.
									--		Cambiar a otro valor para que en Finmas se muestre un mensaje que no permita continuar.
				END
		
			IF LTRIM(RTRIM(@Msg)) <> ''
				BEGIN
					SET @Msg = @Subject + '|<html><body><p style=''font-family: Arial; font-size: small;''>' + @Msg + '</p></body></html>'
					EXEC [Finmas].[dbo].[pSgInsertaEnColaServicio] 'PL', 3, 'rmarroquinl@finamigo.com.mx', @Msg
					--EXEC [Finmas].[dbo].[pSgInsertaEnColaServicio] 'PL', 3, 'gduronf@finamigo.com.mx', @Msg
				END

			RETURN @Ret
		END
END
GO