{ Una productora nacional realiza un casting de personas para la selecciÃ³n de actores extras de una
nueva pelÃ­cula, para ello se debe leer y almacenar la informaciÃ³n de las personas que desean
participar de dicho casting. De cada persona se lee: DNI, apellido y nombre, edad y el cÃ³digo de
gÃ©nero de actuaciÃ³n que prefiere (1: drama, 2: romÃ¡ntico, 3: acciÃ³n, 4: suspenso, 5: terror). La lectura
finaliza cuando llega una persona con DNI 33555444, la cual debe procesarse.
Una vez finalizada la lectura de todas las personas, se pide:
a. Informar la cantidad de personas cuyo DNI contiene mÃ¡s dÃ­gitos pares que impares.
b. Informar los dos cÃ³digos de gÃ©nero mÃ¡s elegidos.
c.  Realizar un mÃ³dulo que reciba un DNI, lo busque y lo elimine de la estructura. El DNI puede no
existir. Invocar dicho mÃ³dulo en el programa principal.}
program ejerciciouno;
const
  LIMITE = 5;
  DNI_CORTE = 33555444;
type
  t_rango = 1..LIMITE;
  t_persona = record
    dni: integer;
    apellido: string;
    nombre: string;
    edad: integer;
    codigo_genero: t_rango;
  end;
  t_lista = ^t_nodo;
  t_nodo = record
    dato: t_persona;
    siguiente: t_lista
  end;

  t_vector_contador = array [t_rango]  of integer;

procedure leer_persona(var persona: t_persona);
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

procedure agregar_adelante (var lista: t_lista; persona: t_persona);
var 
  nuevo: t_lista;
begin 
  new(nuevo);
  nuevo^.dato:= persona;
  nuevo^.siguiente:= lista;
  lista:= nuevo;
end;

procedure cargar_lista(var lista: t_lista);
var 
  persona: t_persona;
begin 
  repeat
    leer_persona(persona);
    agregar_adelante(lista,persona);
  until (persona.dni = DNI_CORTE)
end;

procedure inicializar_vector(var vector: t_vector_contador);
var
  indice: integer;
begin
  for indice:= 1 to LIMITE do begin 
    vector[indice]:= 0;
  end;
end;

function validar_pares (dni: integer): boolean;
var 
  digito, digitos_par, digitos_impar: integer;
begin
  digitos_impar:= 0;
  digitos_par:= 0;
  while(dni <> 0) do begin 
    digito:= dni mod 10; // me quedo con el ultimo digito.
    if ((digito mod 2) = 0) then 
      digitos_par:= digitos_par + 1
    else
      digitos_impar:= digitos_impar+1;
    dni:= dni div 10; // quito el ultimo digito
  end;
  validar_pares:= (digitos_par > digitos_impar);
end;

procedure informar_maximos (vector: t_vector_contador);
var 
 indice, maximo_1, maximo_2, codigo_1, codigo_2: integer;
begin
  maximo_1:= -9999;
  maximo_2:= -9999;
  codigo_1:= 0;
  for indice:= 1 to LIMITE do begin
    if (vector[indice] > maximo_1) then begin
      maximo_2:= maximo_1;
      codigo_2:= codigo_1;
      maximo_1:= vector[indice];
      codigo_1:= indice;
    end
    else begin
      if (vector[indice] > maximo_2) then begin
        maximo_2:= vector[indice];
        codigo_2:= indice;
      end;
    end;
 end;
  writeln('Los dos codigos de genero mas elegidos son: ',codigo_1, ' y ', codigo_2);
end;

procedure recorrer_y_calcular(lista: t_lista; vector: t_vector_contador);
var 
  mas_pares, genero: integer;
begin
  mas_pares:=0;
  while(lista<>nil) do begin 
    if (validar_pares(lista^.dato.dni)) then 
      mas_pares:= mas_pares + 1;
    genero:= lista^.dato.codigo_genero;
    vector[genero]:= vector[genero] + 1;
    lista:= lista^.siguiente;
  end;
  informar_maximos(vector);
  writeln('la cantidad de personas con dni con mas digitos pares que impares es: ', mas_pares);
end;

procedure eliminar (var lista: t_lista; dni: integer);
var 
  actual, anterior: t_lista;
begin
  if (lista <> nil) then begin
    actual:= lista;
    anterior:= lista;

    while(actual <> nil) and (actual^.dato.dni <> dni) do begin
      anterior:= actual;
      actual:= actual^.siguiente;
    end;

    if (actual <> nil) then begin // si actual es distinto a nil es porque el dni lo encontro en la lista.
      if (lista = actual) then 
        lista:= lista^.siguiente
      else
        anterior^.siguiente:= actual^.siguiente;

      dispose(actual);
    end
    else
      writeln('No se encontro el dni: ', dni);
  end
  else
    writeln('La lista esta vacia');
end;

VAR 
  lista: t_lista;
  vector: t_vector_contador;
  dni: integer;
begin
  lista:= nil;
  cargar_lista(lista);
  inicializar_vector(vector);
  recorrer_y_calcular(lista,vector);
  writeln('Ingrese un dni para eliminar de la lista');
  readln(dni);
  eliminar(lista, dni);
end.