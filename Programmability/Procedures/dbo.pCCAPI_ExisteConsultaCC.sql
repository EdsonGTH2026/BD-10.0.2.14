SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[pCCAPI_ExisteConsultaCC] 
	(@CodUsuario VARCHAR(20), @CodCuenta VARCHAR(20), @CodOficina VARCHAR(3), @Id INT OUTPUT, @FechaConsulta DATETIME OUTPUT)
AS
BEGIN
	SELECT TOP 1 @Id = IdCC, @FechaConsulta = FechaRespuesta
	FROM tCcConsulta WITH (NOLOCK)
	WHERE CodUsuario = @CodUsuario
	AND Cuenta = @CodCuenta
	AND CodOficina = @CodOficina
	ORDER BY IdCC DESC
END
GO