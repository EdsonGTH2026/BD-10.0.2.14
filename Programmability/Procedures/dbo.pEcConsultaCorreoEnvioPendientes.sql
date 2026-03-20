SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
create procedure [dbo].[pEcConsultaCorreoEnvioPendientes] 
as
BEGIN
	set nocount on
	
	select IdCorreoEnvio, FechaHoraProgramado,Destinatarios, DestinatariosCC, DestinatariosCO,Asunto,Mensaje, isnull(ArchivosAdjuntos,'') as ArchivosAdjuntos, isnull(NotaCorreo,'') as NotaCorreo  
	from tEcCorreoEnvio 
	where Activo = 1 and isnull(Estado,0) = 0
	and FechaHoraProgramado <= getdate()
END
GO