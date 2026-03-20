SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE procedure [dbo].[pLpDocumentoValidaNombre](@NombreArchivo varchar (50))
as
BEGIN
--Ver. 11-02-2021
set nocount on
	declare @Resultado varchar(100)
	declare @Extension varchar(3)
	
	if len(@NombreArchivo) > 50
	begin
		set @Resultado = 'El nombre del archivo no puede ser mayor a 30 caracteres.'
		select @Resultado as 'Resultado'
		return 0
	end
	--------------------
	select @Extension = left(reverse(@NombreArchivo),3) 
	set @Extension = reverse(@Extension)
	
	if upper(@Extension) not in ('JPG','PDF','PNG','JPEG')
	begin
		set @Resultado = 'El archivo a subir debe tener extensión de JPG, JPEG, PNG o PDF.'
		select @Resultado as 'Resultado'
		return 0
	end
	
	if exists(select * from tLpDocumento where nombreoriginal = @NombreArchivo)
	begin
		set @Resultado = 'El nombre del archivo ya se encuentra registrado.'
		select @Resultado as 'Resultado'
		return 0
	end

	set @Resultado = 'OK'
	select @Resultado as 'Resultado'
END
GO