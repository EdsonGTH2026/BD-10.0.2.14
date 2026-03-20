SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[pSDUpdateAlertaClientePais](@Id INT, @IdRespuesta INT, @DictamenObservacion VARCHAR(500))
AS
BEGIN
	UPDATE tAlertasPais SET 
		RptaRegla = @IdRespuesta, DictamenObservacion = @DictamenObservacion, FechaRespuesta = GETDATE()
	WHERE Id = @Id
	
	SELECT @@ROWCOUNT AS Ret
END
GO