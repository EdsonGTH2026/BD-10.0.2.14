SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[pSDBuscarPersonaBloqueadaPLD](@Nombre VARCHAR(100), @ApellidoPaterno VARCHAR(50), @ApellidoMaterno VARCHAR(50), 
													 @CodSistema VARCHAR(3), @CodSolicitud VARCHAR(15), @CodOficina VARCHAR(4),
													 @Ret INT OUTPUT)
AS
BEGIN
	DECLARE @Id INT
	DECLARE @Count INT
	DECLARE @RptaRegla INT
	DECLARE @Subject VARCHAR(200)
	DECLARE @Msg VARCHAR(500)

	IF @Nombre IS NULL OR @Nombre='' --OR @ApellidoPaterno IS NULL OR @ApellidoPaterno='' OR @ApellidoMaterno IS NULL OR @ApellidoMaterno=''
		BEGIN
			SET @Ret = -3	-- LOS PARAMETROS RECIBIDOS ESTÁN VACÍOS
		END
	ELSE
		BEGIN
			SELECT @Count = COUNT(*) FROM tListaPersonasBloqueadas WITH (NOLOCK)
			WHERE UPPER(Nombre) LIKE '%' + UPPER(@Nombre) + '%'
			AND UPPER(ApellidoPaterno) LIKE '%' + @ApellidoPaterno + '%'
			AND UPPER(ApellidoMaterno) LIKE '%' + @ApellidoMaterno + '%'
			AND Activo = 1 AND IdArchivo > 0

			IF @Count = 1
				BEGIN
					SELECT @Id = ISNULL(a.Id, 0), @RptaRegla = b.RptaRegla FROM tListaPersonasBloqueadas a WITH (NOLOCK)
					LEFT JOIN tAlertasPersonasBloqueadas b WITH (NOLOCK) ON a.Id = b.IdPersonaBloqueada AND b.CodSistema = @CodSistema 
														 AND b.CodSolicitud = @CodSolicitud AND b.CodOFicina = @CodOficina
					WHERE UPPER(a.Nombre) LIKE '%' + UPPER(@Nombre) + '%'
					AND UPPER(a.ApellidoPaterno) LIKE '%' + @ApellidoPaterno + '%'
					AND UPPER(a.ApellidoMaterno) LIKE '%' + @ApellidoMaterno + '%'
					AND Activo = 1 AND IdArchivo > 0

					IF @RptaRegla IS NULL	-- COINCIDE POR NOMBRE PERO NO POR SOLICITUD Y OFICINA, O NO EXISTE LA ALERTA
						BEGIN
							INSERT INTO tAlertasPersonasBloqueadas (IdPersonaBloqueada, RptaRegla, 
																	CodSistema, CodSolicitud, CodOficina, FechaSistema)
							VALUES (@Id, 1, @CodSistema, @CodSolicitud, @CodOficina, GETDATE())

							SET @Msg = 'Se encontro una coincidencia de una persona bloqueada por PLD con el nombre: ' + 
									   @Nombre + ' ' + @ApellidoPaterno + ' ' + @ApellidoMaterno

							SET @Subject = 'Bloqueo por coincidencia de lista (' + @Nombre + ' ' + @ApellidoPaterno + ' ' + @ApellidoMaterno + ')'
					
							SET @Ret = -1	-- DEVUELVE "EN ESPERA" O "REVISIÓN"
						END
					ELSE IF @RptaRegla = 1	-- COINCIDE POR NOMBRE, SOLICITUD Y OFICINA PERO ESTÁ "EN ESPERA" O "REVISIÓN"
						BEGIN
							SET @Ret = -1	-- DEVUELVE "EN ESPERA" O "REVISIÓN"
						END
					ELSE IF @RptaRegla = 2	-- COINCIDE POR NOMBRE, SOLICITUD Y OFICINA PERO LA ALERTA YA FUE AUTORIZADA
						BEGIN
							SET @Ret = 1	-- DEVUELVE "ACEPTADO"
						END
					ELSE IF @RptaRegla = 3	-- COINCIDE POR NOMBRE, SOLICITUD Y OFICINA PERO LA ALERTA YA FUE RECHAZADA
						BEGIN
							SET @Ret = 0	-- DEVUELVE "RECHAZADO"
						END
				END
			ELSE IF @Count <= 0
				BEGIN
					SET @Msg = ''
					SET @Subject = ''
					/*SET @Msg = 'No se encontraron coincidencias de personas bloqueadas por PLD con el nombre: ' + 
							   @Nombre + ' ' + @ApellidoPaterno + ' ' + @ApellidoMaterno*/

					SELECT @Id = Id FROM tListaPersonasBloqueadas WITH (NOLOCK)
					WHERE UPPER(Nombre) LIKE '%' + UPPER(@Nombre) + '%'
					AND UPPER(ApellidoPaterno) LIKE '%' + @ApellidoPaterno + '%'
					AND UPPER(ApellidoMaterno) LIKE '%' + @ApellidoMaterno + '%'
					AND Activo = 1 AND IdArchivo = 0

					IF @Id <= 0
						BEGIN
							INSERT INTO tListaPersonasBloqueadas (IdArchivo, IdTipo, Tipo, FechaOficio, Nombre, 
																	ApellidoPaterno, ApellidoMaterno, FechaSistema)
							VALUES (0, 0, '', GETDATE(), @Nombre, @ApellidoPaterno, @ApellidoMaterno, GETDATE())
						
							SET @Id = SCOPE_IDENTITY()
						
							INSERT INTO tAlertasPersonasBloqueadas (IdPersonaBloqueada, RptaRegla, DictamenObservacion,
																	CodSistema, CodSolicitud, CodOficina, FechaSistema)
							VALUES (@Id, 2, 'Autorizada', @CodSistema, @CodSolicitud, @CodOficina, GETDATE())
						END
			
					SET @Ret = 1	-- DEVUELVE "ACEPTADO"
				END
			ELSE
				BEGIN
					SET @Msg = 'Se encontraron ' + CAST(@Count AS VARCHAR) + ' coincidencias de personas bloqueadas con el nombre: ' + 
							   @Nombre + ' ' + @ApellidoPaterno + ' ' + @ApellidoMaterno

					SET @Subject = 'Bloqueo por coincidencia de lista (' + @Nombre + ' ' + @ApellidoPaterno + ' ' + @ApellidoMaterno + ')'

					SELECT @Id = Id FROM tListaPersonasBloqueadas WITH (NOLOCK)
					WHERE UPPER(Nombre) LIKE '%' + UPPER(@Nombre) + '%'
					AND UPPER(ApellidoPaterno) LIKE '%' + @ApellidoPaterno + '%'
					AND UPPER(ApellidoMaterno) LIKE '%' + @ApellidoMaterno + '%'
					AND Activo = 1 AND IdArchivo = 0

					IF @Id <= 0
						BEGIN
							INSERT INTO tListaPersonasBloqueadas (IdArchivo, IdTipo, Tipo, FechaOficio, Nombre, ApellidoPaterno, 
																  ApellidoMaterno, FechaSistema)
							VALUES (0, 0, '', GETDATE(), @Nombre, @ApellidoPaterno, @ApellidoMaterno, GETDATE())

							SET @Id = SCOPE_IDENTITY()

							INSERT INTO tAlertasPersonasBloqueadas (IdPersonaBloqueada, RptaRegla, DictamenObservacion,
																	CodSistema, CodSolicitud, CodOficina, FechaSistema)
							VALUES (@Id, 1, 'Por revisar', @CodSistema, @CodSolicitud, @CodOficina, GETDATE()) 
						END

					SET @Ret = -2	-- SE ENCONTRÓ MÁS DE UNA COINCIDENCIA POR NOMBRE
				END

			IF LTRIM(RTRIM(@Msg)) <> ''
				BEGIN
					SET @Msg = @Subject + '|<html><body><p style=''font-family: Arial; font-size: small;''>' + @Msg + '</p></body></html>'
					EXEC [Finmas].[dbo].[pSgInsertaEnColaServicio] 'PL', 3, 'rmarroquinl@finamigo.com.mx', @Msg
				END

			RETURN @Ret
		END
END

GO