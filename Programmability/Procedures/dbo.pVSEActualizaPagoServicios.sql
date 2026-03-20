SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
     
--BGMA:25-09-2020: SP PARA ENVIAR PAGO DE SERVICIOS


CREATE PROCEDURE [dbo].[pVSEActualizaPagoServicios] (    
	@idPago			int,
	@idServicio		int,
	@codCuenta		varchar,
	@referenciaPago	varchar,		
	@enviado		int,
	@mensaje		varchar(1000),
	@orderId		varchar(100)
	)        
AS        
BEGIN           
	UPDATE tVSEPagoServicios
	SET enviado = @enviado, referenciaPago = @referenciaPago, mensaje = @mensaje, orderId = @orderId, fechaOperacion = getDate()
	WHERE idServicio = @idServicio
	AND idPago = @idPago
END;
	
GO