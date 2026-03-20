SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[pCCAPI_CrearRespuestaScoreCC] (@IdCC INT, @NombreScore VARCHAR(20), @Valor VARCHAR(4), 
													   @Razon1 VARCHAR(3), @Razon2 VARCHAR(3), @Razon3 VARCHAR(3), @Razon4 VARCHAR(3))
AS
BEGIN
	INSERT INTO tCcRespuestaScore (IdCC, NombreScore, Valor, Razon1, Razon2, Razon3, Razon4, Error)
	VALUES (@IdCC, @NombreScore, @Valor, @Razon1, @Razon2, @Razon3, @Razon4, '0')
END
GO