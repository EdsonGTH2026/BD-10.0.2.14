SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

CREATE VIEW [dbo].[vPI_borrar]
AS

select 
p.codusuario, p.fechadesembolso,
/*			NÚMERO DE CUENTA							
			Ingresar el número de cuenta o crédito.							
PI			El dato de la cuenta debe pertenecer a la persona que es titular del crédito.		AN	25		V	O
											
			No se deben considerar: tarjetas adicionales, tarjetas de débito, cuentas de							
			inversión o cuentas de cheques u otro instrumento que no sea de crédito y el							
			titular de la misma.							*/
'PI' + dbo.fLongitudCampoINTL(p.CodPrestamo,25) +											
/*			CLAVE DEL USUARIO o M EMBER CODE							
00			Contiene la clave única o “MMember Code” del Usuario que otorgó el Crédito		AN	10		F	O
			mencionado en el campo PII.											
			Incluir si se tiene disponible.							*/
--'00' + 'MI25570001' +											
/*			NOMBRE DEL USUARIO							
01			Contiene el nombre del Usu ario que otorgó el Crédito mencionado en el campo		AN	16		V	O
			PI.														
			Incluir si se tiene disponible.					*/		
''
as 'PI'
from
(
	select p.Codusuario, p.CodPrestamo, p.fechadesembolso
	from
	finmas..tcaprestamos as p
	--where codusuario = '5HMA1504631'

	union

	select p.Codusuario, p.CodPrestamo, p.fechadesembolso
	from
	finmas..tcahprestamos as p
	--where codusuario = '5HMA1504631'

	--order by p.fechadesembolso desc
) as p
--finmas..tcaprestamos as p
--where p.codusuario = 'CGB901111F6415'
--order by p.FechaDesembolso desc




GO