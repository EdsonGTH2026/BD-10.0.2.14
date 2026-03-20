SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO


CREATE PROCEDURE [dbo].[pCcConsultaStatusWS]  
(
@IdCC int
)      
AS    
   BEGIN       
        DECLARE @IdCCTemp INT;    
        DECLARE @Procesado VARCHAR(2);    
        DECLARE @Respuesta NVARCHAR(4000);    
        declare @CodUsarioTemp varchar(20);  
    	declare @Res VARCHAR (200) ; 
		declare @Respuestaerror varchar(900);
----### VERIFICA SI EL IDCC ENVIADO EXISTE #####---        
         SELECT @IdCCTemp=IdCC,     
                @Procesado= Procesado  ,
				@Respuestaerror=Respuesta
               FROM tCcConsulta WITH(NOLOCK)    
               WHERE IdCC = @IdCC  
              --and  CodUsuario=@CodUsario  
  
---IF  @CodUsarioTemp <> '' OR @CodUsarioTemp <> NULL  
 -- IF(ISNULL(@IdCCTemp, '') = '') --- or (ISNULL(@CodUsarioTemp, '') = '')  
    IF @IdCCTemp <>'' OR @IdCCTemp<>NULL    
-----#### SI EXISTE #####----    
            BEGIN  
			--set @Respuesta=''

			IF @Procesado = 1   
                    BEGIN   					
                        SELECT Respuesta    
                        FROM tCcConsultaRespuesta with(nolock)    
                        WHERE IdCC = @IdCC  
					    order by IdRespuesta asc
                END; 
				


            if  @Respuestaerror <>'' or @Respuestaerror <>null and @Procesado =0
		   --IF(ISNULL(@IdCCTemp, '') = '')
			begin
			   --    SELECT Respuesta 
      --                  FROM tccconsulta with(nolock)    
      --                  WHERE IdCC = @IdCC  					   
						--return 

						      					
                        SELECT Respuesta    
                        FROM tCcConsultaRespuesta with(nolock)    
                        WHERE IdCC = @IdCC  
					    order by IdRespuesta asc
			end

		
----### SI AUN ESTA EN PROCESO DE VALIDACION -----####    
                    ELSE    
                    BEGIN    
                        --SET @Res = 'En proceso de verificación';    
                         --SELECT @Res ;  
                        SET @Res = '1';    
                        SELECT @Res as Respuesta ;        
                END;    
        END;    
    
----#### SI NO EXISTE ###---    
            ELSE    
            BEGIN   
   --set @Res='No se encontro la clave buscada'  
   --select @Res  
              set @Res='-0'  
             select @Res    as Respuesta
        END;    
   END;  
  
  





















GO