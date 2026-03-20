SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
Create procedure [dbo].[SP_tCaSolicitudCurp](
@Codusuario varchar(20),
@CodSolicitud varchar (20),
@CodUSRegistro VARCHAR(20),
@CodSistema VARCHAR (2),
@Codoficina varchar(3)
)
AS
BEGIN
INSERT into  tCaSolicitudCurp(Codusuario,
	                          CodSolicitud,
							  CodUSRegistro,
							  CodSistema,
							  CodOficina)
             VALUES     (
			            @Codusuario,
				        @CodSolicitud,
						@CodUSRegistro,
						@CodSistema,
						@Codoficina
						)
end 
GO

GRANT EXECUTE ON [dbo].[SP_tCaSolicitudCurp] TO [public]
GO