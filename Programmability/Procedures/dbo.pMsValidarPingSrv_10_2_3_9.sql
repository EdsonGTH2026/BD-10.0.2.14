SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
create procedure [dbo].[pMsValidarPingSrv_10_2_3_9] (@Resultado varchar(2000) output)
as
BEGIN
	set nocount on
	declare @IpServidor varchar(20); 
	set @IpServidor = '10.2.3.9'
	 
	declare @Porcentaje varchar(5);
	 declare @PorcenNum int;
	 --declare @Id int
	 --declare @Mensaje varchar(1000);	
	set @Resultado = 'ok'; 
	
	 create table #tmpOut(
	 Id int identity,
	 valor varchar(200) null
	 );
	
	 insert into #tmpOut 
	 EXEC master.dbo.xp_cmdshell 'ping 10.2.3.9' 
	
	select @Porcentaje = dbo.udf_GetNumeric(valor) from #tmpOut where len(rtrim(ltrim(valor))) >2 and valor like '%perdidos)%' 
	set @Porcentaje = isnull(@Porcentaje,'0') 
	
	set @PorcenNum = convert(int,@Porcentaje) 
	--select @PorcenNum
	
	if @PorcenNum = 100 
	begin 
		set @Resultado = 'El servidor [10.2.3.9] no ha respondido a un PING, favor de validar que este en linea el servidor.'
	end
	
	select @Resultado as 'Resultado'
	
	--select * from  #tmpOut; 
	drop table #tmpOut; 	

END
GO