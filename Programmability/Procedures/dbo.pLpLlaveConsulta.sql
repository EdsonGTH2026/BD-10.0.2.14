SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
create procedure [dbo].[pLpLlaveConsulta] (@Llave varchar(100) )
as
BEGIN
	--ver. 29-01-2020
	set nocount on
	select IdLlave, IdProceso, Token 
	from tLpProcesoLlave with(nolock) 
	where Llave = @Llave and Activo = 1
END
GO