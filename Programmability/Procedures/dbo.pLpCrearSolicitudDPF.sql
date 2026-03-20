SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
create procedure [dbo].[pLpCrearSolicitudDPF] (@idproceso int)
as
BEGIN
set nocount on
	--Ver 12-02-2021
	--Ver 09-03-2021
	
	declare @ShowPrint bit
	declare @ConTransaccion bit
	declare @FechaProceso smalldatetime
	declare @APaterno varchar(30)
	declare @AMaterno varchar(30)
	declare @Nombres  varchar(30)
	declare @FecNacimiento datetime
	declare @Genero varchar(1)
	declare @CodDocIden varchar(10)
	declare @DI varchar(30)
	declare @CodEstadoCivil varchar(1)
	
	declare @CLABE varchar(18)
	declare @ClaveBancoSTP varchar(10)

	set @ShowPrint = 0
	set @ConTransaccion = 1
	
	if @ConTransaccion = 1 BEGIN TRAN
	
	declare @CodOficina varchar(3)
	set @CodOficina='98' -- todas las cuentas remotas deben crearse en la sucursal 98 Corporativo
	declare @CodPromotor varchar(20)
	declare @promotor varchar(20)
	
	-------------------------------
	select @CodPromotor = codpromotor from dbo.tLpSolicitudPromotor as sp with(nolock) 
	inner join tLpProceso as p with(nolock) on sp.idsolicitudpromotor = p.idsolicitudpromotor
	where idproceso = @idproceso
	
	select top 1 @promotor = usuario from 
	--finmas_qa.dbo.tsgusuarios 
	finmas.dbo.tsgusuarios 
	where codusuario like '%' + @CodPromotor
	
	if isnull(@promotor,'') = ''
	begin
		--Promotor Default
		set @CodPromotor='98CSM1803891'	--CodPromotor 98CSM1803891   Miriam Chavez Sanchez
		set @promotor = 'mchavezs'
	end
	
	---------------------------------	
	select 
	--c.IdCliente,c.IdProceso,
	@APaterno = c.APaterno,@AMaterno=c.AMaterno,@Nombres = c.Nombres,
	@FecNacimiento=c.FecNacimiento,
	@CodDocIden=c.CodDocIden,@DI=c.DI,
	@CodEstadoCivil=c.CodEstadoCivil,
	@Genero=c.Genero,
	--c.FamiliarNegocio,c.Direccion,c.NumExterno,c.NumInterno,c.Ubicacion,c.CodPostal,c.localidad,c.EsPrincipal,
	--c.TiempoDirDesde,c.TiempoCiudad,c.Telefono,c.Observaciones,c.EstadoNacimiento,c.CURP,c.RFC,c.Celular,c.LabActividad,
	--c.Correo,c.FechaAlta,c.CodUsAlta,
	@ClaveBancoSTP = c.ClaveBancoSTP,
	@CLABE= c.CLABE
	from tLpCliente as c with(nolock)
	inner join tLpProceso as p with(nolock) on p.idproceso = c.idproceso
	where p.idproceso = @idproceso
	
	--declare @CodBeneficiario varchar(20)
	declare @CodTitular varchar(20)
	--set @CodBeneficiario=''
	set @CodTitular=''
	
	--VARIABLES PARA USUARIOS
	declare @CodUsuarioOrigen varchar(15)
	declare @CodUsuarioCalculado varchar(15)
	declare @i tinyint
	declare @CodUsuarioAux varchar(25)
	-------------------------		
		
	select @FechaProceso = fechaproceso from 
	--finmas_qa.dbo.tclparametros 
	finmas.dbo.tclparametros 
	with(nolock) where codoficina = @CodOficina

--################################################## 1.1.- tususuario (Titular) ###################
	--select * from tususuarios where Paterno = @APaterno and Materno = @AMaterno and Nombres = @Nombres and FechaNacimiento = @FecNacimiento --COMENTAR
	if exists(select * from 
	          --finmas_qa.dbo.tususuarios 
	          finmas.dbo.tususuarios 
	          with(nolock) where Paterno = @APaterno and Materno = @AMaterno and Nombres = @Nombres and FechaNacimiento = @FecNacimiento)
		BEGIN			
			--solo obtiene el codusuario
			select @CodTitular = codusuario from 
			--finmas_qa.dbo.tususuarios 
			finmas.dbo.tususuarios 
			with(nolock) where Paterno = @APaterno and Materno = @AMaterno and Nombres = @Nombres and FechaNacimiento = @FecNacimiento

			if @ShowPrint = 1 print 'Actualiza Usuario Titular'
			update 
			--finmas_qa.dbo.tususuarios 
			finmas.dbo.tususuarios 
			set
			Paterno =@APaterno, 
			Materno =@AMaterno, 
			Nombres =@Nombres, 
			ApeEsposo ='', 
			NombreCompleto = (@APaterno + ' ' + @AMaterno + ' ' + @Nombres),			
			CodDocIden = @CodDocIden, 
			DI = @DI, 
			FechaNacimiento = @FecNacimiento, 
			CodEstadoCivil = @CodEstadoCivil, 
			Sexo = (case @Genero when 'M' then 0 when 'F' then 1 else 0 end ), 
			CodOficina = @CodOficina, 
			FechaIngreso = @FechaProceso, 
			FechaReg = @FechaProceso, 
			CodUsResp = @CodPromotor 
			where CodUsuario = @CodTitular

		END  --if exists(select * from tususuarios with(nolock) where Paterno = @APaterno and Materno = @AMaterno and Nombres = @Nombres and FechaNacimiento = @FecNacimiento)
	else
		BEGIN  --else exists(select * from tususuarios with(nolock) where Paterno = @APaterno and Materno = @AMaterno and Nombres = @Nombres and FechaNacimiento = @FecNacimiento)
			if @ShowPrint = 1 print 'Crea nuevo Usuario Titular'
	
			--Obtiene el nuevo codigo de usuario Titular
			set @CodTitular= ''
			--select @CodUsuarioAux = finmas_qa.dbo.fUsGeneraCodUsuario(@APaterno, @AMaterno, @Nombres, convert(varchar,@FecNacimiento, 112), @Genero, @DI)
			select @CodUsuarioAux = finmas.dbo.fUsGeneraCodUsuario(@APaterno, @AMaterno, @Nombres, convert(varchar,@FecNacimiento, 112), @Genero, @DI)
			--print '-@CodUsuarioAux =' + isnull(@CodUsuarioAux,'')
	
	        set @i = 0
	        set @CodusuarioOrigen = @CodUsuarioAux
	        set @CodusuarioCalculado = @CodusuarioOrigen
	        while exists(select 1 from 
	                     --finmas_qa.dbo.tUsUsuarios 
	                     finmas.dbo.tUsUsuarios
	                     where codusuario = @CodusuarioCalculado)
	        Begin
	            set @i = @i + 1
	            set @CodUsuarioCalculado =  @CodusuarioOrigen + case @i when 0 then '' else cast(@i as char(1)) end
	        End
	        select @CodTitular = @CodUsuarioCalculado

			if @ShowPrint= 1 print '@CodTitular New =' + isnull(@CodTitular,'')
	
			insert into 
			  --finmas_qa.dbo.tususuarios 
			  finmas.dbo.tususuarios 
			                 (CodUsuario, CodTPersona, CodEntidadTipo, Paterno, Materno, Nombres, ApeEsposo, NombreCompleto,
	                                 CodDocIden, DI, FechaNacimiento, CodEstadoCivil, Sexo, CodPais, CodUsConyuge, CodOficina, 
	                                 FechaIngreso, FechaReg, CodUsResp, CodAnterior, CodVIP, IServidor, FirmaHuella, EsNuevaGeneracionCodigo,
	                                 CodUnico, UsRFCBD, UsCURPBD ) 
	                         values (@CodTitular, '01',       'NAT',        @APaterno, @AMaterno, @Nombres, '',   (@APaterno + ' ' + @AMaterno + ' ' + @Nombres),
	                                 @CodDocIden, @DI, @FecNacimiento, @CodEstadoCivil, (case @Genero when 'M' then 1 when 'F' then 0 else 1 end ), '4024', '',  @CodOficina, 
	                                 @FechaProceso, @FechaProceso, @CodPromotor, '',  0,    getdate(),   null,      1,
	                       null,    '', '' )
			
			--Valida que se haya insertado
			IF @@ROWCOUNT = 0
			BEGIN
			   if @ConTransaccion = 1 ROLLBACK TRAN
			   RAISERROR ('No se inserto el usuario: %s   .', 16, -1, @CodTitular)
			   RETURN 1 --DECOMENTAR
			END				

		END
		
	--if @ShowPrint= 1 select 'tususuarios',* from finmas_qa.dbo.tususuarios with(nolock) where CodUsuario = @CodTitular
	if @ShowPrint= 1 select 'tususuarios',* from finmas.dbo.tususuarios with(nolock) where CodUsuario = @CodTitular
--################################### Direccion Titular #######################################	
	declare @CodTipoProDirec varchar(3) 
	declare @EsPrincipal int
	declare @TiempoDirDesde varchar(10) 
	declare @TiempoCiudad  varchar(10)  	
	--declare @FamiliarNegocio varchar(1)
	declare @CodUbiGeo varchar(6)
	--declare @CodTipoProDirec varchar(3)
	--declare @EsPrincipal bit
	--declare @TiempoDirDesde smallint
	--declare @TiempoCiudad smallint
	--declare @CodTipoProFono varchar(3)
	declare @Observaciones varchar(250)
	declare @CodLocalidad varchar(30)
	declare @localidad varchar(30)
	declare @Direccion varchar(30)
	declare @NumExterno varchar(10)
	declare @NumInterior varchar(10)
	declare @Ubicacion  varchar(30)
	declare @CodPostal  varchar(5)
	declare @Telefono varchar(10)
	declare @FamiliarNegocio varchar(1)
	--declare @EsPrincipal int
	declare @CodTipoProFono varchar(3)

	set @Observaciones=''	
	set @FamiliarNegocio = 'F'	
	set @CodTipoProDirec = 'PRO'
	set @EsPrincipal = 1
	set @TiempoDirDesde = 10
	set @TiempoCiudad = 10
	set @CodTipoProFono = 'PRO'
	set @Observaciones ='DIRECCION REGISTRADA POR SP'
	set @CodLocalidad = ''
	
	if @CodTitular = '' 
	begin
		if @ConTransaccion = 1 ROLLBACK TRAN
		RAISERROR ('No se puede actualizar la direccion, no hay Titular: %s   .', 16, -1, @CodTitular)
		return 0
	end
	
	select 
	--c.IdCliente,c.IdProceso,
	--c.FamiliarNegocio,
	@Direccion = c.Direccion,@NumExterno = c.NumExterno,@NumInterior=c.NumInterno,
	@Ubicacion = c.Ubicacion, @CodPostal=c.CodPostal,
	@localidad=c.localidad,
	--,c.EsPrincipal,
	--c.TiempoDirDesde,c.TiempoCiudad,
	@Telefono=c.Telefono,
	@Observaciones = c.Observaciones
	--c.EstadoNacimiento,c.CURP,c.RFC,c.Celular,c.LabActividad,
	--c.Correo,c.FechaAlta,c.CodUsAlta,c.ClaveBancoSTP,c.CLABE
	from tLpCliente as c with(nolock)
	inner join tLpProceso as p with(nolock) on p.idproceso = c.idproceso
	where p.idproceso = @idproceso
					
	set @CodUbiGeo=''

	select @CodUbiGeo=CodUbiGeo
	from 
	--finmas_qa.dbo.tclubigeo 
	finmas.dbo.tclubigeo 
	with(nolock)
	where campo1=@codpostal and descubigeo like '%' + @localidad + '%'
		
	if(@CodUbiGeo='')
	begin
		select @CodUbiGeo=min(CodUbiGeo)
		from 
		--finmas_qa.dbo.tclubigeo 
		finmas.dbo.tclubigeo 
		with(nolock)
		where campo1=@codpostal
	end

	if(isnull(@CodUbiGeo,'')='')
	begin
		set @CodUbiGeo='090028' -- Corporativo
		set @Observaciones='Problema en ubigeo'
	end

	--print '1.1 - tususuariodireccion'
	if not exists(select * from 
	              --finmas_qa.dbo.tususuariodireccion 
	              finmas.dbo.tususuariodireccion 
	              with(nolock) where codusuario = @CodTitular and FamiliarNegocio = @FamiliarNegocio)
		begin
			if @ShowPrint= 1 print 'Nueva Direccion'
			--Inserta la direccion
			insert into 
			      --finmas_qa.dbo.tususuariodireccion 
			      finmas.dbo.tususuariodireccion 
			                         (CodUsuario, FamiliarNegocio, CentroPoblado, CodUbiGeo, Direccion,
											NumExterno, NumInterno, Ubicacion, CodPostal,CodTipoProDirec, EsPrincipal,
											TiempoDirDesde, TiempoCiudad, NomPropietario, Telefono, CodTipoProFono, Observaciones,
                                             CodLocalidad, FechaModificacion )
                                     values (@CodTitular, @FamiliarNegocio, 0, @CodUbiGeo, @Direccion,
                                             @NumExterno, @NumInterior, @Ubicacion, @CodPostal, @CodTipoProDirec, @EsPrincipal,
                                             @TiempoDirDesde, @TiempoCiudad, '', @Telefono, @CodTipoProFono, @Observaciones,
                                             @CodLocalidad, getdate() )
			--select * from tususuariodireccion where codusuario = @CodTitular --COMENTAR
		end
	else
		begin
			if @ShowPrint= 1 print 'Edita Direccion'
		--Actualiza la direccion
			update 
			--finmas_qa.dbo.tususuariodireccion 
			finmas.dbo.tususuariodireccion 
			set
			CodUbiGeo = @CodUbiGeo, 
			Direccion = @Direccion,
			NumExterno = @NumExterno, 
			NumInterno = @NumInterior, 
			Ubicacion = @Ubicacion, 
			CodPostal = @CodPostal,
			CodTipoProDirec = @CodTipoProDirec, 
			EsPrincipal = @EsPrincipal,
			TiempoDirDesde = @TiempoDirDesde, 
			TiempoCiudad = @TiempoCiudad, 
			Telefono = @Telefono, 
			CodTipoProFono = @CodTipoProFono, 
			Observaciones = @Observaciones,
			CodLocalidad  = @CodLocalidad,
			FechaModificacion = getdate()
			where 
			CodUsuario = @CodTitular 
			and FamiliarNegocio = @FamiliarNegocio

		end
		
		--if @ShowPrint= 1 select 'tususuariodireccion', * from finmas_qa.dbo.tususuariodireccion where CodUsuario = @CodTitular and FamiliarNegocio = @FamiliarNegocio
		if @ShowPrint= 1 select 'tususuariodireccion', * from finmas.dbo.tususuariodireccion where CodUsuario = @CodTitular and FamiliarNegocio = @FamiliarNegocio
		
--################################################# Datos Secundarios #######################################		
		if @ShowPrint = 1 print 'Datos secundarios'
		declare @UsLugarNac varchar(10)
		declare @UsCURP varchar(18)
		declare @UsRUC varchar(15)
		declare @UsTelefonoMovil varchar(10) 
		declare @LabActividad varchar(50)
		declare @correo varchar(30)
		
		set @UsLugarNac = ''
		
		select 
		--c.IdCliente,c.IdProceso,
		--c.FamiliarNegocio,
		--@Direccion = c.Direccion,@NumExterno = c.NumExterno,@NumInterior=c.NumInterno,
		--@Ubicacion = c.Ubicacion, @CodPostal=c.CodPostal,
		--@localidad=c.localidad,
		--,c.EsPrincipal,
		--c.TiempoDirDesde,c.TiempoCiudad,
		--@Telefono=c.Telefono,
		--@Observaciones = c.Observaciones		
		--c.EstadoNacimiento,
		@UsCURP = c.CURP, @UsRUC= c.RFC, @UsTelefonoMovil=c.Celular, @LabActividad=c.LabActividad,
		@correo =c.Correo,
		@UsLugarNac = EstadoNacimiento
		--c.FechaAlta,c.CodUsAlta,c.ClaveBancoSTP,c.CLABE
    	from tLpCliente as c with(nolock)
		inner join tLpProceso as p with(nolock) on p.idproceso = c.idproceso
		where p.idproceso = @idproceso
	
		if not exists(select * from 
		              --finmas_qa.dbo.tUsUsuarioSecundarios 
		              finmas.dbo.tUsUsuarioSecundarios 
		              with(nolock) where CodUsuario = @CodTitular)			
			begin
				if @ShowPrint= 1 print 'Inserta Secundarios'
				insert into 
				      --finmas_qa.dbo.tUsUsuarioSecundarios 
				      finmas.dbo.tUsUsuarioSecundarios 
				      (CodUsuario,UsLugarNac, UsCURP, UsRUC, UsTelefonoMovil, LabActividad, UsCorreoE )
         		values (@CodTitular,@UsLugarNac, @UsCURP, @UsRUC, @UsTelefonoMovil, @LabActividad, @correo )
								
				--Valida que se haya insertado
				IF @@ROWCOUNT = 0
				BEGIN
				   if @ConTransaccion = 1 ROLLBACK TRAN
				   RAISERROR ('error al insertar la tUsUsuarioSecundarios de: %s   .', 16, -1, @CodTitular)
				   RETURN 1  --DESCOMENTAR
				END
			end 
		else
			begin
				if @ShowPrint= 1 print 'Actaliza Secundarios'
				update 
				--finmas_qa.dbo.tUsUsuarioSecundarios 
				finmas.dbo.tUsUsuarioSecundarios
				set
				UsLugarNac = @UsLugarNac, 
				UsCURP = @UsCURP, 
				UsRUC = @UsRUC, 
				UsTelefonoMovil = @UsTelefonoMovil, 
				LabActividad = @LabActividad,
				UsCorreoE = @correo
				where 
				CodUsuario = @CodTitular 
			end

		--if @ShowPrint= 1 select 'tUsUsuarioSecundarios', * from finmas_qa.dbo.tUsUsuarioSecundarios where CodUsuario = @CodTitular
		if @ShowPrint= 1 select 'tUsUsuarioSecundarios', * from finmas.dbo.tUsUsuarioSecundarios where CodUsuario = @CodTitular
					
--################################### Solicitud ah #######################################
	if @ShowPrint = 1 print 'Solicitud AH'
	declare @codproducto varchar(3)
	declare @CodSolicitudAH varchar(25)
	declare @CodCuenta varchar(25)
	declare @NombreCuenta varchar(200)
	--declare @vVChCtaFin   int -- contabilidad
	declare @PlazoNominalDPF int
	declare @MontoDPF money
	declare @CodTipoInteres int

	declare @TasaInteres money
	declare @PlazoDias int
	declare @FechaVcmto smalldatetime
	
	set @codproducto = '211'
	
	if not exists(select * from dbo.tLpSolicitud where IdProceso = @idproceso)
	begin
		if @ConTransaccion = 1 ROLLBACK TRAN
	   RAISERROR ('No hay informacion de Solicitud: %s   .', 16, -1, @CodTitular)
	   RETURN 1  --DESCOMENTAR
	end
	
	select @PlazoNominalDPF = Plazo, @MontoDPF = monto, @CodTipoInteres =CodTipoInteres 
	from dbo.tLpSolicitud where IdProceso = @idproceso
	
	--select * from tAhCuenta
	/* Solo se podrá crear una cuenta por cliente de forma remota*/
	if not exists (select * from 
	               --finmas_qa.dbo.tAhSolicitud H 
	               finmas.dbo.tAhSolicitud H 
	               with(nolock) where H.CodUstitular = @CodTitular
				and H.idProducto=@codproducto and H.idEstado = 'SC')
		begin
		    if @ShowPrint = 1 print 'Crea Solicitud AH'
			declare @nombrecodigo_ varchar(20)
			set @nombrecodigo_=''
			set @nombrecodigo_='Solicitud'+@codproducto+'6'
		    --exec finmas_qa.dbo.pGrCodigos
		    exec finmas.dbo.pGrCodigos
		         @oficina      = @CodOficina,
		         @NombreCodigo = @nombrecodigo_,
		         @sistema      = 'AH',
		         @codigo       = @CodSolicitudAH out
		    --select CodSolicitudAH = @CodSolicitudAH --COMENTAR
			if @ShowPrint= 1 print '@CodSolicitudAH = ' + @CodSolicitudAH

			--CALCULA LA TASA
			SELECT @TasaInteres = Tasa FROM 
			--finmas_qa.dbo.tAhTasaInteres 
			finmas.dbo.tAhTasaInteres 
			with(nolock) 
			WHERE idProducto = @codproducto AND CodMoneda = '6'
			AND CodOficina = @CodOficina AND MontoMin <= @MontoDPF AND MontoMax >= @MontoDPF 
			AND PlazoIni <= @PlazoNominalDPF AND PlazoFin >= @PlazoNominalDPF 
			AND CodTipoInteres=1

			set @TasaInteres = isnull(@TasaInteres,0)

			--CALCULA PLAZO NOMINAL
			set @PlazoDias = @PlazoNominalDPF

			--CALCULA FECHA VENCIMIENTO
			set @FechaVcmto= @FechaProceso + @PlazoNominalDPF			
		 
		    INSERT INTO 
		           --finmas_qa.dbo.tAhSolicitud 
		           finmas.dbo.tAhSolicitud 
		           ( NroSolicitud  , idProducto,  CodOficina, CodMoneda, idManejo, idTipoCapi, idDocResp, CodTPersona, CodUsResponsable, CodUsTitular, RUCCuenta  , FechaSolicitud, Observacion, idEstado, idFinLucro, CodDPFRenegociado, EsRenegociado, TasaInteres
                   , PlazoDias, FechaVcmto,  MontoDPF,  CodTipoInteres, IdTipoRenova, PlazoDiasRenov, InteresCapitalizable, PlazoNominalDPF)
		    VALUES (@CodSolicitudAH, @codproducto, @CodOficina, '6'      , '1'     , '0'       , '5'      , '01'     , @CodPromotor    , @CodTitular , @CodTitular, @FechaProceso , 'Cuenta remota', 'SC'    , '1'   ,      '',              '0',       @TasaInteres,
                    @PlazoDias,@FechaVcmto, @MontoDPF, @CodTipoInteres, 1,              0,                  0,             @PlazoNominalDPF)
			--select * from tAhSolicitud where NroSolicitud = @CodSolicitudAH --COMENTAR
			
			--Valida que se haya insertado
			IF @@ROWCOUNT = 0
			BEGIN
			   if @ConTransaccion = 1 ROLLBACK TRAN
			   RAISERROR ('error al insertar tAhSolicitud de: %s   .', 16, -1, @CodTitular)
			   RETURN 1  --DESCOMENTAR
			END
			
           --print '2.2.- tAhUsSolicitud'
		    INSERT INTO 
		          --finmas_qa.dbo.tAhUsSolicitud 
		          finmas.dbo.tAhUsSolicitud 
		           (NroSolicitud   , CodUsSolicitud, Coordinador, CodRelCuenta, CodOficina ,  FechIngreso , RUC , idEstado, Observacion)
		    VALUES (@CodSolicitudAH, @CodTitular   , 1          , '1'         , @CodOficina, @FechaProceso, @CodTitular, 'AC'    , '')
			--select * from tAhUsSolicitud where NroSolicitud = @CodSolicitudAH --COMENTAR
		 
			--Valida que se haya insertado
			IF @@ROWCOUNT = 0
			BEGIN
			   if @ConTransaccion = 1 ROLLBACK TRAN
			   RAISERROR ('error al insertar tAhUsSolicitud de: %s   .', 16, -1, @CodTitular)
			   RETURN 1  --DESCOMENTAR
			END
		end	
	else
	 begin
		if @ShowPrint = 1 print 'Ya existe la Solicitud Ah'
		select @CodSolicitudAH=NroSolicitud  from 
		--finmas_qa.dbo.tAhSolicitud H 
		finmas.dbo.tAhSolicitud H 
		with(nolock) where H.CodUstitular = @CodTitular
				and H.idProducto=@codproducto and H.idEstado = 'SC'
	 end
	 
	 --if @ShowPrint= 1 select 'tAhSolicitud', * from finmas_qa.dbo.tAhSolicitud where NroSolicitud = @CodSolicitudAH
	 --if @ShowPrint= 1 select 'tAhUsSolicitud', * from finmas_qa.dbo.tAhUsSolicitud where NroSolicitud = @CodSolicitudAH	
	 
	 if @ShowPrint= 1 select 'tAhSolicitud', * from finmas.dbo.tAhSolicitud where NroSolicitud = @CodSolicitudAH
	 if @ShowPrint= 1 select 'tAhUsSolicitud', * from finmas.dbo.tAhUsSolicitud where NroSolicitud = @CodSolicitudAH		
--##################### Beneficiario Solicitud	
/*		
			--print '2.3.- tAhBenefSolicitud'
			--Que tenga codigo de beneficiario y que sea diferente al titular
			if (@CodBeneficiario<>'') and (@CodBeneficiario <> @CodTitular )
			begin
				if @BeneCodParentesco = '' set @BeneCodParentesco = 'AMI'

				INSERT INTO finmas_qa.dbo.tAhBenefSolicitud 
					   (NroSolicitud   , CodUsSolicitud, Porcentaje, CodRefRelacion, idEstado, CodCuenta)
				VALUES (@CodSolicitudAH, @CodBeneficiario   , '100'     , @BeneCodParentesco       , 'AC'    , '')
				
				--Valida que se haya insertado
				IF @@ROWCOUNT = 0
				BEGIN
				   if @ConTransaccion = 1 ROLLBACK TRAN
				   RAISERROR ('error al insertar tAhBenefSolicitud de: %s   .', 16, -1, @CodSolicitudAH)
				   RETURN 1  --DESCOMENTAR
				END
		    end
*/

	
--#########################  Regitra en el flujo de ahorro DPF ##########################
		if @ShowPrint = 1 print 'Registra Flujo Solicitud DPF'
		declare @idproce int
		declare @item int
		
		if not exists(select * from 
		--finmas_qa.dbo.tAhSolicitudProce 
		finmas.dbo.tAhSolicitudProce
		where NroSolicitud = @CodSolicitudAH)
		begin			
			select @idproce = isnull(max(IdProceso),0) + 1 from  
			--finmas_qa.dbo.tAhSolicitudProce
			finmas.dbo.tAhSolicitudProce

			insert into 
			--finmas_qa.dbo.tAhSolicitudProce 
			finmas.dbo.tAhSolicitudProce 
			(IdProceso, NroSolicitud, Estado, FechaHora, CodUsuarioMesaRevision, FechaAsignacionUsuarioMesa, IdProducto, CodOficina )
			values (@IdProce, @CodSolicitudAH, 1, getdate(), null, null, @CodProducto, @CodOficina )

			--Valida que se haya insertado
			IF @@ROWCOUNT = 0
			BEGIN
			   if @ConTransaccion = 1 ROLLBACK TRAN
			   RAISERROR ('error al insertar tAhSolicitudProce de: %s   .', 16, -1, @CodSolicitudAH)
			 RETURN 
			END
		end
		else
		begin
			select @IdProce = IdProceso from 
			--finmas_qa.dbo.tAhSolicitudProce 
			finmas.dbo.tAhSolicitudProce 
			where NroSolicitud = @CodSolicitudAH
		end
		
		--========================
		select @item = isnull(max(item),0)+1 from 
		--finmas_qa.dbo.tAhSolicitudProceDet 
		finmas.dbo.tAhSolicitudProceDet 
		where idproceso = @IdProce
		insert into 
		--finmas_qa.dbo.tAhSolicitudProceDet 
		finmas.dbo.tAhSolicitudProceDet
		(IdProceso, Item, Descripcion,Estado, FechaHora, Usuario 
		) values (@IdProce,@item, 'Solicitud Originada desde Landing Page Clientes', 1, getdate(),@Promotor)
			
		--if @ShowPrint= 1 select 'tAhSolicitudProce', * from finmas_qa.dbo.tAhSolicitudProce where NroSolicitud = @CodSolicitudAH
		if @ShowPrint= 1 select 'tAhSolicitudProce', * from finmas.dbo.tAhSolicitudProce where NroSolicitud = @CodSolicitudAH
		
--########################## tAhSolicitudProcedet #######################
	--declare @item int
	--select @item = isnull(max(Item),0) +1 from finmas_qa.dbo.tAhSolicitudProcedet where idproceso =	@IdProce		
	
	--insert into finmas_qa.dbo.tAhSolicitudProcedet (IdProceso,Item, Descripcion,estado, fechahora,usuario)
	--values (@IdProce,@item, 'Registro solicitud desde portal de Promotor',0, getdate(),@promotor)	
	
	--if @ShowPrint= 1 select 'tAhSolicitudProceDet', * from finmas_qa.dbo.tAhSolicitudProcedet where IdProceso = @IdProce	
--##########################	 tAhDocPresenSolicitud' ############################
		if @ShowPrint = 1 print 'DocPresenSolicitud'

		if not exists(select * from 
		             --finmas_qa.dbo.tAhDocPresenSolicitud 
		             finmas.dbo.tAhDocPresenSolicitud
		             where NroSolicitud =@CodSolicitudAH )
		begin
			INSERT INTO 
			       --finmas_qa.dbo.tAhDocPresenSolicitud 
			       finmas.dbo.tAhDocPresenSolicitud 
				   (NroSolicitud   , DocIdentidad, Presento, Observaciones, Archivo)
			VALUES (@CodSolicitudAH, 'CE'        , '1'     , ''           , '1')
	    end
	    
		--if @ShowPrint = 1 select 'tAhDocPresenSolicitud', * from finmas_qa.dbo.tAhDocPresenSolicitud where NroSolicitud = @CodSolicitudAH --COMENTAR
		if @ShowPrint = 1 select 'tAhDocPresenSolicitud', * from finmas.dbo.tAhDocPresenSolicitud where NroSolicitud = @CodSolicitudAH --COMENTAR

--##################### INSERTA DATOS ADICIONALES <<<<<<<<<<<<   
		if @ShowPrint = 1 print 'tUsAhorroDPF'
		if not exists ( select * from 
		--finmas_qa.dbo.tUsAhorroDPF 
		finmas.dbo.tUsAhorroDPF 
		where codusuario = @CodTitular )
		Begin
			if @ShowPrint = 1 print 'Inserta Datos Adicionales'
			insert into 
			--finmas_qa.dbo.tUsAhorroDPF 
			finmas.dbo.tUsAhorroDPF 
			(CodUsuario, FechaAlta, UsuarioAlta)values (@CodTitular, getdate(), @CodPromotor )
		End	
--##################### Informacion Adicional
		if @ShowPrint = 1 print 'Actualiza Datos Adicionales Generales'
		update 
		--finmas_qa.dbo.tUsAhorroDPF 
		finmas.dbo.tUsAhorroDPF 
		set
		IA_PaisNacimiento  = '', --@IA_PaisNacimiento,
		IA_CalidadMigratoria = '',
		IA_TipoRegimenConyugal = '' ,
		IA_GiroNegocioOtros    = '' ,
		IA_CorreoElectronico   = @correo 
		where CodUsuario = @CodTitular

--##################### direccion extranjero
		if @ShowPrint = 1 print 'Actualiza Datos Adicionales Direccion Extranjero'
		update 
		--finmas_qa.dbo.tUsAhorroDPF 
		finmas.dbo.tUsAhorroDPF
		set
		DE_Calle = '',
		DE_NumExt = '',
		DE_NumInt = '',
		DE_EntreCalles   = '',
		DE_CP  = '',
		DE_Colonia    = '',
		DE_Delegacion   = '',
		DE_Ciudad    = '',
		DE_Estado   = '',
		DE_Pais   = ''
		where CodUsuario = @CodTitular

--##################### Propietario Recursos
		if @ShowPrint = 1 print 'Actualiza Datos Adicionales Propietario Recursos'
		update 
		--finmas_qa.dbo.tUsAhorroDPF 
		finmas.dbo.tUsAhorroDPF
		set
		PRO_ApellidoPaterno = '',--@PRO_ApellidoPaterno,
		PRO_ApellidoMaterno = '',--@PRO_ApellidoMaterno,
		PRO_Nombre = '',--@PRO_Nombre,
		PRO_RelacionTitular = '',--@PRO_RelacionTitular,
		PRO_Ocupacion  = '',--@PRO_Ocupacion,    
		PRO_EsPropietario  = 0, -- case when upper(@PRO_EsPropietario) = 'SI' then 1 else 0 end ,
		PRO_EsProveedor  =  0, --case when upper(@PRO_EsProveedor) = 'SI' then 1 else 0 end ,
		PRO_Comentarios  = ''--@PRO_Comentarios    
		where CodUsuario = @CodTitular

--##################### Transaccionalidad
		if @ShowPrint = 1 print 'Actualiza Datos Adicionales Transaccionlidad'
		update 
		--finmas_qa.dbo.tUsAhorroDPF 
		finmas.dbo.tUsAhorroDPF 
		set
		PT_CreditoNumTransaccionesMes = '',
		PT_CreditoMontoOperacionesMes  = '',
		PT_AhorroNumTransaccionesMes = '',
		PT_AhorroMontoOperacionesMes  = ''
		where CodUsuario = @CodTitular

--##################### Procedencia Recursos

		if @ShowPrint = 1 print 'Actualiza Datos Adicionales Procedencia Recursos'
		update 
		--finmas_qa.dbo.tUsAhorroDPF 
		finmas.dbo.tUsAhorroDPF
		set
		PR_AhorroInversion = 0, -- (case when upper(@PR_AhorroInversion) = 'SI' then 1 else 0 end)  ,
		PR_PrestacionServicios  = 0, --  (case when upper(@PR_PrestacionServicios) = 'SI' then 1 else 0 end)  ,
		PR_Prestamo  = 0, --  (case when upper(@PR_Prestamo) = 'SI' then 1 else 0 end) ,
		PR_PremioSorteo  = 0,--  (case when upper(@PR_PremioSorteo) = 'SI' then 1 else 0 end)  ,
		PR_VentaBienes  = 0, -- (case when upper(@PR_VentaBienes) = 'SI' then 1 else 0 end)  ,
		PR_HerenciaDonacion  = 0, -- (case when upper(@PR_HerenciaDonacion) = 'SI' then 1 else 0 end) ,
		PR_Asalariado  = 0, --  (case when upper(@PR_Asalariado) = 'SI' then 1 else 0 end) ,
		PR_NombreEmpresa = '', -- @PR_NombreEmpresa,
		PR_PuestoOcupa  = '', -- @PR_PuestoOcupa,
		PR_Antiguedad  = '', --@PR_Antiguedad,
		PR_Remesa  = 0, -- (case when upper(@PR_Remesa) = 'SI' then 1 else 0 end),
		PR_Otro  = 0, -- (case when upper(@PR_Otro) = 'SI' then 1 else 0 end) ,
		PR_OtroDesc  = '' -- @PR_OtroDesc 
		where CodUsuario = @CodTitular 
		

--########################### PPE  ############################

		if @ShowPrint = 1 print 'Actualiza Datos Adicionales PPE'
		update 
		--finmas_qa.dbo.tUsAhorroDPF 
		finmas.dbo.tUsAhorroDPF
		set
		PPE_EsPersonaExpuesta = 0, --(case when upper(@PPE_EsPersonaExpuesta) = 'SI' then 1 else 0 end) ,
		PPE_CargoPublico = '', -- @PPE_CargoPublico,
		PPE_DependenciaCargo = '', --@PPE_DependenciaCargo,
		PPE_TieneParentesco = 0, -- (case when upper(@PPE_TieneParentesco) = 'SI' then 1 else 0 end)  ,
		PPE_ParienteApePat = '', --@PPE_ParienteApePat,
		PPE_ParienteApeMat = '', --@PPE_ParienteApeMat,
		PPE_ParienteNombres = '', -- @PPE_ParienteNombres,
		PPE_ParienteParentesco = '', -- @PPE_ParienteParentesco,
		PPE_ParienteCargoPublico = '', --@PPE_ParienteCargoPublico,
		PPE_ParienteDependenciaCargo = '' --@PPE_ParienteDependenciaCargo
		where CodUsuario = @CodTitular
		
--########################## Datos adicionales  ##########################
	if @ShowPrint = 1 print 'Actualiza Datos Adicionales Datos Bancarios'
	update 
	--finmas_qa.dbo.tUsAhorroDPF 
	finmas.dbo.tUsAhorroDPF 
	set
	DB_TitularCuenta = '',
	DB_Banco = '',
	DB_Sucursal = '',
	DB_NumCuenta = '',
	DB_CLABE = @CLABE,
	DB_ClaveBancoSTP = @ClaveBancoSTP
	where CodUsuario = @CodTitular
		
	--if @ShowPrint = 1 select 'tUsAhorroDPF', * from finmas_qa.dbo.tUsAhorroDPF where CodUsuario = @CodTitular
	if @ShowPrint = 1 select 'tUsAhorroDPF', * from finmas.dbo.tUsAhorroDPF where CodUsuario = @CodTitular

--##################### Registra Usuario en QuQ  #####################
	if @ShowPrint = 1 print 'Registra QeQ'

	--SE agregan a la consuta QeQ el titular y cotitulara o rep legal
	if not exists(select * from 
	              --finmas_qa.dbo.tUsAhorroQeQ 
	              finmas.dbo.tUsAhorroQeQ 
	              where CodUsuario = @CodTitular and NroSolicitud = @CodSolicitudAH)
	begin
		insert into 
		--finmas_qa.dbo.tUsAhorroQeQ 
		finmas.dbo.tUsAhorroQeQ 
		(CodUsuario, FechaAlta, Consultado, NroSolicitud)
		
		select CodUsSolicitud, getdate(), 0, us.NroSolicitud
		from 
		--finmas_qa.dbo.tAhUsSolicitud 
		finmas.dbo.tAhUsSolicitud 
		as us
		WHERE us.NroSolicitud = @CodSolicitudAH
		--and CodUsSolicitud not in (select CodUsuario from tUsAhorroQeQ where CodUsuario = );

		----Valida que se haya insertado
		IF @@ROWCOUNT = 0
		BEGIN
		   if @ConTransaccion = 1 ROLLBACK TRAN
		   RAISERROR ('error al insertar tUsAhorroQeQ TITULAR de: %s   .', 16, -1, @CodSolicitudAH)
		   RETURN 
		END
	end
		
	--if @ShowPrint = 1 select 'tUsAhorroQeQ', * from finmas_qa.dbo.tUsAhorroQeQ where CodUsuario = @CodTitular and NroSolicitud = @CodSolicitudAH
	if @ShowPrint = 1 select 'tUsAhorroQeQ', * from finmas.dbo.tUsAhorroQeQ where CodUsuario = @CodTitular and NroSolicitud = @CodSolicitudAH
--################################# Registra Imagenes #################################
	declare @IdEvento int
	if not exists(select * from 
	              --finmas_qa.dbo.tahevento 
	              finmas.dbo.tahevento 
	              where CodCuenta = @CodSolicitudAH)
		begin 
			insert into 
			--finmas_qa.dbo.tahevento 
			finmas.dbo.tahevento 
			(CodOficina, CodCuenta,IdTipoEvento, Fecha,Activa, CodUsuarioAlta,FechaAlta,CodUsuarioModificacion, FechaModificacion)
			values ('98', @CodSolicitudAH,1, getdate(),1, @CodPromotor,getdate(),@CodPromotor, getdate())
		end

	select @IdEvento = IdEvento from 
	--finmas_qa.dbo.tahevento 
	finmas.dbo.tahevento 
	where CodCuenta = @CodSolicitudAH

	update 
	--finmas_qa.dbo.taheventoevidencia 
	finmas.dbo.taheventoevidencia 
	set Activa=0 where IdEvento = @IdEvento
	
	--Inserta Iamgenes
	insert into 
	--finmas_qa.dbo.taheventoevidencia 
	finmas.dbo.taheventoevidencia 
	(IdEvento,Descripcion,RutaOriginal,NombreOriginal,RutaDestino,NombreNuevo,IdTipoDocumento, Activa, CodUsuarioAlta,FechaAlta,CodUsuarioModificacion, FechaModificacion,ArchivoWebCopiado, FechaRespaldo,UsuarioAPI)

	select @IdEvento, Descripcion,RutaOriginal,NombreOriginal,'' as RutaDestino, '' as NombreNuevo, IdTipoDocumento, 1, 'yo',getdate(),'yo', getdate(),null, null,null 
	from tLpDocumento where IdProceso = @IdProceso
	
	--if @ShowPrint = 1 select 'taheventoevidencia', * from finmas_qa.dbo.taheventoevidencia where IdEvento = @IdEvento
	if @ShowPrint = 1 select 'taheventoevidencia', * from finmas.dbo.taheventoevidencia where IdEvento = @IdEvento

--######################################################################3
	if @ConTransaccion = 1 COMMIT TRAN
	
	--Regresa datos
	select @CodTitular as 'CodTitular', @CodSolicitudAH as CodSolicitudAH
END
GO