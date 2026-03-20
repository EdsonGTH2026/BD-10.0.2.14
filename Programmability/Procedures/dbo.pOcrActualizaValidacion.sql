SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
create procedure [dbo].[pOcrActualizaValidacion](@IdImagenValor int, @IdCampo int, @Evaluacion varchar(10), @ValorReferencia varchar(100))
as
BEGIN

	update tOcrDatosImagenValores set
	EsCorrecto = @Evaluacion
	where  
	--CodCuenta = @CodCuenta
	IdImagenValor = @IdImagenValor
	and IdCampo = @IdCampo
	
	--Almacena valor de referencia
	if not exists(select * from tOcrDatosImagenValoresReferencia where IdImagenValor=@IdImagenValor)
		begin
			insert into tOcrDatosImagenValoresReferencia(IdImagenValor, ValorReferencia) values (@IdImagenValor, @ValorReferencia)
		end
	else
		begin
			update tOcrDatosImagenValoresReferencia set
			ValorReferencia = @ValorReferencia
			where IdImagenValor=@IdImagenValor
		end
END 
GO