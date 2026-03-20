SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
create procedure [dbo].[pOcrObtenerCampoValorPorValidar](@Codcuenta varchar(20), @IdTipoDocumento int)
as
BEGIN
	set nocount on
	select i.IdImagen, i.codigocuenta, v.IdImagenValor, v.idcampo,d.campo, v.valor, d.validar, d.sp 
	from 
	finamigodocs.dbo.tOcrDatosImagen as i with(nolock)
	inner join finamigodocs.dbo.tOcrDatosImagenValores as v with(nolock) on v.idimagen = i.idimagen
	inner join finamigodocs.dbo.tOcrDefinicionCampos as d with(nolock) on d.idcampo = v.idcampo
	where 
	d.activo =  1 and d.validar = 1
	and i.CodigoCuenta = @Codcuenta -- '098-113-06-2-0-01016' 
	and d.idTipoDocumento = @IdTipoDocumento-- 12	
	order by i.IdImagen,v.IdImagenValor

END
GO