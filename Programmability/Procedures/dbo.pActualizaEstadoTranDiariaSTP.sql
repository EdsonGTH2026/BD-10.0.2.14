SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO


create procedure [dbo].[pActualizaEstadoTranDiariaSTP] 
as
begin
declare @FechaInicio smalldatetime
declare @ClaveRastreo varchar(50)
select @FechaInicio=FechaOperacion,@ClaveRastreo=ClaveRastreo  from tAhTransaccionDiariaSTP 
where Estado=1

--print convert(varchar,@FechaInicio,112)

declare @Timepo  varchar(5)
set @Timepo= datediff ( minute,  @FechaInicio ,   getdate())
-- print @Timepo
 if (@Timepo>=3)
 begin

 update tAhTransaccionDiariaSTP set 
 Estado=3
 where ClaveRastreo=@ClaveRastreo

 end
 end
GO