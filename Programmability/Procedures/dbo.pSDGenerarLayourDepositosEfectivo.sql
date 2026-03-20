SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[pSDGenerarLayourDepositosEfectivo](@FechaInicial DATETIME, @FechaFinal DATETIME, @TipoAlerta INT, 
														   @CodigoLocalidad VARCHAR(8))
AS
BEGIN
	DECLARE @SQL NVARCHAR(4000)

	SET @SQL = N'IF OBJECT_ID(N''#tmpLayoutPLD'') IS NOT NULL
					BEGIN
						DROP TABLE #tmpLayoutPLD 
					END
			   
			   CREATE TABLE #tmpLayoutPLD (
					RowId INT IDENTITY(1,1),
					DataInfo NVARCHAR(2000)
			   )

			   INSERT INTO #tmpLayoutPLD (DataInfo) 
			   SELECT ''1;'' + CONVERT(VARCHAR(10),GETDATE(),112) + '';'' + Right(''000000'' + CONVERT(NVARCHAR, a.Id), 6) + '';001002;027004;' + @CodigoLocalidad + ';'' + c.CodPostal + '';'' +
					CASE WHEN (a.CodSistema = ''TC'') THEN ''11;'' WHEN (a.CodSistema = ''AH'') THEN ''09;'' ELSE ''00;'' END + 
					''01;'' + REPLACE(a.Codigo,''-'','''') + 
					'';'' + CAST(a.Monto AS VARCHAR) + '';MXN;'' + CONVERT(VARCHAR(10),GETDATE(),112) + '';'' + CONVERT(VARCHAR(10),a.FechaSistema,112) + '';1;'' + 
					CASE WHEN (d.CodTPersona = ''01'') THEN ''1;'' ELSE ''2;'' END + d.UsRFCBD + '';'' + d.Nombres + '';'' + d.Paterno + '';'' + 
					d.Materno + '';'' + d.UsRFCBD + '';'' + d.UsCURPBD + '';'' + CONVERT(VARCHAR(10),d.FechaNacimiento,112) + '';'' + e.Direccion + '' '' + 
					e.NumExterno + '', Int: '' + e.NumInterno + '';'' + f.DescUbiGeo + '';'' + g.DescUbiGeo + '';'' + e.Telefono + '';;;;;;;;;;;;;;'' AS Linea
			   FROM tAlertasDepositosExcedidosPLD a WITH (NOLOCK)
			   LEFT JOIN Finmas.dbo.tAhCuenta b WITH (NOLOCK) ON a.Codigo = b.CodCuenta
			   LEFT JOIN Finmas.dbo.tClOficinas c WITH (NOLOCK) ON b.CodOficina = c.CodOficina
			   LEFT JOIN Finmas.dbo.tUsUsuarios d WITH (NOLOCK) ON b.CodUsTitular = d.CodUsuario
			   LEFT JOIN Finmas.dbo.tUsUsuarioDireccion e WITH (NOLOCK) ON b.CodUsTitular = e.CodUsuario AND e.FamiliarNegocio = ''F''
			   LEFT JOIN Finmas.dbo.tClUbiGeo f WITH (NOLOCK) ON e.CodUbiGeo = f.CodUbiGeo
			   LEFT JOIN Finmas.dbo.tClUbiGeo g WITH (NOLOCK) ON f.CodEstado = g.CodEstado AND g.CodUbiGeoTipo = ''ESTA''
			   WHERE a.FechaSistema >= ''' + CONVERT(VARCHAR(20), @FechaInicial, 111) + ' 00:00:00 ''
			   AND a.FechaSistema <= ''' + CONVERT(VARCHAR(20), @FechaFinal, 111) + ' 23:59:59'' '

	IF @TipoAlerta > 0
		BEGIN
			SET @SQL = @SQL + 'AND a.RptaRegla = ' + CAST(@TipoAlerta AS VARCHAR(20)) + ' '
		END
	
	SET @SQL = @SQL + 'UNION '
	SET @SQL = @SQL + 'SELECT ''1;'' + CONVERT(VARCHAR(10),GETDATE(),112) + '';'' + Right(''000000'' + CONVERT(NVARCHAR, a.Id), 6) + '';001002;027004;' + @CodigoLocalidad + ';'' + c.CodPostal + '';'' +
					CASE WHEN (a.CodSistema = ''TC'') THEN ''11;'' WHEN (a.CodSistema = ''AH'') THEN ''09;'' ELSE ''00;'' END + 
					''01;'' + REPLACE(a.Codigo,''-'','''') + 
					'';'' + CAST(a.Monto AS VARCHAR) + '';MXN;'' + CONVERT(VARCHAR(10),GETDATE(),112) + '';'' + CONVERT(VARCHAR(10),a.FechaSistema,112) + '';1;'' + 
					CASE WHEN (d.CodTPersona = ''01'') THEN ''1;'' ELSE ''2;'' END + d.UsRFCBD + '';'' + d.Nombres + '';'' + d.Paterno + '';'' + 
					d.Materno + '';'' + d.UsRFCBD + '';'' + d.UsCURPBD + '';'' + CONVERT(VARCHAR(10),d.FechaNacimiento,112) + '';'' + e.Direccion + '' '' + 
					e.NumExterno + '', Int: '' + e.NumInterno + '';'' + f.DescUbiGeo + '';'' + g.DescUbiGeo + '';'' + e.Telefono + '';;;;;;;;;;;;;;'' AS Linea
			   FROM tAlertasDepositosExcedidosPLD a WITH (NOLOCK)
			   LEFT JOIN Finmas.dbo.tCaPrestamos b WITH (NOLOCK) ON a.Codigo = b.CodPrestamo
			   LEFT JOIN Finmas.dbo.tClOficinas c WITH (NOLOCK) ON b.CodOficina = c.CodOficina
			   LEFT JOIN Finmas.dbo.tUsUsuarios d WITH (NOLOCK) ON b.CodUsuario = d.CodUsuario
			   LEFT JOIN Finmas.dbo.tUsUsuarioDireccion e WITH (NOLOCK) ON b.CodUsuario = e.CodUsuario AND e.FamiliarNegocio = ''F''
			   LEFT JOIN Finmas.dbo.tClUbiGeo f WITH (NOLOCK) ON e.CodUbiGeo = f.CodUbiGeo
			   LEFT JOIN Finmas.dbo.tClUbiGeo g WITH (NOLOCK) ON f.CodEstado = g.CodEstado AND g.CodUbiGeoTipo = ''ESTA''
			   WHERE a.FechaSistema >= ''' + CONVERT(VARCHAR(20), @FechaInicial, 111) + ' 00:00:00 ''
			   AND a.FechaSistema <= ''' + CONVERT(VARCHAR(20), @FechaFinal, 111) + ' 23:59:59'' '
			   
	IF @TipoAlerta > 0
		BEGIN
			SET @SQL = @SQL + 'AND a.RptaRegla = ' + CAST(@TipoAlerta AS VARCHAR(20)) + ' '
		END

	SET @SQL = @SQL + 'SELECT REPLACE(DataInfo,''??????'',RIGHT(''000000'' + CAST(RowId AS VARCHAR(6)),6)) AS Linea FROM #tmpLayoutPLD WITH (NOLOCK) 
					   WHERE DataInfo IS NOT NULL
					  DROP TABLE #tmpLayoutPLD'
	--PRINT @SQL
	EXEC sp_executesql @SQL
END
GO