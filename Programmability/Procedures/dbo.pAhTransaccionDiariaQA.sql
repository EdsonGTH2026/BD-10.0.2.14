SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[pAhTransaccionDiariaQA]     
AS      
    BEGIN      
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
			 A2.ClabeInterbancaria ,
			 R1.CodUsTitular,
			 U1.UsCURP ,
			 U1.CodUsuario,
			 TR.Nombres,
			 TR.Paterno,
			 TR.Materno
    FROM tAhTransaccionDiariaSTP AS T1 WITH (NOLOCK)  
	INNER JOIN tAhCuentaClabeInterbancaria AS A2  WITH (NOLOCK) 
	ON T1.CodCuenta=A2.CodCuenta
	INNER JOIN Finmas.dbo.tahcuenta AS R1 WITH (NOLOCK)
	ON T1.CodCuenta=R1.CodCuentA 
	INNER JOIN Finmas.dbo.tUsUsuarioSecundarios AS U1 WITH (NOLOCK)
	ON R1.CodUsTitular= U1.CodUsuario
	INNER JOIN Finmas.dbo.tUsUsuarioS AS TR WITH (NOLOCK)
	ON U1.CodUsuario= TR.CodUsuario
       -- WHERE T1.Enviado = 2;  
		   WHERE T1.ClaveRastreo ='RSTO20200811120803'
    END;
GO