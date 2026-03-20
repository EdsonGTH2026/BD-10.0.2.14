SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
create procedure [dbo].[pLpDocumentosConsulta](@IdProceso int)
as
BEGIN	
	--Ver. 20-01-2021
	set nocount on
	select  
	IdDocumento, IdProceso,
	IdTipoDocumento, 
	(case IdTipoDocumento
	when 12 then 'Identificación - IFE'
    when 53 then 'Identificación - IFE(REVERSO)'
    when 13 then 'Identificación - Comprobante Domicilio'
    when 11 then 'Solicitud DPF'
    else ''
	end) as TipoDocumento,
	Descripcion,
	RutaOriginal,NombreOriginal,
	RutaDestino,NombreNuevo ,
	 PorCorregir, ComentarioCorreccion
	from tLpDocumento
	where idproceso = @IdProceso
	and Activa = 1
END
GO