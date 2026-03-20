SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE procedure [dbo].[pLpBeneficiarioGrabar](
    @IdProceso int,
	@CodPromotor varchar(20),
	@APaterno varchar(20),
	@AMaterno varchar(20),
	@Nombres varchar(20),
	@FecNacimiento smalldatetime,
	@Genero varchar(1),
	@BeneCodParentesco varchar(3)
	) 
as
BEGIN
	--Ver. 26-01-2021
	set nocount on

	if not exists(select * from tLpBeneficiario where IdProceso = @IdProceso)
		begin
			insert into tLpBeneficiario(IdProceso,APaterno,AMaterno,Nombres,FecNacimiento,Genero,BeneCodParentesco,FechaAlta,CodUsAlta)
			values (@IdProceso,@APaterno,@AMaterno,@Nombres,@FecNacimiento,@Genero,@BeneCodParentesco,getdate(),@CodPromotor)
		end
	else
		begin
			update tLpBeneficiario set
			APaterno=@APaterno,AMaterno=@AMaterno,Nombres=@Nombres,
			FecNacimiento=@FecNacimiento,
			Genero=@Genero,
			BeneCodParentesco = @BeneCodParentesco
			--FechaAlta,CodUsAlta,
			where  IdProceso = @IdProceso
		end

	select IdBeneficiario from tLpBeneficiario where IdProceso = @IdProceso
END
GO