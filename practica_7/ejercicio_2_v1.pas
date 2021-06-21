{Implementar un programa que lea y almacene informacion de clientes de una empresa aseguradora
automotriz. De cada cliente se lee: codigo de cliente, DNI, apellido, nombre, codigo de poliza
contratada (1..6) y monto basico que abona mensualmente. La lectura finaliza cuando llega el cliente
con codigo 1122, el cual debe procesarse.
La empresa dispone de una tabla donde guarda un valor que representa un monto adicional que el
cliente debe abonar en la liquidacion mensual de su seguro, de acuerdo al codigo de poliza que tiene
contratada.
Una vez finalizada la lectura de todos los clientes, se pide:
a. Informar para cada cliente DNI, apellido, nombre y el monto completo que paga mensualmente
por su seguro automotriz (monto basico + monto adicional).
b. Informar apellido y nombre de aquellos clientes cuyo DNI contiene al menos dos digitos 9.
c. Realizar un modulo que reciba un codigo de cliente, lo busque (seguro existe) y lo elimine de la
estructura.}
program ejercicioDos;
const 
 dimf = 6;
type
 rango = 1..dimf;
 t_cliente = record
  codigo: integer;
  dni: integer;
  apellido: string;
  nombre: string;
  codigo_poliza: rango;
  monto_mensual: real;
 end;
 t_lista =^nodo;
 nodo = record
  dato: t_cliente;
  sig: t_lista;
 end;
 vector_monto_adicional = array [rango] of real;

procedure leerCliente(var cliente:t_cliente);
begin
 writeln('ingrese el codigo');
 readln(cliente.codigo);
 writeln('ingrese el dni');
 readln(cliente.dni);
 writeln('ingrese el apellido');
 readln(cliente.apellido);
 writeln('ingrese el nombre');
 readln(cliente.nombre); 
 writeln('ingrese el codigo de poliza');
 readln(cliente.codigo_poliza);
 writeln('ingrese el monto mensual');
 readln(cliente.monto_mensual);
end;

procedure agregarAdelante(var lista: t_lista; cliente: t_cliente);
var 
 nuevo: t_lista;
begin
 new(nuevo);
 nuevo^.dato:=cliente;
 nuevo^.sig:= lista;
 lista:= nuevo;
end;

procedure cargarLista (var lista: t_lista);
var 
 cliente: t_cliente;
begin 
 repeat
  leerCliente(cliente);
  agregarAdelante(lista,cliente);
 until (cliente.codigo = 1122)
end;

function validar_digitos(dni:integer): boolean;
var 
 contar_digito,digito: integer;
begin
 contar_digito:=0;
 while(dni <> 0)and(contar_digito <= 2) do begin
  digito:= dni mod 10;
  if (digito=9) then
   contar_digito:= contar_digito + 1;
  dni:= dni div 10;
 end;
 validar_digitos:=(contar_digito >= 2);
end;

procedure informarAyB (dato: t_cliente; monto_total: real);
begin
 writeln('El cliente ', dato.nombre, ' ', dato.apellido, ' con DNI ', dato.dni, ' paga un total de $', monto_total);
 if (validar_digitos(dato.dni)) then
  writeln('Y su DNI contiene al menos dos digitos 9');
end;

procedure recorrer_y_calcular (lista: t_lista; vector: vector_monto_adicional);
var 
 poliza:integer;
 montoMensual, monto_total: real;
begin
 while(lista <> nil) do begin
  poliza:= lista^.dato.codigo_poliza;
  montoMensual:= lista^.dato.monto_mensual;
  monto_total:= montoMensual + vector[poliza];
  informarAyB(lista^.dato,monto_total);
  lista:= lista^.sig;
 end;
end;

procedure eliminar (var lista: t_lista; codigo: integer);
var 
 actual, anterior: t_lista;
begin
 if (lista<>nil) then begin
  actual:= lista;
  while(actual <> nil) and (actual^.dato.codigo <> codigo) do begin
   anterior:= actual;
   actual:= actual^.sig;
  end;
  if (actual = lista) then 
   lista:= actual^.sig
  else
   anterior^.sig:= actual^.sig;
  dispose(actual);
 end
 else
  writeln('la lista esta vacia');
end;

VAR 
 lista: t_lista;
 vector: vector_monto_adicional;
 codigo: integer;
BEGIN 
 lista:= nil;
 cargarLista(lista);
 cargarVector(vector); // se dispone
 recorrer_y_calcular(lista, vector);
 writeln('ingrese el codigo a eliminar');
 readln(codigo);
 eliminar(lista,codigo);
end.