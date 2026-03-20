SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO



CREATE PROCEDURE [dbo].[pCcInsertaDatosWS]
(@CodUsuario VARCHAR(20), 
 @CodOficina VARCHAR(5), 
 @CodCuenta  VARCHAR(20), 
 @Response NVARCHAR (20) OUTPUT     
)
AS
    BEGIN 

        declare @Fechareg smalldatetime---fecha actual 
		declare @FechActual varchar (12) ---fecha actual convertida yyyy-mm-dd
	    declare @FechUltConsulta smalldatetime
		declare @FechaUltcon varchar(12)
		declare @IdCC int
	    DECLARE @Fechalibre  smalldatetime
		--- FECHA ACTUAL
		set @Fechareg=  getdate()
	    set @FechActual=  convert(varchar, @Fechareg,23)     
	 -- PRINT @FechActual
		SELECT @FechUltConsulta =FechaRegistro, @IdCC= max(IdCC) 
		FROM tCcConsulta with(nolock)
	    where CodUsuario=@CodUsuario  
		AND CodOficina =@CodOficina
        GROUP BY FechaRegistro	
	    set @FechaUltcon= convert(varchar,@FechUltConsulta,23)
	
	declare @Fechalibretemp varchar(12)
	set @Fechalibre= dATEADD(Month,1,@FechaUltcon)
    set @Fechalibretemp= convert(varchar,@Fechalibre,23)
--	PRINT '1 MES'+ @Fechalibretemp
		-- select  dATEADD(Month,1,'2020-01-01') 

	if @Fechalibretemp >=@FechActual
	begin	
	 set @Response='-1'  ---SI REALIZA MAS DE UNA CONSULTA POR MES REGRESA -1
	SELECT @Response
	end
	else
	begin 
        INSERT INTO tCcConsulta
        (CodUsuario, 
         FechaRegistro, 
         Procesado, 
         Cuenta, 
         CodOficina, 
         Activo,
		 Tipo,
		 Consulta
        )
        VALUES
        (@CodUsuario, 
         GETDATE(), 
         0, 
         @CodCuenta, 
         @CodOficina, 
         1,
		 'E',
		 ''
        );

		SET @IdCC=0

	  SELECT  @IdCC =MAX(IdCC) 
      FROM tCcConsulta WITH(NOLOCK)  
   --   WHERE CodUsuario=@CodUsuario
	  --AND CodOficina=@CodOficina
	   SELECT @IdCC
	end
		
    END;



GO