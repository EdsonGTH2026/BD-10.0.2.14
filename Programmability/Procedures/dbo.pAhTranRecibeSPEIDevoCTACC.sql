SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE proc [dbo].[pAhTranRecibeSPEIDevoCTACC](
@IdTransaccion int,
@Estado varchar(20),
@Motivo varchar(50),
@FechaOperacion smalldatetime,
@ClaveRastreo varchar(60)

)
as 
begin 
insert into tAhTranDiariaRecibeSPEIDev(IdTransaccion,
Estado,
Motivo,
FechaOperacion,
ClaveRastreo
 )

values (@IdTransaccion,@Estado,@Motivo,@FechaOperacion,@ClaveRastreo)
END 
GO