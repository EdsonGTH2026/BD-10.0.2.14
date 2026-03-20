SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
create procedure [dbo].[pCCUpdateRespuestaCorrecta] @intIdCC int
as
	set nocount on
	update tCcConsulta set 
	Procesado = 2,encolacc=2,encola=0 --lo manda a 2 para generar PDF
	where IdCC =@intIdCC --and CodUsuario = '" + strCodCliente + "' ";
GO