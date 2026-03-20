SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[pSDObtenerDetalleRiesgoCliente](@Id INT)
AS
BEGIN
	CREATE TABLE #DetalleRiesgoCliente (Descripcion VARCHAR(100), Detalle VARCHAR(100), Resultado VARCHAR(100))
	
	INSERT INTO #DetalleRiesgoCliente (Descripcion, Detalle, Resultado) 
	SELECT 'Codigo Usuario', usuario.NombreCompleto, alertas.CodUsuario
	FROM tAlertasRiesgoCliente alertas WITH (NOLOCK)
	LEFT JOIN Finmas.dbo.tUsUsuarios usuario WITH (NOLOCK) ON alertas.CodUsuario = usuario.CodUsuario
	WHERE alertas.Id = @Id

	INSERT INTO #DetalleRiesgoCliente (Descripcion, Detalle, Resultado) 
	SELECT 'Nro. Solicitud', '', NroSolicitud FROM tAlertasRiesgoCliente WITH (NOLOCK)
	WHERE Id = @Id

	INSERT INTO #DetalleRiesgoCliente (Descripcion, Detalle, Resultado) 
	SELECT 'Fecha Dictamen', '', FechaRegistro FROM tAlertasRiesgoCliente WITH (NOLOCK)
	WHERE Id = @Id

	INSERT INTO #DetalleRiesgoCliente (Descripcion, Detalle, Resultado) 
	SELECT 'Fecha Respuesta', '', FechaRespuesta FROM tAlertasRiesgoCliente WITH (NOLOCK)
	WHERE Id = @Id
	
	INSERT INTO #DetalleRiesgoCliente (Descripcion, Detalle, Resultado) 
	SELECT 'Estado', '', CASE 
			WHEN RptaRegla = 1 THEN 'Por revisar'
			WHEN RptaRegla = 2 THEN 'Autorizada'
			WHEN RptaRegla = 3 THEN 'Rechazada'
		END AS RptaRegla
	FROM tAlertasRiesgoCliente WITH (NOLOCK)
	WHERE Id = @Id

	INSERT INTO #DetalleRiesgoCliente (Descripcion, Detalle, Resultado) 
	SELECT 'Puntaje Tipo Persona', alertas.PuntTipoPersona, alertas.TipoPersona + ' - ' + personas.DescTPersona
	FROM tAlertasRiesgoCliente AS alertas WITH (NOLOCK)
	LEFT JOIN Finmas.dbo.tUsClTipoPersona AS personas WITH (NOLOCK) ON alertas.TipoPersona = personas.CodTPersona
	WHERE alertas.Id = @Id

	INSERT INTO #DetalleRiesgoCliente (Descripcion, Detalle, Resultado) 
	SELECT 'Puntaje Zona Geografica', alertas.PuntZonaGeografica, zona.Estado + ' - ' + zona.Riesgo
	FROM tAlertasRiesgoCliente AS alertas WITH (NOLOCK)
	LEFT JOIN Finmas.dbo.tUsPLDZonaGeografica AS zona WITH (NOLOCK) ON alertas.ZonaGeografica = zona.Id
	WHERE alertas.Id = @Id

	INSERT INTO #DetalleRiesgoCliente (Descripcion, Detalle, Resultado) 
	SELECT 'Puntaje Pais', PuntPais, CodPais + ' - ' + Pais
	FROM tAlertasRiesgoCliente WITH (NOLOCK)
	WHERE Id = @Id

	INSERT INTO #DetalleRiesgoCliente (Descripcion, Detalle, Resultado) 
	SELECT 'Puntaje Edad', PuntEdad, Edad
	FROM tAlertasRiesgoCliente WITH (NOLOCK)
	WHERE Id = @Id

	INSERT INTO #DetalleRiesgoCliente (Descripcion, Detalle, Resultado) 
	SELECT 'Puntaje Instrumento Monetario', alertas.PuntInstrumentoMonetario,
		CASE WHEN ahorro.PT_InstrumentoMonetario = 0 THEN 'SIN INSTRUMENTO'
			 WHEN ahorro.PT_InstrumentoMonetario = 1 THEN 'EFECTIVO BANCO'
			 WHEN ahorro.PT_InstrumentoMonetario = 2 THEN 'EFECTIVO SUCURSAL'
			 ELSE 'Transferencia Bancaria' END
	FROM tAlertasRiesgoCliente AS alertas WITH (NOLOCK)
	LEFT JOIN Finmas.dbo.tUsAhorroDPF AS ahorro WITH (NOLOCK) ON alertas.CodUsuario = ahorro.CodUsuario AND alertas.InstrumentoMonetario = ahorro.PT_InstrumentoMonetario
	WHERE alertas.Id = @Id

	INSERT INTO #DetalleRiesgoCliente (Descripcion, Detalle, Resultado) 
	SELECT 'Puntaje Monto Inversion', PuntMontoInversion, CAST(SaldoCuenta AS VARCHAR(100))
	FROM tAlertasRiesgoCliente WITH (NOLOCK)
	WHERE Id = @Id

	INSERT INTO #DetalleRiesgoCliente (Descripcion, Detalle, Resultado) 
	SELECT 'Puntaje Actividad Economica', PuntActividadEconomica, RiesgoActividadEconomica
	FROM tAlertasRiesgoCliente WITH (NOLOCK)
	WHERE Id = @Id

	INSERT INTO #DetalleRiesgoCliente (Descripcion, Detalle, Resultado) 
	SELECT 'Puntaje Origen Recursos', PuntOrigenRecursos, RiesgoOrigenRecursos
	FROM tAlertasRiesgoCliente WITH (NOLOCK)
	WHERE Id = @Id

	INSERT INTO #DetalleRiesgoCliente (Descripcion, Detalle, Resultado) 
	SELECT 'Puntaje Tipo Producto', alertas.PuntTipoProducto, CAST(alertas.IdProducto AS VARCHAR(10)) + ' - ' + productos.Nombre
	FROM tAlertasRiesgoCliente alertas WITH (NOLOCK)
	LEFT JOIN Finmas.dbo.tAhProductos AS productos WITH (NOLOCK) ON alertas.IdProducto = productos.idProducto
	WHERE alertas.Id = @Id

	INSERT INTO #DetalleRiesgoCliente (Descripcion, Detalle, Resultado) 
	SELECT 'Puntaje PEP', PuntPPE, 
		CASE WHEN EsPPE = 1 THEN 'Persona póliticamente expuesta'
			 WHEN ParentescoPPE = 1 THEN 'Parentesco con persona póliticamente expuesta' 
		ELSE 'No es persona póliticamente expuesta'
		END
	FROM FinamigoPLD.dbo.tAlertasRiesgoCliente WITH (NOLOCK)
	WHERE Id = @Id

	INSERT INTO #DetalleRiesgoCliente (Descripcion, Detalle, Resultado) 
	SELECT 'Puntaje Total', PuntTotal, RiesgoTotal
	FROM tAlertasRiesgoCliente WITH (NOLOCK)
	WHERE Id = @Id

	SELECT * FROM #DetalleRiesgoCliente WITH (NOLOCK)
	DROP TABLE #DetalleRiesgoCliente
END
GO