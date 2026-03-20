SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
create procedure [dbo].[pLpLlaveReactiva] (
@IdProceso int, 
@Token varchar(500), 
@CodUsAlta varchar(20), @IdLlave int output )
as
BEGIN
	--ver. 29-01-2020
	set nocount on
	declare @Llave varchar(20)	
	declare @UrlCorta varchar(100)
	declare @Password varchar(20)
	
	set @Llave = ''
	select @Llave = Llave from tLpProcesoLlave where idproceso = @IdProceso
	
	select @UrlCorta = Descripcion from tLpClConfiguracion with(nolock) where Activo = 1 and Tipo= 'LpUrl'	
	set @UrlCorta = @UrlCorta + @Llave
	
	-------------------------------- Password	
	set @Password = ''
	SELECT @Password = dbo.fLpCustomPass(8,'N') 	
	
	if exists(select IdProceso from tLpProcesoLlave with(nolock) where IdProceso= @IdProceso )
	begin
		update tLpProcesoLlave set
		UrlCorta=@UrlCorta,
		Contrasena=@Password, 
		--Token = @Token,
		--CodUsAlta = @CodUsAlta, 
		Activo = 1
		where idproceso = @IdProceso and Llave= @Llave
	end	
	
	select IdLlave, IdProceso, Llave, UrlCorta, UrlLarga, Usuario, Contrasena 
	from tLpProcesoLlave with(nolock)  where idproceso = @IdProceso and Llave= @Llave and Activo = 1 
	
END
GO