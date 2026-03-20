SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[pAhAltaCtasTerceros]
(@CodCuenta                 VARCHAR(20), 
 @NombreBanco                 VARCHAR(6), 
 @DescripcionTipoCta        VARCHAR(3),
 @CuentaBeneficiarioTercero VARCHAR(20),
 @NombreBeneficiarioTercero VARCHAR(40),  
 @Consepto                  VARCHAR(20), 
 @Alias                     VARCHAR(20), 
 @Result                    INT OUTPUT
)
AS
    BEGIN
        DECLARE @ClaveBanco VARCHAR(6);
        DECLARE @ClaveTipoCta VARCHAR(2);
       
	   SELECT @ClaveTipoCta = ClaveTipoCta
			FROM CatalogoTipoCuenta
			WHERE descripcion = @DescripcionTipoCta;
       
	   SELECT @ClaveBanco = ClaveBanco
			FROM CatalogoBancos
			WHERE Participante = @NombreBanco;

        INSERT INTO tAhCuentasTercero
        (CodCuenta, 
         ClaveBanco, 
         NombreBeneficiarioTercero, 
         CuentaBeneficiarioTercero, 
         claveTipoCta, 
         Consepto, 
         Alias
        )
        VALUES
        (@CodCuenta, 
         @ClaveBanco, 
         @NombreBeneficiarioTercero,
         @CuentaBeneficiarioTercero , 
         @ClaveTipoCta, 
         @Consepto, 
         @Alias
        );
        SET @Result = 1;
        RETURN @Result;
    END;
GO