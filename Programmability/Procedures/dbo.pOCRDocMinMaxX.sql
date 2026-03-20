SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
create procedure [dbo].[pOCRDocMinMaxX](@IdDoc int, @col int)
as
begin
	set nocount on
	--declare @col int
	declare @MinX int
	declare @MaxX int
	--select @MX = max(yX) from tOCRDocTexto 
	--where iddoc = @IdDoc 
	
	select @MinX = min(X1), @MaxX = max(X1+X2) from tOCRDocTexto where iddoc = @IdDoc 
	and (X1/100) > @col
	
	select @MinX as 'MinX', @MaxX as 'MaxX'
end
GO