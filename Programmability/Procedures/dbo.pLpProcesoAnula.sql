SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
create procedure [dbo].[pLpProcesoAnula] @IdProceso int, @Comentario varchar(300), @CodUsAlta varchar(20), @IdProcesoDet int output
as
BEGIN
	--Ver. 24-01-2021
	--Ver. 18-02-2021
	set nocount on
	--declare @IdProcesoDet int
	exec pLpProcesoCambioEstado @IdProceso,6,@Comentario,@CodUsAlta, @IdProcesoDet output
	--select @IdProcesoDet
	
END
GO