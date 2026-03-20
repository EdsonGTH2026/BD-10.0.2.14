SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
create procedure [dbo].[pMSEnviaCorreo2](@Correos varchar(500), @Asunto varchar(200), @Mensaje varchar(8000))
as 
BEGIN
	--ver 19-10-2020
	declare @Fecha smalldatetime
	set @Fecha = getdate()

	exec FinamigoDocs.dbo.pEcRegistroCorreoEnvio @Fecha, @Correos,'','',@Asunto,@Mensaje,'nada',''

END
GO