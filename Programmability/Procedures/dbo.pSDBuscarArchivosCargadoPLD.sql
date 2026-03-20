SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[pSDBuscarArchivosCargadoPLD](@NombreArchivo VARCHAR(50), @Nombre VARCHAR(100), 
										 			@ApellidoPaterno VARCHAR(50), @ApellidoMaterno VARCHAR(50))
AS
BEGIN
	IF @NombreArchivo = '' AND @Nombre = '' AND @ApellidoPaterno = '' AND @ApellidoMaterno = ''
		BEGIN
			SELECT IdArchivo, NombreArchivo, CONVERT(VARCHAR(10), FechaSistema, 110) AS FechaCarga
			FROM tListaPersonasBloqueadas WITH (NOLOCK)
			WHERE Activo = 1 AND NombreArchivo IS NOT NULL
			GROUP BY IdArchivo, NombreArchivo, CONVERT(VARCHAR(10), FechaSistema, 110)
		END

	IF @NombreArchivo <> ''
		BEGIN
			SELECT IdArchivo, NombreArchivo, CONVERT(VARCHAR(10), FechaSistema, 110) AS FechaCarga
			FROM tListaPersonasBloqueadas WITH (NOLOCK)
			WHERE UPPER(NombreArchivo) LIKE '%' + UPPER(@NombreArchivo) + '%'
			AND Activo = 1 AND NombreArchivo IS NOT NULL
			GROUP BY IdArchivo, NombreArchivo, CONVERT(VARCHAR(10), FechaSistema, 110)

			RETURN
		END

	IF @Nombre <> ''
		BEGIN
			SELECT IdArchivo, NombreArchivo, CONVERT(VARCHAR(10), FechaSistema, 110) AS FechaCarga
			FROM tListaPersonasBloqueadas WITH (NOLOCK)
			WHERE UPPER(Nombre) LIKE '%' + UPPER(@Nombre) + '%'
			AND Activo = 1 AND NombreArchivo IS NOT NULL
			GROUP BY IdArchivo, NombreArchivo, CONVERT(VARCHAR(10), FechaSistema, 110)

			RETURN
		END

	IF @ApellidoPaterno <> ''
		BEGIN
			SELECT IdArchivo, NombreArchivo, CONVERT(VARCHAR(10), FechaSistema, 110) AS FechaCarga
			FROM tListaPersonasBloqueadas WITH (NOLOCK)
			WHERE UPPER(ApellidoPaterno) LIKE '%' + UPPER(@ApellidoPaterno) + '%'
			AND Activo = 1 AND NombreArchivo IS NOT NULL
			GROUP BY IdArchivo, NombreArchivo, CONVERT(VARCHAR(10), FechaSistema, 110)

			RETURN
		END

	IF @ApellidoMaterno <> ''
		BEGIN
			SELECT IdArchivo, NombreArchivo, CONVERT(VARCHAR(10), FechaSistema, 110) AS FechaCarga
			FROM tListaPersonasBloqueadas WITH (NOLOCK)
			WHERE UPPER(ApellidoMaterno) LIKE '%' + UPPER(@ApellidoMaterno) + '%'
			AND Activo = 1 AND NombreArchivo IS NOT NULL
			GROUP BY IdArchivo, NombreArchivo, CONVERT(VARCHAR(10), FechaSistema, 110)

			RETURN
		END
END
GO