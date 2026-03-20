SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[pSDBuscarAlertasPersonasBloqueadas](@FechaInicial DATETIME, @FechaFinal DATETIME, @Nombre VARCHAR(100),
														   @ApellidoPaterno VARCHAR(50), @ApellidoMaterno VARCHAR(50), @TipoAlerta INT)
AS
BEGIN
	DECLARE @SQL NVARCHAR(2000)

	SET @SQL = N'SELECT a.Id, a.IdPersonaBloqueada, (b.Nombre + '' '' + b.ApellidoPaterno + '' '' + b.ApellidoMaterno) AS NombreCompleto, 
		   b.RFC, CONVERT(VARCHAR(10), b.FechaNacimiento, 111) AS FechaNacimiento, b.Motivo, a.CodSolicitud, a.CodOficina, 
		   CONVERT(VARCHAR(10), a.FechaSistema, 111) AS FechaAlerta,
		   CASE a.RptaRegla 
		     WHEN 1 THEN ''Por revisar''
			 WHEN 2 THEN ''Autorizada''
			 WHEN 3 THEN ''Rechazada''
			 ELSE ''Desconocida''
			 END AS RptaRegla
	FROM tAlertasPersonasBloqueadas a WITH (NOLOCK)
	LEFT JOIN tListaPersonasBloqueadas b WITH (NOLOCK) ON a.IdPersonaBloqueada = b.Id AND b.Activo = 1 
	WHERE a.FechaSistema >= ''' + CONVERT(VARCHAR(20), @FechaInicial, 111) + ' 00:00:00''
	AND a.FechaSistema <= ''' + CONVERT(VARCHAR(20), @FechaFinal, 111) + ' 23:59:59'' '

	IF @Nombre <> ''
		BEGIN
			SET @SQL = @SQL + 'AND b.Nombre LIKE ''%' + @Nombre + '%'' '
		END

	IF @ApellidoPaterno <> ''
		BEGIN
			SET @SQL = @SQL + 'AND b.ApellidoPaterno LIKE ''%' + @ApellidoPaterno + '%'' '
		END

	IF @ApellidoMaterno <> ''
		BEGIN
			SET @SQL = @SQL + 'AND b.ApellidoMaterno LIKE ''%' + @ApellidoMaterno + '%'' '
		END

	IF @TipoAlerta > 0
		BEGIN
			SET @SQL = @SQL + 'AND a.RptaRegla = ' + CAST(@TipoAlerta AS VARCHAR(20)) + ' '
		END

	--PRINT @SQL
	EXEC sp_executesql @SQL
END
GO