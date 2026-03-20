SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE procedure [dbo].[pNumerosParaAletasSPEI]

AS

BEGIN
--SELECT UsTelefonoMovil FROM Finmas.dbo.tUsUsuarioSecundarios where CodUsuario in('IAR930917FH800','98SCC0912751','98UMC1809791')

SELECT UsTelefonoMovil FROM Finmas.dbo.tUsUsuarioSecundarios where CodUsuario ='98SCC0912751' --OMAR
--SELECT UsTelefonoMovil FROM Finmas.dbo.tUsUsuarioSecundarios where CodUsuario ='IAR930917FH800' ---RIA 

--SELECT UsTelefonoMovil FROM Finmas.dbo.tUsUsuarioSecundarios where CodUsuario in('','98SCC0912751')


END
GO