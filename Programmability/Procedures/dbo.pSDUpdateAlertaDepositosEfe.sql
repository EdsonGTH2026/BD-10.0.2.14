SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[pSDUpdateAlertaDepositosEfe](@Id INT, @IdRespuesta INT, @DictamenObservacion VARCHAR(500))
AS
BEGIN
	UPDATE tAlertasDepositosExcedidosPLD SET 
		RptaRegla = @IdRespuesta, DictamenObservacion = @DictamenObservacion, FechaRespuesta = GETDATE()
	WHERE Id = @Id
	
	SELECT @@ROWCOUNT AS Ret
END
GO