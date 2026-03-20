SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[pSDBuscarAlertasRiesgoCliente](@FechaInicial DATETIME, @FechaFinal DATETIME, @TipoAlerta INT, @Riesgo VARCHAR(5), 
													   @NombreCliente VARCHAR(120), @TipoProceso VARCHAR(2), @Top500 BIT = 0)
AS
BEGIN
	DECLARE @SQL NVARCHAR(2000)

	IF @Top500 = 1
		BEGIN
			SET @SQL = N'SELECT TOP 500 '
		END
	ELSE
		BEGIN
			SET @SQL = N'SELECT '
		END

	SET @SQL = @SQL + 'a.Id, a.CodUsuario, u.NombreCompleto, a.NroSolicitud, a.CodOficina, a.PuntTotal, SUM(a.SaldoCuenta) AS SaldoCuenta, 
		   CASE a.CodSistema 
		     WHEN ''IN'' THEN ''Inicial''
		     WHEN ''AH'' THEN ''Apertura''
			 WHEN ''SM'' THEN ''Semestral''
			 WHEN ''MS'' THEN ''Mensual''
			 ELSE ''Desconocido'' END AS TipoProceso,
		   a.RiesgoTotal AS Riesgo,
		   CONVERT(VARCHAR(10), a.FechaRegistro, 111) AS FechaAlerta,
		   CASE a.RptaRegla 
		     WHEN 1 THEN ''Por revisar''
			 WHEN 2 THEN ''Autorizada''
			 WHEN 3 THEN ''Rechazada''
			 ELSE ''Desconocida''
			 END AS RptaRegla
	FROM tAlertasRiesgoCliente AS a WITH (NOLOCK)
	LEFT JOIN Finmas.dbo.tUsUsuarios AS u WITH (NOLOCK) ON a.CodUsuario = u.CodUsuario
	WHERE a.FechaRegistro >= ''' + CONVERT(VARCHAR(20), @FechaInicial, 111) + ' 00:00:00''
	AND a.FechaRegistro <= ''' + CONVERT(VARCHAR(20), @FechaFinal, 111) + ' 23:59:59'' '

	IF @TipoAlerta > 0
		BEGIN
			SET @SQL = @SQL + 'AND a.RptaRegla = ' + CAST(@TipoAlerta AS VARCHAR(20)) + ' '
		END

	IF @Riesgo <> ''
		BEGIN
			SET @SQL = @SQL + 'AND a.RiesgoTotal = ''' + @Riesgo + ''' '
		END

	IF @NombreCliente <> ''
		BEGIN
			SET @SQL = @SQL + 'AND u.NombreCompleto LIKE ''%' + @NombreCliente + '%'' '
		END

	IF @TipoProceso <> ''
		BEGIN
			SET @SQL = @SQL + 'AND a.CodSistema = ''' + @TipoProceso + ''' '
		END

	SET @SQL = @SQL + 'GROUP BY a.Id, a.CodUsuario, u.NombreCompleto, a.NroSolicitud, a.CodOficina, a.PuntTotal, a.RiesgoTotal, '
	SET @SQL = @SQL + 'a.FechaRegistro, a.RptaRegla, a.SaldoCuenta, a.CodSistema'

	--PRINT @SQL
	EXEC sp_executesql @SQL
END
GO