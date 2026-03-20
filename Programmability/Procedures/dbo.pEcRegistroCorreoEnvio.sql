SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

create procedure [dbo].[pEcRegistroCorreoEnvio] (@FechaHoraProgramado smalldatetime, @Destinatarios varchar(500), @DestinatariosCC varchar(500),@DestinatariosCO varchar(500),@Asunto varchar(500),@Mensaje  varchar(8000),@UsuarioRegistro varchar(20), @NotaCorreo varchar(150) = '')
as
BEGIN
	set nocount on
	
	set @NotaCorreo = 'NOTA: Favor no responder este mensaje que ha sido emitido automáticamente por el sistema de Envio Correos de Financiera Mexicana'	
		
	insert into tEcCorreoEnvio(FechaHoraProgramado,Destinatarios, DestinatariosCC, DestinatariosCO,Asunto,Mensaje,UsuarioRegistro,FechaHoraRegistro,Estado,FechaProceso,Activo, NotaCorreo) 
	              values      (@FechaHoraProgramado,@Destinatarios, @DestinatariosCC, @DestinatariosCO,@Asunto,@Mensaje,@UsuarioRegistro,getdate(),0,null,1, @NotaCorreo)                                                                                                                                                                                                                                                                                                                                                 
	              
	select max(IdCorreoEnvio) as IdCorreoEnvio from tEcCorreoEnvio
END
GO