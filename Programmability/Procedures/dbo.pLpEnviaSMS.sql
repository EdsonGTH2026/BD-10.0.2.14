SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
create procedure [dbo].[pLpEnviaSMS] (@IdProceso int, @MensajeSMS varchar(160), @IdSMS int output )
as
BEGIN
--ver. 18-01-2020
	set nocount on

	declare @CodUsuario varchar(20)
    DECLARE @mensaje VARCHAR(160);--Limite máximo del mensaje.
    DECLARE @telefono VARCHAR(10);
    SET @mensaje = '';
    
    set @mensaje = @mensaje + ' ' + @MensajeSMS
   
    select @telefono = NumCelular, @CodUsuario = curp 
    from tLpProceso as p
    inner join tLpSolicitudPromotor as sp on sp.IdSolicitudPromotor = p.IdSolicitudPromotor
    where IdProceso = @IdProceso
	
    IF isnull(@telefono,'') <> ''
		begin
			INSERT INTO finamigows.dbo.tWAVYEnvioSMS
			(FechaHora, 
			 Sistema, 
			 CodCliente, 
			 Telefono, 
			 MensajeSMS, 
			 consultado, 
			 Activo
			)
			VALUES
			(GETDATE(), 
			 'LP', 
			 @CodUsuario, 
			 @telefono, 
			 @mensaje, 
			 '0', 
			 1
			);
        end
    ELSE
		begin
		   PRINT 'El usuario no tiene un número telefonico';
		end
    
    select @IdSMS = IdRegistro from finamigows.dbo.tWAVYEnvioSMS 
    where CodCliente = @CodUsuario and Telefono = @telefono and Sistema = 'LP' and consultado = 0
    
    set @IdSMS = isnull(@IdSMS,0)

END
GO