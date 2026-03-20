SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
create procedure [dbo].[pLpProcesoCambioEstado](@IdProceso int, @IdEstadoNew int, @Comentario varchar(300), @CodUsAlta varchar(20), @IdProcesoDet int output)
as
BEGIN
	--ver. 21-01-2021
	--ver. 18-02-2021
	set nocount on
	
	update tLpProceso set
	IdEstado = @IdEstadoNew
	where IdProceso = @IdProceso
	
	insert into tLpProcesoDet (IdProceso,IdEstado,Comentario,FechaHora,CodUsAlta)
	values (@IdProceso,@IdEstadoNew,@Comentario,getdate(),@CodUsAlta);

	select @IdProcesoDet = max(IdProcesoDet) from tLpProcesoDet where idproceso = @IdProceso;
END
GO