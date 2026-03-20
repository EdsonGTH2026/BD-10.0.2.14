SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE procedure [dbo].[pSICRegistraConsultaSIC_CC](@CodUsuario varchar(20), @Cuenta varchar(20), @CodOficina varchar(3))
as
begin
	--Ver. 12-04-2021: Se cambio la condicion para que se vuelva a insertar la consulta solo si la consulta no tiene Procesado in 1 y 2, 
                    -- es decir que sea nueva o con error Procesado = 3 
	--Ver. 06-05-2021: Se cambio la condicion para que se vuelva a insertar la consulta solo si la consulta no tiene Procesado in 0, 1 y 2, 
                    -- es decir que sea nueva o con error Procesado = 3 
	set nocount on
	--if not exists(select * from tCcConsulta where CodUsuario = @CodUsuario and  Cuenta = @Cuenta and CodOficina= @CodOficina)
	if not exists(select * from tCcConsulta with(nolock) where CodUsuario = @CodUsuario and  Cuenta = @Cuenta and CodOficina= @CodOficina and Procesado in (0,1,2) and Activo = 1)
	begin 
		insert into tCcConsulta (CodUsuario, FechaRegistro, Consulta, Procesado, FechaRespuesta, Respuesta, Comentario, RutaPDF, ArchivoPDF, Tipo, Cuenta, CodOficina, IdClasificacion, CopiadoPDF, UsuarioRegistro, NumConsultas, Activo)
		values (@CodUsuario, getdate(), '', 0, null, '', '', null, null, 'R', @Cuenta, @CodOficina, null, null, '', 0, 1)
	end
end
GO