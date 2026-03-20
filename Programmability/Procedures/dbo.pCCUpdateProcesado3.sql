SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
create procedure [dbo].[pCCUpdateProcesado3] @intIdCC int
as
	set nocount on
	update tCcConsulta set 
	Procesado = 3,encolacc=0,encola=0   --// de 2 a 3 para que no genere PDF
	where IdCC = @intIdCC -- + and CodUsuario = '" + strCodCliente + "' 
GO