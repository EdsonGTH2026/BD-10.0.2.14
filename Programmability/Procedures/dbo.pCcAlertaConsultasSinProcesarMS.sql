SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
create procedure [dbo].[pCcAlertaConsultasSinProcesarMS]
as
BEGIN
	set nocount on
	
	select idcc, FechaRegistro, Procesado, FechaRespuesta, Respuesta, NumConsultas 
	into #tmpDatos
	from tccconsulta where Activo = 1 and tipo = 'E' and procesado <> 1 and len(respuesta) > 23
	
	--select isnull(convert(varchar,FechaRespuesta),''), *  from #tmpDatos
	select idcc as Id, 
	'IdCC[' +convert(varchar,idcc) + ']' + 
	'FechaRegistro[' + convert(varchar,FechaRegistro) + '], Procesado[' + convert(varchar,Procesado) + 
	'], Fec Respuesta[' + isnull(convert(varchar,FechaRespuesta),'') + '], Respuesta[' + isnull(Respuesta,'') +
	'], NumConsulta[' + isnull(convert(varchar,NumConsultas),'') + ']' as Descripcion
	from #tmpDatos	
	
END
GO