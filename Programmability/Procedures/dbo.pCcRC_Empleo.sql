SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE procedure [dbo].[pCcRC_Empleo] (@IdCC int)
as
--declare @IdCC int
--set @IdCC=215581
set nocount on
	select 
	c.IdCC, 
	e.NombreEmpresa, e.Direccion, e.ColoniaPoblacion, e.DelegacionMunicipio, e.Ciudad,                                                            
	e.Estado, e.CP, e.NumeroTelefono, e.Extension, e.Fax, e.Puesto, e.FechaContratacion, 
	e.ClaveMoneda, e.SalarioMensual, e.FechaUltimoDiaEmpleo, e.FechaVerificacionEmpleo
	from 
	tCcConsulta as c with(nolock)
	inner join tCcRespuestaEmpleo as e with(nolock) on e.IdCC = c.IdCC
	where c.IdCC = @IdCC
GO