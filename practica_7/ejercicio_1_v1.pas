{ Una productora nacional realiza un casting de personas para la selecciÃ³n de actores extras de una
nueva pelÃ­cula, para ello se debe leer y almacenar la informaciÃ³n de las personas que desean
participar de dicho casting. De cada persona se lee: DNI, apellido y nombre, edad y el cÃ³digo de
gÃ©nero de actuaciÃ³n que prefiere (1: drama, 2: romÃ¡ntico, 3: acciÃ³n, 4: suspenso, 5: terror). La lectura
finaliza cuando llega una persona con DNI 33555444, la cual debe procesarse.
Una vez finalizada la lectura de todas las personas, se pide:
a. Informar la cantidad de personas cuyo DNI contiene mÃ¡s dÃ­gitos pares que impares.
b. Informar los dos cÃ³digos de gÃ©nero mÃ¡s elegidos.
c. Realizar un mÃ³dulo que reciba un DNI, lo busque y lo elimine de la estructura. El DNI puede no
existir. Invocar dicho mÃ³dulo en el programa principal.}
program ejerciciouno;
const
 df = 5;
type
 rango = 1..df;
 t_persona = record
  dni:integer;
  apellido:string;
  nombre:string;
  edad:integer;
  codigo_genero:rango;
 end;
 t_lista = ^nodo;
 nodo = record
  dato:t_persona;
  sig: t_lista
 end;
 vector_contador = array [rango]  of integer;

procedure leerpersona(var persona:t_persona);
begin
 writeln('ingrese el dni de la persona');
 readln(persona.dni);
 writeln('ingrese el apellido de la persona');
 readln(persona.apellido);
 writeln('ingrese el nombre de la persona');
 readln(persona.nombre); 
 writeln('ingrese la edad de la persona');
 readln(persona.edad);
 writeln('ingrese el codigo de la persona');
 readln(persona.codigo_genero);
end;

procedure agregarAdelante (var lista: t_lista; persona: t_persona);
var 
 nuevo: t_lista;
begin 
 new(nuevo);
 nuevo^.dato:= persona;
 nuevo^.sig:= lista;
 lista:= nuevo;
end;

procedure cargarlista(var lista: t_lista);
var 
 persona: t_persona;
begin 
 repeat
  leerpersona(persona);
  agregarAdelante(lista,persona);
 until (persona.dni = 33555444)
end;

procedure inicializarVector(var vector: vector_contador);
var
 indice: integer;
begin
 for indice:= 1 to df do begin 
  vector[indice]:= 0;
 end;
end;

function validar_pares (dni:integer): boolean;
var 
 digito,digitospar,digitosimpar:integer;
begin
 digitosimpar:=0;
 digitospar:=0;
 while(dni<>0) do begin 
  digito:= dni mod 10; // me quedo con el ultimo digito.
  if ((digito mod 2)= 0) then 
   digitospar:= digitospar + 1
  else
   digitosimpar:= digitosimpar+1;
  dni:= dni div 10; // quito el ultimo digito
 end;
 validar_pares := (digitospar > digitosimpar);
end;

procedure informarmaximos (vector: vector_contador);
var 
 indice,maximo1,maximo2,codigo1,codigo2:integer;
begin
 maximo1:=-9999;
 maximo2:=-9999;
 codigo1:=0;
 for indice:= 1 to df do begin
  if (vector[indice] > maximo1) then begin
   maximo2:= maximo1;
   codigo2:= codigo1;
   maximo1:= vector[indice];
   codigo1:= indice;
  end
  else
   if (vector[indice] > maximo2) then begin
    maximo2:= vector[indice];
    codigo2:= indice;
   end;
 end;
 writeln('los dos codigos de genero mas elegidos son: ',codigo1, 'y ', codigo2);
end;

procedure recorrer_y_calcular(lista: t_lista; vector: vector_contador);
var 
 mas_pares,genero: integer;
begin
 mas_pares:=0;
 while(lista<>nil) do begin 
  if (validar_pares(lista^.dato.dni)) then 
   mas_pares:= mas_pares + 1;
  genero:= lista^.dato.codigo_genero;
  vector[genero]:= vector[genero] + 1;
  lista:= lista^.sig;
 end;
 informarmaximos(vector);
 writeln('la cantidad de personas con dni con mas digitos pares que impares es: ', mas_pares);
end;

procedure eliminar (var lista: t_lista; dni:integer);
var 
 actual,anterior: t_lista;
begin
 if (lista <> nil) then begin
  actual:= lista;
  anterior:= lista;
  while(actual <> nil) and (actual^.dato.dni <> dni) do begin
   anterior:= actual;
   actual:= actual^.sig;
  end;
  if(actual <> nil) then begin // si actual es distinto a nil es porque el dni lo encontro en la lista.
   if(lista=actual) then 
    lista:=lista^.sig
   else
    anterior^.sig:= actual^.sig;
   dispose(actual);
  end
  else
   writeln('no se encontro el dni: ',dni);
 end
 else 
  writeln('la lista esta vacia');
end;

VAR 
 lista: t_lista;
 vector: vector_contador;
 dni: integer;
begin
 lista:= nil;
 cargarlista(lista);
 inicializarVector(vector);
 recorrer_y_calcular(lista,vector);
 writeln('ingrese un dni para eliminar de la lista');
 readln(dni);
 eliminar(lista,dni);
end.