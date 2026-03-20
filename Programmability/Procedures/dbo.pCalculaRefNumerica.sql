SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE procedure [dbo].[pCalculaRefNumerica](
@RefNume int output
)
as
begin
declare @ResNum int
set @ResNum=  FLOOR(RAND()*(9999999-1)+1) ;
SELECT @ResNum 
end
GO