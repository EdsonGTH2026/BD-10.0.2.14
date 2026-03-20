SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[pAhAltaCuentasSTPQA]

AS

BEGIN 

select T1.Nombres,

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

		W1.Direccion AS Calle,

		W1.NumExterno,

		W1.NumInterno,

		W1.CodPostal

		FROM Finmas.dbo.tUsUsuarios  AS T1 with(nolock)

		INNER JOIN Finmas.dbo.tUsUsuarioSecundarios   AS R1 with(nolock)

		ON T1.CodUsuario= R1.CodUsuario

		INNER JOIN tAhCuentaClabeInterbancaria  AS A1 with(nolock)

		ON T1.CodUsuario= A1.CodUsario

		INNER JOIN Finmas.dbo.tUsUsuarioDireccion AS W1 with(nolock)

		ON T1.CodUsuario= W1.CodUsuario

		--WHERE A1.AltaSTP=0
		WHERE A1.ClabeInterbancaria ='646180173310009436'
		-- in (
		--'646180173310011550',
		--'646180173310011576',
		--'646180173310011602',
		--'646180173310011660',
		--'646180173310011770',
		--'646180173310011848',
		--'646180173310011932',
		--'646180173310012083',
		--'646180173310012232'
		--)
		 --and A1.altastp=0

		END 
GO