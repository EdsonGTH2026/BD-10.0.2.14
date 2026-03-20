SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[pBcConsultaStatusWS]
(@IdCC int,
 @CodUsario varchar(20),
 @Res NVARCHAR (1000) OUTPUT
)  

AS  
   BEGIN       
     
        DECLARE @IdCCTemp INT;  
        DECLARE @Procesado VARCHAR(2);  
        DECLARE @Respuesta VARCHAR(500);  
        declare @CodUsarioTemp varchar(20);
----### VERIFICA SI EL IDCC ENVIADO EXISTE #####---  
  
         SELECT @IdCCTemp=IdCC,   
                @Procesado= Procesado ,
			    @CodUsarioTemp=CodUsuario
               FROM tCcConsulta WITH(NOLOCK)  
               WHERE IdCC = @IdCC
			   and  CodUsuario=@CodUsario

IF  @CodUsarioTemp <> '' OR @CodUsarioTemp <> NULL
  --IF(ISNULL(@IdCCTemp, '') = '') --- or (ISNULL(@CodUsarioTemp, '') = '')
 --  IF @IdCCTemp <>'' OR @IdCCTemp<>NULL  
-----#### SI EXISTE #####----  
            BEGIN  
                IF @Procesado = 1  
                    BEGIN  
                        SELECT @Respuesta = Respuesta  
                        FROM tCcConsultaRespuesta with(nolock)  
                        WHERE IdCC = @IdCC;  

                        set @Res=@Respuesta
						select @Res
                END;  
----### SI AUN ESTA EN PROCESO DE VALIDACION -----####  
                    ELSE  
                    BEGIN  
                        --SET @Res = 'En proceso de verificación';  
                        --SELECT @Res ;
						  SET @Res = '1';  
                        SELECT @Res ;						
                END;  
        END;  
  
----#### SI NO EXISTE ###---  
            ELSE  
            BEGIN 
			--set @Res='No se encontro la clave buscada'
			--select @Res
              set @Res='-1'
			select @Res  
        END;  
   END;



GO