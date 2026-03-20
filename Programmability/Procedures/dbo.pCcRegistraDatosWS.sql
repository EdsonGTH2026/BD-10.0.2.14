SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[pCcRegistraDatosWS]
(
 @Parametros  VARCHAR(4000), 
 @Usuario varchar(20),
 @Response NVARCHAR (20) OUTPUT     
)
AS
    BEGIN 

	declare @IdCC int
	set @IdCC=0

	  INSERT INTO tCcConsulta
        (CodUsuario, 
         FechaRegistro, 
         Procesado, 
         Cuenta, 
         CodOficina, 
         Activo,
		 Tipo,
		 Consulta,
		 ClienteExterno,
		 Comentario
        )
        VALUES
        ('', 
         GETDATE(), 
         0, 
         '', 
         '98', 
         1,
		 'E',
		 '',
		 @Usuario,
		 ''
        );

	  SELECT  @IdCC =MAX(IdCC) 
      FROM tCcConsulta WITH(NOLOCK)  

	  insert into tccconsultaespecialparametro(IdCC,ParametroXML,FechaAlta)
	  values (@IdCC,@Parametros,getdate())

	set @Response=@IdCC
   SELECT @Response
	end
GO