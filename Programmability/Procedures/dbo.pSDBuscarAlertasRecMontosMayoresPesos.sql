SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[pSDBuscarAlertasRecMontosMayoresPesos](@FechaInicial DATETIME, @FechaFinal DATETIME, @TipoAlerta INT)
AS
BEGIN
	DECLARE @SQL NVARCHAR(2000)

	SET @SQL = N'SELECT Id, Codigo, Monto, CodUsuario, NombreCliente,
		   CONVERT(VARCHAR(10), FechaSistema, 111) AS FechaAlerta,
		   CASE RptaRegla 
		     WHEN 1 THEN ''Por revisar''
			 WHEN 2 THEN ''Autorizada''
			 WHEN 3 THEN ''Rechazada''
			 ELSE ''Desconocida''
			 END AS RptaRegla
	FROM tAlertasRecMontosMayoresPesosPLD WITH (NOLOCK)
	WHERE FechaSistema >= ''' + CONVERT(VARCHAR(20), @FechaInicial, 111) + ' 00:00:00''
	AND FechaSistema <= ''' + CONVERT(VARCHAR(20), @FechaFinal, 111) + ' 23:59:59'' '

	IF @TipoAlerta > 0
		BEGIN
			SET @SQL = @SQL + 'AND RptaRegla = ' + CAST(@TipoAlerta AS VARCHAR(20)) + ' '
		END

	--PRINT @SQL
	EXEC sp_executesql @SQL
END
GO