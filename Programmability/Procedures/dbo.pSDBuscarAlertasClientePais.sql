SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[pSDBuscarAlertasClientePais](@FechaInicial DATETIME, @FechaFinal DATETIME, @TipoAlerta INT)
AS
--BEGIN
	--declare @FechaInicial DATETIME
	--declare @FechaFinal DATETIME
	--declare @TipoAlerta INT
	--set @FechaInicial='20220501'
	--set @FechaFinal='20220531'
	--set @TipoAlerta=1
	set nocount on
	DECLARE @SQL NVARCHAR(2000)

	SET @SQL = N'SELECT a.Id, a.CodUsuario, a.codpais, b.pais,u.nombrecompleto,a.codsistema,
		   CONVERT(VARCHAR(10), a.FechaSistema, 111) AS FechaAlerta,
		   CASE a.RptaRegla 
		     WHEN 1 THEN ''Por revisar''
			 WHEN 2 THEN ''Autorizada''
			 WHEN 3 THEN ''Rechazada''
			 ELSE ''Desconocida''
			 END AS RptaRegla
	FROM tAlertasPais a WITH (NOLOCK)
	inner join finmas.dbo.tclpaises b with(nolock) on b.codpais=a.codpais
	inner join finmas.dbo.tususuarios u with(nolock) on a.codusuario=u.codusuario
	WHERE a.FechaSistema >= ''' + CONVERT(VARCHAR(20), @FechaInicial, 111) + ' 00:00:00''
	AND a.FechaSistema <= ''' + CONVERT(VARCHAR(20), @FechaFinal, 111) + ' 23:59:59'' '

	IF @TipoAlerta > 0
		BEGIN
			SET @SQL = @SQL + 'AND RptaRegla = ' + CAST(@TipoAlerta AS VARCHAR(20)) + ' '
		END

	--PRINT @SQL
	EXEC sp_executesql @SQL
--END

--select * from finmas.dbo.tclpaises

GO