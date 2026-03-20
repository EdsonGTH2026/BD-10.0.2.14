SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

create procedure [dbo].[pOCRDocMinMaxY](@IdDoc int)
as
begin
	set nocount on
	declare @MY int
	declare @MinY int
	declare @MaxY int
	select @MY = max(y1) from tOCRDocTexto 
	where iddoc = 1 
	and (texto like '%in%t%o%' or texto like '%nac%al%' or texto like '%ele%al%' or texto like '%me%co%' or texto like '%cred%l%' or texto like '%para%' or texto like '%vo%tar%') --order by y1

	select @MinY = min(Y1), @MaxY = max(y1+y2) from tOCRDocTexto where iddoc = 4 and Y1 > @MY
	
	select @MinY as 'MinY', @MaxY as 'MaxY'
end
GO