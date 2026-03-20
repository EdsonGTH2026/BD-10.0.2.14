SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE procedure [dbo].[pLpSolicitudGrabar](
    @IdProceso int,
	@CodPromotor varchar(20),
	@CodProducto varchar(3), 
	@Plazo int,
	@Monto money,
	@CodTipoInteres int
	) 
as
BEGIN
	--Ver. 26-01-2021
	set nocount on

	if not exists(select * from tLpSolicitud where IdProceso = @IdProceso)
		begin
			insert into tLpSolicitud(IdProceso,CodProducto, Plazo,Monto,CodTipoInteres, FechaAlta,CodUsAlta)
			values (@IdProceso,@CodProducto,@Plazo,@Monto,@CodTipoInteres,getdate(),@CodPromotor)
		end
	else
		begin
			update tLpSolicitud set
			CodProducto=@CodProducto, Plazo=@Plazo, Monto=@Monto, CodTipoInteres=@CodTipoInteres
			--FechaAlta,CodUsAlta,
			where  IdProceso = @IdProceso
		end

	select IdSolicitud from tLpSolicitud where IdProceso = @IdProceso
END
GO