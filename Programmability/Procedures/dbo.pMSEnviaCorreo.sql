SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
create procedure [dbo].[pMSEnviaCorreo](@Correos varchar(150), @Mensaje varchar(2000))
as 
BEGIN
	set nocount on
	
	declare @Fechamsj varchar(15)  
	declare @Horamsj varchar(15)  
	  
	Set @Fechamsj  = Finmas.dbo.FduFechaATexto(GetDate(), 'AAAA')+ Finmas.dbo.FduFechaATexto(GetDate(), 'MM') + Finmas.dbo.FduFechaATexto(GetDate(), 'DD')  
	Set @Horamsj = CONVERT(VARCHAR(20), GETDATE(), 114)  
	  
	exec [10.0.2.17].finamigoconsolidado.dbo.pSgInsertaEnColaServicio 'MS',3,@Correos,@Fechamsj,@Horamsj,@Mensaje  
END
GO