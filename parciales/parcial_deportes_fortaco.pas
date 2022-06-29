{El centro de deportes Fortaco quiere la info de los 4 tipos de suscripciones que ofrece: 
1)Musculacion 2)Spinning 3)CrossFit 4)Todas las clases. Para ello, el centro dispone 
de una tabla con informacion sobre el costo mensual de cada tipo de suscripcion.
Realizar un programa que lea y almacene la informacion de los clientes del centro. De cada cliente se 
conoce el nombre, dni, edad y tipo de suscripcion contratada (valor entre 1 y 4). Cada cliente tiene
una sola suscripcion. La lectura finaliza cuando se lee el cliente con dni 0, el cual no debe procesarse.
Una vez almacenados todos los datos, procesar la estructura de datos generada, calcular e informar:
A) La ganancia total de Fortaco.
B) El nombre y dni de los clientes de mas de 40 años que estan suscriptos a CrossFit o a todas las clases}
program fortaco;
const 
 dimF = 4;
type 
 t_subrango= 1..dimF;
 
 t_cliente = record
  nombre: string;
  dni: integer;
  edad: integer;
  tipo_suscripcion: t_subrango;
 end;

 t_vector = array [t_subrango] of real;
 
 t_lista = ^t_nodo_cliente;
 t_nodo_cliente = record 
  dato: t_cliente;
  siguiente: t_lista;
 end;

procedure leer(var cliente: t_cliente);
begin 
  writeln('ingrese el dni');
  readln(cliente.dni);
  if (cliente.dni <> 0) then begin  
    writeln('ingrese el nombre');
    readln(cliente.nombre);
    writeln('ingrese la edad');
    readln(cliente.edad);
    writeln('ingrese el tipo de suscripcion');
    readln(cliente.tipo_suscripcion);
  end;
end;

procedure insertar_adelante(var lista:t_lista; cliente: t_cliente);
var 
 nuevo: t_lista;
begin
 new(nuevo);
 nuevo^.dato:= cliente;
 nuevo^.siguiente:= lista;
 lista:= nuevo;
end;

procedure cargar_lista(var lista: t_lista);
var 
 cliente: t_cliente;
begin
 leer(cliente);
 while(cliente.dni <> 0) do begin 
  insertar_adelante(lista, cliente);
  leer(cliente);
 end;
end;

procedure clientes_40(nombre: string; edad, dni, tipo_suscripcion: integer);
begin
  if (edad > 40) then begin
   if (tipo_suscripcion = 3) or (tipo_suscripcion = 4) then begin
    writeln(nombre);
    writeln(dni);
   end;
  end;
end;

procedure calcular(lista: t_lista; vector: t_vector);
var 
 ganancia_total: real;
 tipo: integer;
begin
 ganancia_total:=0;
 while(lista <> nil) do begin 
  tipo:= lista^.dato.tipo_suscripcion; 
  ganancia_total:= ganancia_total + vector[tipo];
  clientes_40(lista^.dato.nombre, lista^.dato.edad, lista^.dato.dni, tipo);
  lista:= lista^.siguiente;
 end;
 writeln('La ganancia total del centro de deportes es:', ganancia_total);
end;
VAR
 lista: t_lista;
 vector: t_vector;
BEGIN
 lista:= nil;
 cargarvector(vector);// ya se dispone
 cargar_lista(lista);
 calcular(lista, vector);
END.
 
 
 