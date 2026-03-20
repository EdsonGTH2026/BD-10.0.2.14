SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE procedure [dbo].[pAhAltaCuentasSTPRespuesta](
	@ClabeInterbancaria varchar(20), @IdSTP varchar(5), @DescripcionIdSTP varchar(100), @AltaSTP varchar(5))
AS
BEGIN 
	UPDATE tAhCuentaClabeInterbancaria SET 
		IdSTP = @IdSTP,
		DescripcionIdSTP = @DescripcionIdSTP,
		FechaAltaSTP = GETDATE(),
		AltaSTP = @AltaSTP
	WHERE ClabeInterbancaria = @ClabeInterbancaria

	EXEC [Finmas].[dbo].[pTcValidaClabeCambiaEstadoEntrega] @ClabeInterbancaria
END
GO