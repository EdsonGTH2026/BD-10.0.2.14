SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE procedure [dbo].[pLpPPEGrabar](
    @IdProceso int,
	@CodPromotor varchar(20),
	
	@EsPersonaExpuesta varchar(2),
	@CargoPublico  varchar(60),
	@DependenciaCargo  varchar(60),
	@TieneParentesco  varchar(2),
	@ParienteApePat  varchar(20),
	@ParienteApeMat   varchar(20),              
	@ParienteNombres  varchar(30),
	@ParienteParentesco  varchar(20),
	@ParienteCargoPublico  varchar(60),
	@ParienteDependenciaCargo  varchar(60)
	) 
as
BEGIN
	--Ver. 26-01-2021
	set nocount on

	if not exists(select * from tLpPPE with(nolock) where IdProceso = @IdProceso)
		begin
			insert into tLpPPE(IdProceso,EsPersonaExpuesta, CargoPublico,DependenciaCargo,TieneParentesco, ParienteApePat,ParienteApeMat,ParienteNombres,ParienteParentesco,ParienteCargoPublico,ParienteDependenciaCargo, FechaAlta,CodUsAlta)
			values (@IdProceso,@EsPersonaExpuesta, @CargoPublico,@DependenciaCargo,@TieneParentesco, @ParienteApePat,@ParienteApeMat,@ParienteNombres,@ParienteParentesco,@ParienteCargoPublico,@ParienteDependenciaCargo,getdate(),@CodPromotor)
		end
	else
		begin
			update tLpPPE set
			EsPersonaExpuesta=@EsPersonaExpuesta, CargoPublico=@CargoPublico,DependenciaCargo=@DependenciaCargo,
			TieneParentesco=@TieneParentesco, ParienteApePat=@ParienteApePat,ParienteApeMat=@ParienteApeMat,
			ParienteNombres=@ParienteNombres, ParienteParentesco=@ParienteParentesco,ParienteCargoPublico=@ParienteCargoPublico,
			ParienteDependenciaCargo=@ParienteDependenciaCargo
			--FechaAlta,CodUsAlta,
			where  IdProceso = @IdProceso
		end

	select IdPPE from tLpPPE with(nolock) where IdProceso = @IdProceso
END
GO