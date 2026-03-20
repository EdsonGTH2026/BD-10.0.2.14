SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
create procedure [dbo].[pLpURL_Registra] (@IdProceso int, @UrlLarga varchar(250), @UrlCorta varchar(100), @Usuario varchar(30), @Clave varchar(30), @CodUsAlta varchar(20), @IdURL int output )
as
BEGIN
	--ver. 18-01-2020
	set nocount on
	if not exists(select * from tLpProcesoURL where IdProceso = @IdProceso)
		begin
			insert into tLpProcesoURL (IdProceso, UrlLarga, UrlCorta, Usuario, Clave, FechaAlta, CodUsAlta, Activo)
			values (@IdProceso, @UrlLarga, @UrlCorta, @Usuario, @Clave, getdate(), @CodUsAlta, 1)
		end
	else
		begin 
			update tLpProcesoURL set
			FechaModificacion = getdate(), CodUsModificacion = @CodUsAlta, Clave = @Clave, Activo = 1
			where IdProceso = @IdProceso 
		end
	
	select @IdURL = IdURL from tLpProcesoURL where IdProceso = @IdProceso 
	select @IdURL as IdURL, UrlLarga, UrlCorta, Usuario, Clave from tLpProcesoURL where IdProceso = @IdProceso 

END
GO