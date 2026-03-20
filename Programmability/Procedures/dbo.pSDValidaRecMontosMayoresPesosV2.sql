SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[pSDValidaRecMontosMayoresPesosV2](@Codigo VARCHAR(25), @MontoDeposito MONEY, @CodSistema VARCHAR(3), 
														@CodOficina VARCHAR(4), @SecPago NUMERIC(18,0), @NombreCliente VARCHAR(200))--, @Ret INT OUTPUT)
AS
SET NOCOUNT ON;
BEGIN
	DECLARE @Id INT
	DECLARE @Count INT
	DECLARE @RptaRegla INT
	DECLARE @Subject VARCHAR(200)
	DECLARE @Msg VARCHAR(500)

	DECLARE @Cuotas INT
	DECLARE @CodTipoPlazo CHAR(1)
	DECLARE @DiasTrans INT
	DECLARE @MontoDesembolso MONEY
	DECLARE @GenerarAlerta BIT
	DECLARE @CodUsuario CHAR(15)

	BEGIN
		IF @MontoDeposito > 50000
			BEGIN
				SET @GenerarAlerta = 1
			END
		ELSE
			BEGIN
				SET @GenerarAlerta = 0
			END

		SELECT @GenerarAlerta

		IF @GenerarAlerta = 1
			BEGIN
				INSERT INTO tAlertasRecMontosMayoresPesosPLD (Codigo, Monto, CodUsuario, NombreCliente, RptaRegla, CodSistema, CodOficina, FechaSistema, SecuenciaPago)
				SELECT a.CodPrestamo, @MontoDeposito, a.CodUsuario, @NombreCliente, 1, @CodSistema, @CodOficina, GETDATE(), @SecPago
				FROM Finmas.dbo.tCaPrestamos a WITH (NOLOCK)
				WHERE a.CodPrestamo = @Codigo
				
				SET @Msg = 'Se detectó un depósito por ' + CAST(@MontoDeposito AS VARCHAR) + ', el cual excede el límite establecido ($50,000.00) .'
				SET @Subject = 'Operación inusual (' + @NombreCliente + ')'
				--SET @Ret = 0
			END

		IF LTRIM(RTRIM(@Msg)) <> ''
			BEGIN
				SET @Msg = @Subject + '|<html><body><p style=''font-family: Arial; font-size: small;''>' + @Msg + '</p></body></html>'
				EXEC [Finmas].[dbo].[pSgInsertaEnColaServicio] 'PL', 3, 'rmarroquinl@finamigo.com.mx', @Msg
				--EXEC [Finmas].[dbo].[pSgInsertaEnColaServicio] 'PL', 3, 'gduronf@finamigo.com.mx', @Msg
			END
		
		--RETURN @Ret
	END
END
GO