{Una remiseria dispone de informacion acerca de los viajes realizados durante el mes de mayo de
2020. De cada viaje se conoce: numero de viaje, codigo de auto, direccion de origen, direccion de
destino y kilometros recorridos durante el viaje. Esta informacion se encuentra ordenada por codigo
de auto y para un mismo codigo de auto pueden existir 1 o mas viajes. Se pide:
a. Informar los dos codigos de auto que mas kilometros recorrieron.
b. Generar una lista nueva con los viajes de mas de 5 kilometros recorridos, ordenada por numero
de viaje}
program ejerciciotres;
type
 t_viaje = record 
  numero_viaje: integer;
  codigo_auto: integer;
  direccion_origen: integer;
  direccion_destino: integer;
  kilometros: real;
 end;
 t_lista = ^nodo;
 nodo = record
  dato: t_viaje;
  siguiente: t_lista;
 end;
procedure agregarOrdenado(dato: t_viaje; var lista2: t_lista);
var
 nuevo,actual,anterior: t_lista;
begin
 new(nuevo);
 nuevo^.dato:= dato;  
 anterior:= lista2;
 actual:= lista2;
 while(actual<>nil) and (actual^.dato.numero_viaje < dato.numero_viaje) do begin
  anterior:= actual;
  actual:= actual^.siguiente;
 end;
 if (lista2=actual) then begin
  lista2:=nuevo;                  
 end
 else begin
  anterior^.siguiente:=nuevo;
  nuevo^.siguiente:= actual;
 end;
end;
  
procedure recorrer (lista: t_lista; var lista2: t_lista);
var
 contarKilometros, maximo1,maximo2: real; 
 codigoAuto,codigo1, codigo2: integer;
begin
 maximo1:= -1;
 maximo2:= -1;
 codigo1:= 0;
 while (lista<>nil) do begin
  contarKilometros:= 0;
  codigoAuto:= lista^.dato.codigo_auto;
  while (lista<>nil) and (lista^.dato.codigo_auto = codigoAuto) do begin
   contarKilometros:= contarKilometros + lista^.dato.kilometros;
   if (lista^.dato.kilometros > 5) then
    agregarOrdenado(lista^.dato,lista2);
   lista:= lista^.siguiente;
  end;
  if (contarKilometros > maximo1) then begin
   maximo2:= maximo1;
   codigo2:= codigo1;
   maximo1:= contarKilometros;
   codigo1:= codigoAuto;
  end
  else
   if(contarKilometros > maximo2) then begin
    maximo2:= contarKilometros;
    codigo2:= codigoAuto;
   end;
 end;
 writeln('los dos codigos de los autos que mas kilometros recorieron son: ',codigo1,codigo2);
end;

VAR 
 lista,lista2: t_lista;
BEGIN  
 lista:=nil;
 lista2:=nil;
 cargarLista(lista);//se dispone
 recorrer(lista,lista2);
end.