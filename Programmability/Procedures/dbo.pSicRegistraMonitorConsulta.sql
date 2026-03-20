SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
create procedure [dbo].[pSicRegistraMonitorConsulta] ( @CodUsuario varchar(20), @Cuenta varchar(20), @CodOficina varchar(3), @IdClasificacion smallint, @UsuarioRegistro varchar(20) )
as
begin
/*
	if not exists(select * from tBcMonitorConsulta where CodUsuario = @CodUsuario and Cuenta = @Cuenta and convert(varchar(10),FechaRegistro,112) = convert(varchar(10),getdate(),112) )
	begin
		insert into tBcMonitorConsulta (CodUsuario, FechaRegistro, Procesado, Activo, Tipo, Cuenta, CodOficina, IdClasificacion, UsuarioRegistro, consulta)
		values (@CodUsuario, getdate(), 0, 1, 'R', @Cuenta, @CodOficina, @IdClasificacion, @UsuarioRegistro, '')
	end 
	*/
	exec pSICRegistraConsultaMonitor_CC @CodUsuario, @Cuenta, @CodOficina
end
GO

GRANT EXECUTE ON [dbo].[pSicRegistraMonitorConsulta] TO [public]
GO