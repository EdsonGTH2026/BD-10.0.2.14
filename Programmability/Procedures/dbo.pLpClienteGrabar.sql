SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE procedure [dbo].[pLpClienteGrabar](
    @IdProceso int,
	@CodPromotor varchar(20),
	@APaterno varchar(20),
	@AMaterno varchar(20),
	@Nombres varchar(20),
	@FecNacimiento smalldatetime,
	@CodDocIden varchar(4), 
	@DI varchar(20),
	@CodEstadoCivil varchar(1),
	@Genero varchar(1),
	--direccion Titular
	@FamiliarNegocio varchar(1),
	@Direccion varchar(150),
	@NumExterno varchar(10),
	@NumInterno varchar(10),
	@Ubicacion varchar(150),
	@CodPostal  varchar(5), 
	@localidad	varchar(50),
	@EsPrincipal bit,
	@TiempoDirDesde  smallint,
	@TiempoCiudad smallint,
	@Telefono varchar(20),
	@Observaciones varchar(250),
	--secundarios Titular
	@UsLugarNac varchar(10),
	@UsCURP varchar(30),
	@UsRUC varchar(20), 
	@UsTelefonoMovil varchar(50) ,
	@LabActividad varchar(50),
	@correo varchar(50),
	@ClaveBancoSTP varchar(10),
	@CLABE varchar(18)
) 
as
BEGIN
	--Ver. 26-01-2021
	--Ver. 11-02-2021
	set nocount on

	declare @ShowPrint bit
	declare @FechaProceso smalldatetime
	--declare @CodPromotor varchar(20)
	--declare @Promotor varchar(20)
	declare @CodOficina varchar(3)
	declare @CodTitular varchar(20)
	declare @ConTransaccion  bit
	
	--set @CodPromotor='98CSM1803891'
	--set @Promotor = 'mchavezs'
	set @ShowPrint = 0

	--VARIABLES PARA USUARIOS
	declare @CodUsuarioOrigen varchar(15)
	declare @CodUsuarioCalculado varchar(15)
	declare @i tinyint
	declare @CodUsuarioAux varchar(25)
	--declare @FamiliarNegocio varchar(1)
	declare @CodUbiGeo varchar(6)
	declare @CodTipoProDirec varchar(3)
	--declare @EsPrincipal bit
	--declare @TiempoDirDesde smallint
	--declare @TiempoCiudad smallint
	declare @CodTipoProFono varchar(3)
	--declare @Observaciones varchar(250)
	declare @CodLocalidad varchar(15)
	set @CodOficina='98'
	select @FechaProceso = fechaproceso from Finmas.dbo.tclparametros with(nolock) where codoficina = @CodOficina

	set @FamiliarNegocio = 'F'	
	set @CodTipoProDirec = 'PRO'
	set @EsPrincipal = 1
	--set @TiempoDirDesde = 10
	--set @TiempoCiudad = 10
	set @CodTipoProFono = 'PRO'
	--set @Observaciones ='DIRECCION REGISTRADA POR SP' --> se quita porque viene del cliente --> referencias del cliente
	set @CodLocalidad = ''
	
	
	if not exists(select * from tLpCliente where IdProceso = @IdProceso)
		begin
			insert into tLpCliente(IdProceso,APaterno,AMaterno,Nombres,FecNacimiento,CodDocIden,DI,CodEstadoCivil
			,Genero,FamiliarNegocio,Direccion,NumExterno,NumInterno,Ubicacion,CodPostal,localidad,EsPrincipal,TiempoDirDesde,TiempoCiudad,Telefono,Observaciones
			,EstadoNacimiento,CURP,RFC,Celular,LabActividad,Correo,FechaAlta,CodUsAlta,ClaveBancoSTP,CLABE)
			values (@IdProceso,@APaterno,@AMaterno,@Nombres,@FecNacimiento,@CodDocIden,@DI,@CodEstadoCivil
			,@Genero,@FamiliarNegocio,@Direccion,@NumExterno,@NumInterno,@Ubicacion,@CodPostal,@localidad,@EsPrincipal,@TiempoDirDesde,@TiempoCiudad,@Telefono,@Observaciones
			,@UsLugarNac,@UsCURP,@UsRUC,@UsTelefonoMovil,@LabActividad,@correo,getdate(),@CodPromotor,@ClaveBancoSTP,@CLABE)
		end
	else
		begin
			update tLpCliente set
			APaterno=@APaterno,AMaterno=@AMaterno,Nombres=@Nombres,
			FecNacimiento=@FecNacimiento,CodDocIden=@CodDocIden,DI=@DI,
			CodEstadoCivil=@CodEstadoCivil,Genero=@Genero,@FamiliarNegocio=FamiliarNegocio,
			Direccion=@Direccion,NumExterno=@NumExterno,NumInterno=@NumInterno,
			Ubicacion=@Ubicacion,CodPostal=@CodPostal,localidad=@localidad,
			EsPrincipal=@EsPrincipal,TiempoDirDesde=@TiempoDirDesde,TiempoCiudad=@TiempoCiudad,
			Telefono=@Telefono
			,Observaciones=@Observaciones,EstadoNacimiento=@UsLugarNac,
			CURP=@UsCURP,RFC=@UsRUC,Celular=@UsTelefonoMovil,
			LabActividad=@UsTelefonoMovil,Correo=@Correo,
			--FechaAlta,CodUsAlta,
			ClaveBancoSTP=@ClaveBancoSTP,CLABE=@CLABE
			where  IdProceso = @IdProceso
		end

	select IdCliente from tLpCliente where IdProceso = @IdProceso
END
GO