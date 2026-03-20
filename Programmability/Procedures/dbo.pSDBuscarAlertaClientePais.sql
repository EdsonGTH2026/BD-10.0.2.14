SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[pSDBuscarAlertaClientePais] @Codusuario VARCHAR(15), @Rpta INT OUTPUT
as

if(isnull(@Codusuario,'')='')
begin
	set @rpta=-1
	return
end

--declare @rpta int
SELECT @rpta=RptaRegla
FROM tAlertasPais with(nolock) where codusuario=@Codusuario--'ACA000629FBNA1'
	--and rptaregla<>2

--> por defecto 1, es decir si no existe es porque no coincidio con pais en riesgo o fue aprobado
set @rpta = case isnull(@rpta,2) 
								when 1 then 0 --registrado
								when 2 then 1 --Aceptado
								when 3 then 3 --rechazado
								else 4 end --desconocido
GO