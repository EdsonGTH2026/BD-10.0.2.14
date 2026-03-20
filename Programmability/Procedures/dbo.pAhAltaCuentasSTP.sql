SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[pAhAltaCuentasSTP]
AS
BEGIN 
SELECT T1.Nombres,
	T1.Paterno,
	T1.Materno,
	   convert (varchar ,T1.FechaNacimiento,112)as FechaNacimiento,
	CASE T1.Sexo
	WHEN 0 THEN 'M'  
	ELSE 'H'
	END  Sexo,
	T1.CodUsuario,
	R1.UsCURP,
	R1.UsCE,
	R1.UsTelefonoMovil,
	R1.UsCorreoE,
	R1.UsOcupacion,
	R1.CodUsuario,
	A1.ClabeInterbancaria,
	isnull(W1.Direccion,W2.Direccion) AS Calle,
	isnull(W1.NumExterno,W2.NumExterno) as NumExterno,
	isnull(W1.NumInterno,W2.NumInterno) as NumInterno,
	isnull(W1.CodPostal,W2.CodPostal) as CodPostal,
	A1.empresa
	FROM Finmas.dbo.tUsUsuarios  AS T1 with(nolock)
	INNER JOIN Finmas.dbo.tUsUsuarioSecundarios   AS R1 with(nolock) ON T1.CodUsuario = R1.CodUsuario
	LEFT JOIN Finmas.dbo.tUsUsuarioDireccion AS W1 with(nolock) ON T1.CodUsuario = W1.CodUsuario and W1.FamiliarNegocio = 'F'
	LEFT JOIN Finmas.dbo.tUsUsuarioDireccion AS W2 with(nolock) ON T1.CodUsuario = W2.CodUsuario and W2.FamiliarNegocio = 'N'
	INNER JOIN tAhCuentaClabeInterbancaria  AS A1 with(nolock) ON T1.CodUsuario = A1.CodUsario
	WHERE A1.AltaSTP = 0
END 
GO