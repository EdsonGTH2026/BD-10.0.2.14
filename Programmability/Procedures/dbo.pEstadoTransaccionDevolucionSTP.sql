SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

--RIA:2020-05-05: SP PARA REALIZAR UNA DEVOLUCION AUNA CUENTA POR UN SEGUNDO CAMBIO DE ESTADO

CREATE PROCEDURE [dbo].[pEstadoTransaccionDevolucionSTP]
(@IdSTP       INT, 
 @estado      VARCHAR(20), 
 @detalle     VARCHAR(100), 
 @empresa     VARCHAR(20), 
 @folioOrigen VARCHAR(50)
)
AS
    BEGIN
	 DECLARE @CodCuenta VARCHAR(20);
	 DECLARE @Monto MONEY;
	 DECLARE @renovado INT;

		--- CONSULTAMOS CUENTA EN TAHCUENTA -----
			SELECT @renovado = MAX (renovado)
			FROM Finmas.dbo.tahcuenta
			WHERE codCuenta = @CodCuenta;


  --### ACTUALIZA DATOS DE DEVOLUCION QUE ENVIA STP ---####
        UPDATE tAhTransaccionDiariaRetiraSPEI
          SET 
              Estado = @estado, 
              Detalle = @detalle, 
              Empresa = @empresa, 
              FechaHoraEstado = GETDATE(), 
              FolioOrigen = @folioOrigen
        WHERE IdSTP = @IdSTP;

		  SELECT @CodCuenta = CodCuenta, 
                 @Monto = Monto                      
                FROM tAhTransaccionDiariaRetiraSPEI WITH(NOLOCK)
                WHERE IdSTP = @IdSTP;

--### EJECUTA SP PARA REALIZAR LA DEVOLUCION ALA CUENTA --####
        EXEC Finmas.dbo.pAhDevolucionCuentaSPEI 
             @Codcuenta, 
             @Monto, 
             '98CSM1803891', 
             @FolioOrigen, 
             @IdSTP;
	--## ACTUALIZA EL ESTADO DE LA CUENTA A CA --###
        UPDATE Finmas.dbo.tahcuenta
          SET idEstadoCta = 'CA'
        WHERE codcuenta = @CodCuenta
        AND renovado = @renovado;

--## ACTUALIZALA TABALA INICIAL CON EL ESTADO FINAL Y LA FECHA ---##		
        UPDATE tAhTransaccionDiariaSTP
          SET 
              Estado = 5, 
              FechaProcesoFin = GETDATE()
        WHERE ClaveRastreo = @folioOrigen;
    END;
GO