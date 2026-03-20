SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE procedure [dbo].[pLpDocumentoGrabar](
    @IdProceso int,
	@CodPromotor varchar(20),
	@NombreArchivo varchar(50),
	@IdTipoDocumento int	
	) 
as
BEGIN
	--Ver. 26-01-2021
	set nocount on
	declare @Descripcion varchar(50)
	declare @RutaOriginal varchar(150)
	set @Descripcion = 'archivo por LP'
	--set @RutaOriginal = 'C:\inetpub\wwwroot\ProspectosQA\Docs'  --Test
	set @RutaOriginal = 'C:\inetpub\wwwroot\Prospectos\Docs'  --Produccion

	update tLpDocumento set
	Activa = 0
	where IdProceso = @IdProceso and IdTipoDocumento = @IdTipoDocumento;
	
	insert into tLpDocumento( IdProceso,IdTipoDocumento, Descripcion,RutaOriginal,NombreOriginal,RutaDestino,NombreNuevo,FechaCopiado,ArchivoWebCopiado, CodUsAlta,FechaAlta,Activa, PorCorregir, ComentarioCorreccion)
	values (@IdProceso,@IdTipoDocumento, @Descripcion,@RutaOriginal,@NombreArchivo,'','',null,null, @CodPromotor,getdate(),1, null, null)

	select IdDocumento from tLpDocumento with(nolock) where IdProceso = @IdProceso
END
GO