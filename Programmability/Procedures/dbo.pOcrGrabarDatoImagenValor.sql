SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
create procedure [dbo].[pOcrGrabarDatoImagenValor](@IdImagen int, @IdTipoDoc int, @IdCampo int, @Valor varchar(100))
as
BEGIN
	if not exists(select * from tOcrDatosImagenValores where  
	IdImagen = @IdImagen
	and IdTipoDoc = @IdTipoDoc
	and IdCampo = @IdCampo)
	begin
		insert into tOcrDatosImagenValores(IdImagen, IdTipoDoc, IdCampo, Valor ) values (@IdImagen, @IdTipoDoc, @IdCampo, @Valor )
	end
	else
	begin 
		update tOcrDatosImagenValores set
		Valor = @Valor
		where  
		IdImagen = @IdImagen
		and IdTipoDoc = @IdTipoDoc
		and IdCampo = @IdCampo
	end 
END 
GO