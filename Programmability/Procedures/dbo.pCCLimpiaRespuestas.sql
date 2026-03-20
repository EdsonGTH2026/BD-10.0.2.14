SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
create procedure [dbo].[pCCLimpiaRespuestas] @idcc int
as 
				delete from tCcRespuestaAutentificacion where IdCC = @idcc
				delete from tCcRespuestaConsultaEfectuada where IdCC = @idcc
				delete from tCcRespuestaCuenta where IdCC = @idcc
				delete from tCcRespuestaDeclaracionesConsumidor where IdCC = @idcc
				delete from tCcRespuestaDomicilio where IdCC = @idcc
				delete from tCcRespuestaEmpleo where IdCC = @idcc
				delete from tCcRespuestaEncabezado where IdCC = @idcc
				delete from tCcRespuestaError where IdCC = @idcc
				delete from tCcRespuestaErrores where IdCC = @idcc
				delete from tCcRespuestaEstadisticaFinanciera where IdCC = @idcc
				delete from tCcRespuestaIndicador where IdCC = @idcc
				delete from tCcRespuestaMensaje where IdCC = @idcc
				delete from tCcRespuestaNombre where IdCC = @idcc
				delete from tCcRespuestaScore where IdCC = @idcc
GO