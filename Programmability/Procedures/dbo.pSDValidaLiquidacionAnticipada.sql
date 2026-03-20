SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[pSDValidaLiquidacionAnticipada](@Codigo VARCHAR(25), @MontoDeposito MONEY, @CodSistema VARCHAR(3), 
														@CodOficina VARCHAR(4))--, @Ret INT OUTPUT)
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
	DECLARE @NombreCliente VARCHAR(120)

	BEGIN
		SELECT @Cuotas = a.Cuotas, @CodTipoPlazo = a.CodTipoPlaz, @DiasTrans = DATEDIFF(DAY, a.FechaDesembolso, GETDATE()), 
			   @MontoDesembolso = a.MontoDesembolso, @CodUsuario = a.CodUsuario, @NombreCliente = b.NombreCompleto
		FROM Finmas.dbo.tCaPrestamos a WITH (NOLOCK)
		LEFT JOIN Finmas.dbo.tUsUsuarios b WITH (NOLOCK) ON a.CodUsuario = b.CodUsuario
		WHERE a.CodPrestamo = @Codigo

		SELECT @GenerarAlerta = CASE WHEN @DiasTrans <= Dias THEN 1 ELSE 0 END
		FROM tClCaLiqAntRangosDias WITH (NOLOCK)
		WHERE CodTipoPlazo = @CodTipoPlazo
		AND Cuotas = @Cuotas

		IF @MontoDeposito > 50000
			BEGIN
				SET @GenerarAlerta = 1
			END
		else
			begin
				--CUM 20220628 se agrega ELSE, porque si no supera el monto no envia alerta.
				SET @GenerarAlerta = 0
			end

		IF @GenerarAlerta = 1
			BEGIN
				INSERT INTO tAlertasDepositosAnticipadosPLD (Codigo, Monto, CodUsuario, NombreCliente, RptaRegla, CodSistema, CodOficina, FechaSistema)
				VALUES (@Codigo, @MontoDeposito, @CodUsuario, @NombreCliente, 1, @CodSistema, @CodOficina, GETDATE())
				
				SET @Msg = 'Se detectó un depósito por ' + CAST(@MontoDeposito AS VARCHAR) + ', el cual cubre anticipadamente el total del crédito.'
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