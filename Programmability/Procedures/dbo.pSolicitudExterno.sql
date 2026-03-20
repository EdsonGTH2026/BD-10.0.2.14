SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE procedure [dbo].[pSolicitudExterno] @nombres VARCHAR(50), @paterno VARCHAR(50), @materno VARCHAR(50), @genero CHAR(1), @Fecnac VARCHAR(10)
, @EntidadFederativa char(2),@usuario varchar(10)
AS
	set nocount on

	declare @IdSolicitud int
	declare @fecharegistro datetime
	set @fecharegistro=getdate()

	begin tran
    
	INSERT INTO tSolicitudCurpExterno (Nombres,Paterno,Materno,Genero,FNacimiento,EntidadFederativa,Usuario,Existe,FechaRegistro)
    VALUES (@nombres,@paterno,@materno,@genero,@Fecnac,@EntidadFederativa,@usuario,0,@fecharegistro);
	if(@@error<>0)
		begin
			rollback tran
			goto Err_Fin
		end

	select @IdSolicitud=IdSolicitud from tSolicitudCurpExterno 
	where nombres=@nombres and paterno=@paterno and materno=@materno and genero=@genero 
	and FNacimiento=@Fecnac and EntidadFederativa=@EntidadFederativa and usuario=@usuario
	and fecharegistro=@fecharegistro
	if(@@error<>0)
		begin
			rollback tran
			goto Err_Fin
		end

	commit tran
	GOTO Continua
	Err_Fin:
		set @IdSolicitud=-1

	Continua:

	select @IdSolicitud IdSolicitud
GO