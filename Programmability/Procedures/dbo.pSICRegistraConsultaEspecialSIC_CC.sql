SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE procedure [dbo].[pSICRegistraConsultaEspecialSIC_CC](@CodUsuario varchar(20), @Cuenta varchar(20), @CodOficina varchar(3))
as
begin
	if not exists(select * from tCcConsulta where CodUsuario = @CodUsuario and  Cuenta = @Cuenta and CodOficina= @CodOficina)
	begin 
		insert into tCcConsulta (CodUsuario, FechaRegistro, Consulta, Procesado, FechaRespuesta, Respuesta, Comentario, RutaPDF, ArchivoPDF, Tipo, Cuenta, CodOficina, IdClasificacion, CopiadoPDF, UsuarioRegistro, NumConsultas, Activo)
		values (@CodUsuario, getdate(), '', 0, null, '', '', null, null, 'E', @Cuenta, @CodOficina, null, null, '', 0, 1)
	end
end
GO