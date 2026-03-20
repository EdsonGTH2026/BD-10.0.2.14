SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[pSDBuscaArchivoPaisesCargadoConFiltros](@NombreArchivo VARCHAR(50), @Pais VARCHAR(80), 
										 					    @Riesgo VARCHAR(10))
AS
BEGIN
	IF @NombreArchivo = '' AND @Pais = '' AND @Riesgo = ''
		BEGIN
			SELECT IdArchivo, NombreArchivo, CONVERT(VARCHAR(10), FechaSistema, 110) AS FechaCarga
			FROM tListaArchivosPaisesCargados WITH (NOLOCK)
			WHERE Activo = 1 AND NombreArchivo IS NOT NULL
			GROUP BY IdArchivo, NombreArchivo, CONVERT(VARCHAR(10), FechaSistema, 110)
		END

	IF @NombreArchivo <> ''
		BEGIN
			SELECT IdArchivo, NombreArchivo, CONVERT(VARCHAR(10), FechaSistema, 110) AS FechaCarga
			FROM tListaArchivosPaisesCargados WITH (NOLOCK)
			WHERE UPPER(NombreArchivo) LIKE '%' + UPPER(@NombreArchivo) + '%'
			AND Activo = 1 AND NombreArchivo IS NOT NULL
			GROUP BY IdArchivo, NombreArchivo, CONVERT(VARCHAR(10), FechaSistema, 110)

			RETURN
		END

	IF @Pais <> ''
		BEGIN
			SELECT IdArchivo, NombreArchivo, CONVERT(VARCHAR(10), FechaSistema, 110) AS FechaCarga
			FROM tListaArchivosPaisesCargados WITH (NOLOCK)
			WHERE UPPER(Pais) LIKE '%' + UPPER(@Pais) + '%'
			AND Activo = 1 AND NombreArchivo IS NOT NULL
			GROUP BY IdArchivo, NombreArchivo, CONVERT(VARCHAR(10), FechaSistema, 110)

			RETURN
		END

	IF @Riesgo <> ''
		BEGIN
			SELECT IdArchivo, NombreArchivo, CONVERT(VARCHAR(10), FechaSistema, 110) AS FechaCarga
			FROM tListaArchivosPaisesCargados WITH (NOLOCK)
			WHERE UPPER(Riesgo) LIKE '%' + UPPER(@Riesgo) + '%'
			AND Activo = 1 AND NombreArchivo IS NOT NULL
			GROUP BY IdArchivo, NombreArchivo, CONVERT(VARCHAR(10), FechaSistema, 110)

			RETURN
		END
END
GO