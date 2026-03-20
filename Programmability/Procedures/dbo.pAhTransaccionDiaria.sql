SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[pAhTransaccionDiaria]      
AS      
BEGIN     
--Ver. 08-09-2020, OSC: modificado para consultar Centro de Costo para desembolsos de cartera
--Ver. 17-09-2020, OSC: se agrego empresa
--Ver. 17-09-2020, OSC: se agrego otra cuenta
 
        SELECT       
             T1.CodCuenta,   
             CAST(T1.Monto as numeric(10,2)) as Monto ,  
             T1.ClaveRastreo,                    
             T1.ConceptoPago,       
             T1.CuentaBeneficiario,       
             T1.CuentaOrdenante,                   
             T1.InstitucionContraparte,       
             T1.InstitucionOperante,         
             T1.NombreBeneficiario,       
             T1.ReferenciaNumerica,       
             T1.RfcCurpBeneficiario,       
             T1.TipoCuentaBeneficiario,       
             T1.TipoPago,    
             T1.IdTransaccion ,
			 T1.Estado,
			 A2.ClabeInterbancaria ,
			 R1.CodUsTitular,
			 U1.UsCURP ,
			 U1.CodUsuario,
			 TR.Nombres,
			 TR.Paterno,
			 TR.Materno,
			 T1.Empresa
    FROM tAhTransaccionDiariaSTP AS T1 WITH (NOLOCK)  	
    INNER JOIN tAhCuentaClabeInterbancaria AS A2  WITH (NOLOCK) ON T1.CodCuenta=A2.CodCuenta AND T1.empresa = A2.empresa
	INNER JOIN Finmas.dbo.tahcuenta AS R1 WITH (NOLOCK)	ON T1.CodCuenta=R1.CodCuentA 
	INNER JOIN Finmas.dbo.tUsUsuarioSecundarios AS U1 WITH (NOLOCK)	ON R1.CodUsTitular= U1.CodUsuario
	INNER JOIN Finmas.dbo.tUsUsuarioS AS TR WITH (NOLOCK) ON U1.CodUsuario= TR.CodUsuario
    WHERE T1.Enviado = 0
	AND T1.Estado=1  
	
	UNION
	
   SELECT       
     T1.CodCuenta,   
     CAST(T1.Monto as numeric(10,2)) as Monto ,  
     T1.ClaveRastreo,                    
     T1.ConceptoPago,       
     T1.CuentaBeneficiario,       
     T1.CuentaOrdenante,                   
     T1.InstitucionContraparte,       
     T1.InstitucionOperante,         
     T1.NombreBeneficiario,       
     T1.ReferenciaNumerica,       
     T1.RfcCurpBeneficiario,       
     T1.TipoCuentaBeneficiario,       
     T1.TipoPago,    
     T1.IdTransaccion ,
	 T1.Estado,
	 A2.ClabeInterbancaria ,
	 --R1.CodUsTitular,
	 '' as CodUsTitular,
	 --U1.UsCURP ,
	 '' as UsCURP,
	 --U1.CodUsuario,
	 '' as CodUsuario,
	 --TR.Nombres,
	 '' as Nombres,
	 --TR.Paterno,
	 '' as Paterno,
	 --TR.Materno
	 '' as Materno,
	 T1.Empresa
    FROM tAhTransaccionDiariaSTP AS T1 WITH (NOLOCK)  	
    INNER JOIN tAhCuentaClabeInterbancaria AS A2  WITH (NOLOCK) ON T1.CodCuenta=A2.CodCuenta AND T1.empresa = A2.empresa
	--INNER JOIN Finmas.dbo.tahcuenta AS R1 WITH (NOLOCK)	ON T1.CodCuenta=R1.CodCuentA 
	--INNER JOIN Finmas.dbo.tUsUsuarioSecundarios AS U1 WITH (NOLOCK)	ON R1.CodUsTitular= U1.CodUsuario
	--INNER JOIN Finmas.dbo.tUsUsuarioS AS TR WITH (NOLOCK) ON U1.CodUsuario= TR.CodUsuario   
	WHERE T1.Enviado = 0
	AND T1.Estado=1
	and ClabeInterbancaria in ('646180173310000008', '646180173320197778')  --CLABES de cuentas de centro de costos
	
		
END;
GO