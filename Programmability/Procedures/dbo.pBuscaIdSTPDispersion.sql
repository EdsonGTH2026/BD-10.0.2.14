SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE procedure [dbo].[pBuscaIdSTPDispersion](
@IdSTP int
)
as
begin
              
 SELECT IdSTP FROM tAhTransaccionDiariaRetiraSPEI WITH(NOLOCK)
         WHERE IdSTP =@IdSTP ;

end 

GO