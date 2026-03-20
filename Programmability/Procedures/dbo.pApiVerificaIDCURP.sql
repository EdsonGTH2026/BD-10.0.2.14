SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE procedure [dbo].[pApiVerificaIDCURP] @id int
as
	set nocount on
	select case when existe=2 then 
					case when CURP is null or CURP='' or CURP='NA' then -1--'No encontrado'
						 else 1--'Encontrado' 
						 end
				when existe=1 then 1--'Encontrado'
			    else 0--'Pendiente' 
		   end respuesta
		   ,curp,descripcionrptaccb
	from tSolicitudCurpExterno with(nolock)
	where idsolicitud=@id--2
GO