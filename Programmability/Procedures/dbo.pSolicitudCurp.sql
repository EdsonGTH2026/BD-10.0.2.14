SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[pSolicitudCurp]
(@Codusuario    VARCHAR(20), 
 @CodSolicitud  VARCHAR(20), 
 @CodUSRegistro VARCHAR(20), 
 @CodSistema    VARCHAR(2), 
 @Codoficina    VARCHAR(3)
)
AS
BEGIN
    if not exists(select * from tCaSolicitudCurp where Codusuario = @Codusuario)
    begin
        INSERT INTO tCaSolicitudCurp
        (Codusuario, 
         CodSolicitud, 
         CodUSRegistro, 
         CodSistema, 
         CodOficina,
         Estado,
         FechaRegistro
        )
        VALUES
        (@Codusuario, 
         @CodSolicitud, 
         @CodUSRegistro, 
         @CodSistema, 
         @Codoficina,
         0,
         getdate()
        );
    end
    
  --  if not exists(select * from finmas.dbo.tususuariocurp where codusuario = @Codusuario)
  --  begin
		--insert into finmas.dbo.tususuariocurp (codusuario, curp) values (@Codusuario, '');
  --  end
END;
GO

GRANT EXECUTE ON [dbo].[pSolicitudCurp] TO [public]
GO