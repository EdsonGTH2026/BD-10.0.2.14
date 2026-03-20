SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[pAhInsertaHistoricoClabe](@idRegistro int,@altaStp int,  @idStp int, @descripcionSTP varchar(200) )
AS

BEGIN

DECLARE @item INT

	SELECT @item = COUNT(item) + 1
	FROM finamigostp.dbo.tAhHistoricoClabeSTP
	WHERE idRegistro = @idRegistro
	
	INSERT INTO finamigostp.dbo.tAhHistoricoClabeSTP VALUES (@IdRegistro, @item, @altaStp, @idStp,@descripcionSTP, getdate());

END
GO