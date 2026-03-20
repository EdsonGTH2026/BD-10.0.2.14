SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[pSolicitudCurpExterna]
(@CodSolicitud           VARCHAR(18), 
 @Nombre                 VARCHAR(50), 
 @ApellidoPaterno        VARCHAR(50), 
 @ApellidoMaterno        VARCHAR(50), 
 @Sexo                   CHAR(1), 
 @FechaNacimiento        VARCHAR(10), 
 @ClaveEntidadFederativa CHAR(2), 
 @FechaRegistro          SMALLDATETIME, 
 @UsuarioSolicitud       VARCHAR(30)
)
AS
    BEGIN
        IF NOT EXISTS
        (
            SELECT *
            FROM FinamigoCURP.dbo.tCaSolicitudCurpExterno
            WHERE CodSolicitud = @CodSolicitud
        )
            BEGIN
                INSERT INTO FinamigoCURP.dbo.tCaSolicitudCurpExterno
                (CodSolicitud, 
                 Nombre, 
                 Paterno, 
                 Materno, 
                 Sexo, 
                 FNacimiento, 
                 EntidadFederativa, 
                 UsuarioSolicitud, 
                 FechaRegistro
                )
                VALUES
                (@CodSolicitud, 
                 @Nombre, 
                 @ApellidoPaterno, 
                 @ApellidoMaterno, 
                 @Sexo, 
                 @FechaNacimiento, 
                 @ClaveEntidadFederativa, 
                 @UsuarioSolicitud, 
                 @FechaRegistro
                );
        END;
    END;
GO