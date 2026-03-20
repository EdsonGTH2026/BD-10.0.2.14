SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[pConsultaCurp]
AS
	SELECT idConsulta, codUsuario, curp
	FROM FinamigoCURP.dbo.tConsultaCurp with(nolock)
	WHERE enviado = 0
GO