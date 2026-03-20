SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE function [dbo].[fduSecRptaConsCurp]()
	returns int
as
begin

return (select isnull(max(idconsulta),0) + 1
				from tRespuestaConsultaCurp)

end
GO