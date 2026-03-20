SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[pCCAPI_CrearConsultaCC] (@CodCuenta VARCHAR(20), @CodOficina VARCHAR(3), @CodUsuario VARCHAR(20), @IdCC INT OUTPUT)
AS
BEGIN
	INSERT INTO tCcConsulta (CodUsuario, FechaRegistro, Consulta, Procesado, FechaRespuesta, Cuenta, CodOficina, Activo, EnCola, EnColaCC)
	VALUES (@CodUsuario, GETDATE(), '', 1, GETDATE(), @CodCuenta, @CodOficina, 1, 2, 2)

	SELECT @IdCC = SCOPE_IDENTITY()
END
GO