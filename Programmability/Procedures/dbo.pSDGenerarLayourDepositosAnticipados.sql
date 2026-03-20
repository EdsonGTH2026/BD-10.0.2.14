SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[pSDGenerarLayourDepositosAnticipados](@FechaInicial DATETIME, @FechaFinal DATETIME, @TipoAlerta INT, 
														      @CodigoLocalidad VARCHAR(8), @TipoOperacion VARCHAR(2))
AS
BEGIN
	DECLARE @SQL NVARCHAR(2000)

	SET @SQL = N'IF OBJECT_ID(N''#tmpLayoutDepAntPLD'') IS NOT NULL
					BEGIN
						DROP TABLE #tmpLayoutDepAntPLD 
					END
			   
			   CREATE TABLE #tmpLayoutDepAntPLD (
					RowId INT IDENTITY(1,1),
					DataInfo NVARCHAR(2000)
			   )

			   INSERT INTO #tmpLayoutDepAntPLD (DataInfo) 
			   SELECT ''2;'' + CONVERT(VARCHAR(10),GETDATE(),112) + '';??????;001002;027004;' + @CodigoLocalidad + ';'' + c.CodPostal + '';' + 
					@TipoOperacion + ';00;'' + REPLACE(a.Codigo,''-'','''') + 
					'';'' + CAST(a.Monto AS VARCHAR) + '';MXN;'' + CONVERT(VARCHAR(10),GETDATE(),112) + '';'' + CONVERT(VARCHAR(10),GETDATE(),112) + '';1;'' + 
					CASE WHEN (d.CodTPersona = ''01'') THEN ''1;'' ELSE ''2;'' END + d.UsRFCBD + '';'' + d.Nombres + '';'' + d.Paterno + '';'' + 
					d.Materno + '';'' + d.UsRFCBD + '';'' + CONVERT(VARCHAR(10),d.FechaNacimiento,112) + '';'' + e.Direccion + + '' '' + 
					e.NumExterno + '', Int: '' + e.NumInterno + '';'' + f.DescUbiGeo + '';'' + g.DescUbiGeo + '';'' + e.Telefono + '';;;;;;;;;;'' AS Linea
			   FROM tAlertasDepositosAnticipadosPLD a WITH (NOLOCK)
			   LEFT JOIN Finmas.dbo.tAhCuenta b WITH (NOLOCK) ON a.Codigo = b.CodCuenta
			   LEFT JOIN Finmas.dbo.tClOficinas c WITH (NOLOCK) ON b.CodOficina = c.CodOficina
			   LEFT JOIN Finmas.dbo.tUsUsuarios d WITH (NOLOCK) ON b.CodUsTitular = d.CodUsuario
			   LEFT JOIN Finmas.dbo.tUsUsuarioDireccion e WITH (NOLOCK) ON b.CodUsTitular = e.CodUsuario AND e.FamiliarNegocio = ''F''
			   LEFT JOIN Finmas.dbo.tClUbiGeo f WITH (NOLOCK) ON e.CodUbiGeo = f.CodUbiGeo
			   LEFT JOIN Finmas.dbo.tClUbiGeo g WITH (NOLOCK) ON g.CodArbolConta = SUBSTRING(f.CodArbolConta,1,19)
			   WHERE a.FechaSistema >= ''' + CONVERT(VARCHAR(20), @FechaInicial, 111) + ' 00:00:00 ''
			   AND a.FechaSistema <= ''' + CONVERT(VARCHAR(20), @FechaFinal, 111) + ' 23:59:59'' '

	IF @TipoAlerta > 0
		BEGIN
			SET @SQL = @SQL + 'AND a.RptaRegla = ' + CAST(@TipoAlerta AS VARCHAR(20)) + ' '
		END

	SET @SQL = @SQL + 'SELECT REPLACE(DataInfo,''??????'',RIGHT(''000000'' + CAST(RowId AS VARCHAR(6)),6)) AS Linea FROM #tmpLayoutDepAntPLD WITH (NOLOCK) 
					  DROP TABLE #tmpLayoutDepAntPLD'
	--PRINT @SQL
	EXEC sp_executesql @SQL
END
GO