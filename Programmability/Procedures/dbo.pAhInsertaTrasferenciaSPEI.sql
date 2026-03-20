SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

 --06-01-2020: RIA: SP QUE INSETAR LAS OPRECIONES QUE SE REALIZARAN POR SPEI  
CREATE PROCEDURE [dbo].[pAhInsertaTrasferenciaSPEI]  
(@CodCuenta              VARCHAR(20),   
 @InstitucionContraprte  VARCHAR(50),   
 @TipoCuentaBeneficiario VARCHAR(50),   
 @NombreBeneficiario     VARCHAR(40),   
 @CuentaBeneficiario     VARCHAR(20),   
 @ClaveRastreo           VARCHAR(30),   
 @RefNumerica            INT,   
 @Concepto               VARCHAR(40),   
 @Monto                  MONEY  
)  
AS  
    BEGIN  
        DECLARE @InstitucionContraparte VARCHAR(6);  
        DECLARE @TipoCntaBeneficiario VARCHAR(2);  
  
        SELECT @TipoCntaBeneficiario = ClaveTipoCta  
        FROM CatalogoTipoCuenta  
        WHERE descripcion = @TipoCuentaBeneficiario;  
         
     SELECT @InstitucionContraparte = ClaveBanco 
        FROM CatalogoBancos  
        WHERE Participante = @InstitucionContraprte;  
       select * from tAhTransaccionDiariaSTP  
  
        INSERT INTO tAhTransaccionDiariaSTP  
        (CodCuenta,   
         InstitucionContraparte,   
         TipoCuentaBeneficiario,   
         NombreBeneficiario,   
         CuentaBeneficiario,   
         ClaveRastreo,   
         ReferenciaNumerica,   
         ConceptoPago,   
         Monto  
        )  
        VALUES  
        (@CodCuenta,   
         @InstitucionContraparte,   
         @TipoCntaBeneficiario,   
         @CuentaBeneficiario,  
         @NombreBeneficiario,  
         @ClaveRastreo,   
         @RefNumerica,   
         @Concepto,   
         @Monto  
        );  
    END;
GO