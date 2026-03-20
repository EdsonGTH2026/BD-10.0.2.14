SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[pAhTransacionRecibeSPEIPruebas]
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
	if NOT EXISTS (select  IdTransaccion 
	                 from tAhTransaccionDiariaRecibeSPEI WITH(NOLOCK)
	                       where IdTransaccion=@IdTransaccion)
		begin
        -- ### BUSCA EL ESTADO DE CUENTA PARA SABER SI NO ESTA CANCELADA ###--   

		PRINT '@IdTransaccionTemp'+ CONVERT(VARCHAR,@IdTransaccionTemp)

        SELECT @Estado = idEstadoCta
        FROM Finmas.dbo.tahcuenta WITH(NOLOCK) --PRUDUCCION 
           WHERE codcuenta = @Codcuenta;
        --- ###### VERIFICA QUE LA CUENTA EXISTA ##########--- 
        IF @Codcuenta <> ''
            BEGIN
                -- ###### VALIDA QUE LA CUENTA ESTE ACTIVA ########--  
                IF @Estado <> 'CC'
                    BEGIN
                
								PRINT 'SE REALIZA LA TRANSACCION'
                                SET @Response = 200; ---- Statuscode 200  
                                SELECT @Response;
                      --  END;
                END;
                    ELSE
                    BEGIN

                        -- ####### LA CUENTA ESTA CANCELADA  (CC) ####### ---      

                        SET @Response = 2;
                        SELECT @Response;
             END;
        END;
            ELSE
            BEGIN
                -- #########  LA CUENTA NO EXISTE  ################## ---   
                SET @Response = 0;
                SELECT @Response;
        END;
		end;



		ELSE
		BEGIN
		PRINT 'LA OPERACION YA EXISTE'
		 SET @Response = 200; ---- Statuscode 200  
            SELECT @Response;
		END;
    END;
GO