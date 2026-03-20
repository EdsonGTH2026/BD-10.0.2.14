SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE procedure [dbo].[pLpClienteConsultar]( @IdProceso int)
as
BEGIN
	select IdCliente,IdProceso,APaterno,AMaterno,Nombres,FecNacimiento,CodDocIden,DI,CodEstadoCivil, Genero, FamiliarNegocio, Direccion,NumExterno, NumInterno, Ubicacion,CodPostal, localidad,EsPrincipal, TiempoDirDesde, TiempoCiudad, Telefono,Observaciones,EstadoNacimiento, CURP,RFC,Celular,LabActividad,Correo,FechaAlta,CodUsAlta,ClaveBancoSTP, CLABE 
	from tLpCliente where IdProceso = @IdProceso
END
GO