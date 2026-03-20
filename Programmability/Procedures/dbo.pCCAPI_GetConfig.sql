SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[pCCAPI_GetConfig]
AS
BEGIN
	SELECT Valor AS CCApiURL,
		(SELECT Valor FROM [Finmas].[dbo].[tSgConfigGeneral] WITH (NOLOCK) WHERE Tipo = 'CCKeypairPass') AS CCKeypairPass,
		(SELECT Valor FROM [Finmas].[dbo].[tSgConfigGeneral] WITH (NOLOCK) WHERE Tipo = 'CCUserName') AS CCUserName,
		(SELECT Valor FROM [Finmas].[dbo].[tSgConfigGeneral] WITH (NOLOCK) WHERE Tipo = 'CCUserPass') AS CCUserPass,
		(SELECT Valor FROM [Finmas].[dbo].[tSgConfigGeneral] WITH (NOLOCK) WHERE Tipo = 'CCxApiKey') AS CCxApiKey,
		(SELECT Valor FROM [Finmas].[dbo].[tSgConfigGeneral] WITH (NOLOCK) WHERE Tipo = 'CCEsProduccionDB') AS CCEsProduccionDB,
		(SELECT Valor FROM [Finmas].[dbo].[tSgConfigGeneral] WITH (NOLOCK) WHERE Tipo = 'CCEsProduccionCC') AS CCEsProduccionCC
	FROM [Finmas].[dbo].[tSgConfigGeneral] WITH (NOLOCK)
	WHERE Tipo = 'CCApiURL'
END

--EXEC [pCCAPI_GetConfig]
GO