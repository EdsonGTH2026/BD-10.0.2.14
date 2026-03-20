SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[PcCNotificacionResCCWS]
AS
BEGIN
Select IdCC from tccconsulta with(nolock)
where Procesado=1
and Notificado =0
and ClienteExterno like '%DBMenos%'
end 
GO