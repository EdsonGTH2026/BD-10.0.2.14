SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[pAhTransacionRecibeSPEI]
(@IdTransaccion           INT, 
	@FechaOperacion          SMALLDATETIME, 
	@InstitucionOrdenante    VARCHAR(5), 
	@InstitucionBeneficiaria VARCHAR(5), 
	@ClaveRastreo            VARCHAR(30), 
	@Monto                   MONEY, 
	@NombreOrdenante         VARCHAR(120), 
	@tipoCuentaOrdenante     VARCHAR(2), 
	@CuentaOrdenante         VARCHAR(20), 
	@RfcCurpOrdenante        VARCHAR(18), 
	@NombreBeneficiario      VARCHAR(40), 
	@TipoCuentaBeneficiario  VARCHAR(2), 
	@CuentaBeneficiario      VARCHAR(20), 
	@RfcCurpBeneficiario     VARCHAR(18), 
	@ConceptoPago            VARCHAR(40), 
	@ReferenciaNumerica      INT, 
	@Empresa                 VARCHAR(15), 
	@Response                INT OUTPUT
)
AS
BEGIN
	DECLARE @Codcuenta VARCHAR(20);
	DECLARE @Estado VARCHAR(2);
	declare @IdTransaccionTemp int;
	--### BUSCA EL CODIGO DE CUENTA ### ---      
	
	SELECT @Codcuenta = CodCuenta
	FROM tAhCuentaClabeInterbancaria WITH(NOLOCK)
	WHERE clabeinterbancaria = @CuentaBeneficiario;
	
	---### VALIDA SI EL IDTRANSACCION NO EXISTE PARA EVITAR DUPLICAR LA OPRECION
	IF NOT EXISTS (SELECT  IdTransaccion FROM tAhTransaccionDiariaRecibeSPEI WITH(NOLOCK)
	WHERE IdTransaccion=@IdTransaccion)
	BEGIN
		-- ### BUSCA EL ESTADO DE CUENTA PARA SABER SI NO ESTA CANCELADA ###--   
		SELECT @Estado = idEstadoCta
		FROM Finmas.dbo.tahcuenta WITH(NOLOCK) --PRUDUCCION 
		WHERE codcuenta = @Codcuenta;
		--- ###### VERIFICA QUE NO SEA CUENTA FONDEO DESEMBOLSOS #########
		IF @Codcuenta <> 'FINAMIGO_CRED'
		BEGIN
		--- ###### VERIFICA QUE NO SEA CUENTA FONDEO ##########--- 
			IF @Codcuenta <> 'F'
			BEGIN
				--- ###### VERIFICA QUE LA CUENTA EXISTA ##########--- 
				IF @Codcuenta <> ''
				BEGIN
					-- ###### VALIDA QUE LA CUENTA ESTE ACTIVA ########--  
					IF @Estado <> 'CC'
					BEGIN					
						INSERT INTO tAhTransaccionDiariaRecibeSPEI
						(	IdTransaccion, 
							FechaOperacion, 
							InstitucionOrdenante, 
							InstitucionBeneficiaria, 
							ClaveRastreo, 
							Monto, 
							NombreOrdenante, 
							tipoCuentaOrdenante, 
							CuentaOrdenante, 
							RfcCurpOrdenante, 
							NombreBeneficiario, 
							TipoCuentaBeneficiario, 
							CuentaBeneficiario, 
							RfcCurpBeneficiario, 
							ConceptoPago, 
							ReferenciaNumerica, 
							Empresa, 
							FechaHoraOpracion
						)
						VALUES
						(	@IdTransaccion, 
							@FechaOperacion, 
							@InstitucionOrdenante, 
							@InstitucionBeneficiaria, 
							@ClaveRastreo, 
							@Monto, 
							@NombreOrdenante, 
							@tipoCuentaOrdenante, 
							@CuentaOrdenante, 
							@RfcCurpOrdenante, 
							@NombreBeneficiario, 
							@TipoCuentaBeneficiario, 
							@CuentaBeneficiario, 
							@RfcCurpBeneficiario, 
							@ConceptoPago, 
							@ReferenciaNumerica, 
							@Empresa, 
							GETDATE()
						);
						
						EXEC Finmas.dbo.pAhDepositoCuentaSPEI_vs2  --PRODUCCION  
						@Codcuenta, 
						@Monto, 
						'98CSM1803891',
						@ClaveRastreo,
						@IdTransaccion;
						---##### VALIDA SI EN REALIDAD SE CREO UN REGISTRO DE LA OPERACION ######-----    
						
						IF NOT EXISTS
						(
							SELECT *
							FROM tAhTransaccionDiariaRecibeSPEI
							WHERE CuentaBeneficiario = @CuentaBeneficiario
							AND idtransaccion = @IdTransaccion
							AND Monto = @Monto
						)
						BEGIN
							
							-----SI NO EXISTE REGISTRO DE LA OPERACION REGRESA 3 PARA INTENTAR NUEVEMENTE     
							
							SET @Response = -3;
							SELECT @Response;
						END;
						ELSE
						BEGIN
							---- SI EXISTE REGISTRO DE LA OPERACION REGRESA 1 COMO EXITO ###---- 
							
							SET @Response = 200; ---- Statuscode 200  
							SELECT @Response;
						END;
					END;
					ELSE
					BEGIN
						
						-- ####### LA CUENTA ESTA CANCELADA  (CC) ####### ---      
						--## GUARDAMOS EL HISTORIAL DE LA OPERACION SOLO COMO LOG DE LA OPERACION FALLIDA ### --
						EXEC pAhTranRecibeSPEIDevoCTACC @IdTransaccion,'Devolucion','Cuenta Cancelada',@FechaOperacion,@ClaveRastreo
						
						SET @Response = -2;
						SELECT @Response;
					END;
				END;
				ELSE
				BEGIN
					-- #########  LA CUENTA NO EXISTE  ################## ---   
					SET @Response = -1;
					SELECT @Response;
				END;
			END;
			ELSE
			BEGIN
				SET @Response = 200; 
				SELECT @Response;
			END;
		END;
		ELSE
		BEGIN
			SET @Response = 200; 
			SELECT @Response;
		END;
	END;
	ELSE
	BEGIN
		SET @Response = 1; 
		SELECT @Response;
	END;
END;
GO