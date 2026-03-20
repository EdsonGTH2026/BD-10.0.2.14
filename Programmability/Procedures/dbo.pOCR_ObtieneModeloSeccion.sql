SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
create procedure [dbo].[pOCR_ObtieneModeloSeccion] (@IdModelo int, @XMin int, @YMin int, @XMax int, @YMax int, @X1 int,@Y1 int, @X2 int, @Y2 int)
as
begin
set nocount on
/*
	declare @IdModelo int
	declare @XMin int, @YMin int, @XMax int, @YMax int, @X1 int,@Y1 int, @X2 int, @Y2 int
	set @IdModelo = 3
	set @XMin= 657 
	set @YMin=331 
	set @XMax=1900 
	set @YMax=1272
	
	set @X1=661
	set @Y1=546 
	set @X2=186 
	set @Y2=48
*/
	create table #ModeloSeccion(
	Id int identity,
	IdSeccion int, Seccion varchar(30), X1 money, Y1 money, X2 money, Y2 money
	)

	--declare @TotSecciones int, @NumSeccion int
	declare @IdSeccion int 
	declare @Seccion varchar(20) 
	declare @X1sec money, @Y1sec money, @X2sec money, @Y2sec money

	--lena tabla temporal
	insert into #ModeloSeccion
	select IdSeccion,Seccion, X1, Y1, X2, Y2  
	from tOCRModeloSeccion where idmodelo = @IdModelo 

	--Calcula procenajes coordenadas
	declare @X1porc money, @Y1porc money, @X2porc money, @Y2porc money
	--@XMax , @YMax , @X1 ,@Y1 , @X2 , @Y2 
	set @X1porc = (100.0/(@XMax-@XMin))*(@X1-@XMin)
	set @Y1porc = (100.0/(@YMax-@YMin))*(@Y1-@YMin)
	set @X2porc = (100.0/(@XMax-@XMin))*(@X2)
	set @Y2porc = (100.0/(@YMax-@YMin))*(@Y2)
	select @XMin as '@XMin', @YMin as '@YMin', @XMax as '@XMax', @YMax as '@YMax',@X1porc as '@X1porc',@Y1porc as '@Y1porc',@X2porc as '@X2porc',@Y2porc as '@Y2porc'
	
	select * from #ModeloSeccion where x1<=@X1porc and y1 <= @Y1porc and (x1+x2) >= (@X1porc+@X2porc) and (y1+y2) >= (@Y1porc+@Y2porc)

	drop table #ModeloSeccion
	
end
GO