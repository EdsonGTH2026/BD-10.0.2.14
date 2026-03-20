SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE procedure [dbo].[pAhNotificacionspei]
as
begin 

select T1.CuentaBeneficiario as CuentaClave, 
       convert(varchar,T1.Monto)as Monto,
	   T1.ConceptoPago as Concepto,
	   T1.ClaveRastreo,
	   convert (varchar,FechaHoraOpracion,20) as FechaOperacion,	
	   T1.IdTransaccion,
	   T1.IntentosNotifica,
	   A1.CodCuenta,
	   I1.idProducto AS Producto
	  -- SUBSTRING( A1.CodCuenta, 5, 3) AS Producto	 
from tAhTransaccionDiariaRecibeSPEI AS T1 with(nolock)
inNER JOIN tAhCuentaClabeInterbancaria AS A1
ON T1.CuentaBeneficiario= A1.ClabeInterbancaria
inner join finmas.dbo.tahcuenta as I1
ON A1.CodCuenta=I1.CodCuenta
where T1.Notificado=0
and I1.idProducto IN('114','113')
end 
GO