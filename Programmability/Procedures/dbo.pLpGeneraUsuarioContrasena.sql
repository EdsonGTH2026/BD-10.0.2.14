SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
create procedure [dbo].[pLpGeneraUsuarioContrasena] (@IdProceso int)
as
BEGIN
--Ver 29-01-2020
--Ver 11-02-2020
	set nocount on
	
	------------------------------ Usuario
	declare @Curp varchar(20)
	declare @User1 varchar(20)
	declare @User2 varchar(10)
	declare @User varchar(20)
	
	select @Curp = up.CURP 
	from 
	tLpSolicitudPromotor as up with(nolock) 
	inner join tLpProceso as p with(nolock) on p.IdSolicitudPromotor = up.IdSolicitudPromotor
	where p.idproceso = @IdProceso
		
	--BAMG660210MCCLNL04		
	if not exists(select * from tLpProcesoLlave where idproceso = @IdProceso)
		begin	
			--set @User1 = left(@Curp,6)    
			--SELECT @User2 = dbo.fLpCustomPass(6,'N')    
			--set @User = rtrim(@User1) + rtrim(@User2)			
			set @User = left(@Curp,10) 
		end
	else
		begin
			select @User = Usuario from tLpProcesoLlave with(nolock)  where idproceso = @IdProceso
		end
	
	------------------------------ Password	
	declare @Password varchar(20)
	SELECT @Password = dbo.fLpCustomPass(8,'N') 
	
	select isnull(@User,left(@Curp,12)) as 'Usuario', @Password as 'Contrasena'
END
GO