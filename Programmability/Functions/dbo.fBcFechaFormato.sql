SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
create function [dbo].[fBcFechaFormato](@fecha varchar(8))
returns varchar(10)
as
begin
	declare @fechaConFormato varchar(10)
	if len(@fecha) = 8
	begin
		set @fechaConFormato = substring(@fecha,1,2) +'-'+ substring(@fecha,3,2) +'-' + substring(@fecha,5,4) 
	end
	else
	begin
		set @fechaConFormato = ''
	end
	return @fechaConFormato
end
GO