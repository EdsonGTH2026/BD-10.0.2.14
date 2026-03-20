SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[PvalidadClientesExternosWS]
(@Usuario   VARCHAR(20), 
 @UserToken VARCHAR(200)
)
AS
    BEGIN
        SELECT usuario, 
               clave
        FROM Finmas.dbo.tClClientesExternos WITH(NOLOCK)
        WHERE usuario = @Usuario
              AND clave = @UserToken;
    END;

GO