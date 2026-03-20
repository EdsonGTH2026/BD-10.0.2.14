SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
create procedure [dbo].[pMSProcesaTareaSP](@IdTareaSP int, @SP varchar(100), @Correos varchar(400), @Asunto varchar(200))
as 
BEGIN
	set nocount on

	declare @sql varchar(500)
	declare @Resultado varchar(2000)
	set @Resultado = ''
	
	set @sql = 'declare @Resultado varchar(8000); '
	set @sql = @sql + ' exec ' + @SP + ' @Resultado output '
	set @sql = @sql + ' select @Resultado as ''@Resultado''; '
	
	set @sql = @sql + ' insert into tMSTareasResultados (IdTareaSP,FechaHora,Resultado) values (' + convert(varchar,@IdTareaSP) +  ', getdate(),@Resultado); '

	execute(@sql)
	
	select * from tMSTareasResultados

	/*
	print '@MensajeAlerta['+ @MensajeAlerta + ']'
	
	if len(rtrim(@MensajeAlerta)) > 10
		begin
		--Envia correo	
		--exec pMSEnviaCorreo 'csanchezc@finamigo.com.mx','prueba de correo'
		exec pMSEnviaCorreo2 @Correos,@Asunto,@MensajeAlerta
	end
*/	

END
GO