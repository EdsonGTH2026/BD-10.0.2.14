SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO




CREATE PROCEDURE [dbo].[pEstadoTransaccionSTP2]
(@IdSTP       INT, 
 @estado      VARCHAR(20), 
 @detalle     VARCHAR(20), 
 @empresa     VARCHAR(20), 
 @folioOrigen VARCHAR(50)
)
AS
    BEGIN
        -- declare @IdSTP       INT;   
        --declare @estado      VARCHAR(20) ;  
        --declare @detalle     VARCHAR(20);   
        --declare @empresa     VARCHAR(20);   
        --declare @folioOrigen VARCHAR(50);  
        -- set @IdSTP=50220541  
        -- set @estado='liquidacion'  
        -- set @detalle=''  
        -- set @empresa='FINAMIGOOCS'  
        -- set @folioOrigen='FGO20200121183314'  

        DECLARE @CodCuenta VARCHAR(20);
        DECLARE @Monto MONEY;
        DECLARE @EstadoRes VARCHAR(20);
        DECLARE @FolioOrigen2 VARCHAR(100);
        DECLARE @res INT;
        DECLARE @id INT;
	   
	    DECLARE @id2 INT;
		declare @EstadoRes2 varchar(20)
		                     
        SELECT  @EstadoRes2 = Estado              
                FROM tAhTransaccionDiariaRetiraSPEI WITH(NOLOCK)
                WHERE IdSTP =@IdSTP ;
			
     if @EstadoRes2 <>'' or @EstadoRes2 <>null  
                   begin 
				   print 'Ya se reliazo la operacion '
				   return
				   end

				   else
				   begin       
                ---ACTUALIZAMOS LOS DATOS ENVIADOS POR STP -----   
                UPDATE tAhTransaccionDiariaRetiraSPEI
                  SET Estado = @estado, 
                      Detalle = @detalle, 
                      Empresa = @empresa, 
                      FolioOrigen = @folioOrigen
                WHERE IdSTP = @IdSTP;

                ----CONSULTAMOS EL ESTADO ------  
                SELECT @CodCuenta = CodCuenta, 
                       @Monto = Monto, 
                       @EstadoRes = Estado, 
                       @FolioOrigen2 = FolioOrigen
                FROM tAhTransaccionDiariaRetiraSPEI WITH(NOLOCK)
                WHERE IdSTP = @IdSTP;

               -- PRINT @EstadoRes;
                IF @EstadoRes = 'liquidacion' ---liquidacion
                    BEGIN
                        UPDATE tAhTransaccionDiariaRetiraSPEI
                          SET  FechaHoraEstado = GETDATE()
                        WHERE IdSTP = @IdSTP;

					 EXEC Finmas.dbo.pAhRetiroCuentaSPEI 
                     @CodCuenta, 
                     @Monto, 
                    '98CSM1803891', 
                     @IdSTP, 
                     @folioOrigen;
					  UPDATE Finmas.dbo.tahcuenta
                  SET 
                      idEstadoCta = 'CA'
                      WHERE codcuenta = @CodCuenta;
                END;
               else
			   begin 
                UPDATE Finmas.dbo.tahcuenta
                  SET 
                      idEstadoCta = 'CA'
                WHERE codcuenta = @CodCuenta;
				end;
        --END;
        --    ELSE
        --    BEGIN
        --        UPDATE Finmas.dbo.tahcuenta
        --          SET 
        --              idEstadoCta = 'CA'
        --        WHERE codcuenta = @CodCuenta;
        --END;

		--end;

		--else
		end
    END





GO