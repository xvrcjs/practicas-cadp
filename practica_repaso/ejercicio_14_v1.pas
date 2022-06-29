{
    La biblioteca de la Universidad Nacional de La Plata necesita un programa para administrar
información de préstamos de libros efectuados en marzo de 2020. Para ello, se debe leer la información
de los préstamos realizados. De cada préstamo se lee: nro. de préstamo, ISBN del libro prestado, nro. de
socio al que se prestó el libro, día del préstamo (1..31). La información de los préstamos se lee de manera
ordenada por ISBN y finaliza cuando se ingresa el ISBN -1 (que no debe procesarse).
Se pide:
A) Generar una estructura que contenga, para cada ISBN de libro, la cantidad de veces que fue prestado.
Esta estructura debe quedar ordenada por ISBN de libro.
B) Calcular e informar el día del mes en que se realizaron menos préstamos.
C) Calcular e informar el porcentaje de préstamos que poseen nro. de préstamo impar y nro. de socio
par.
}

program biblioteca;
type
    t_subrango = 1..31;

    t_prestamo = record
        numero: integer;
        isbn: integer;
        numero_socio: integer;
        dia_prestamo: t_subrango;
    end;

    t_lista = ^t_nodo;

    t_nodo = record
        dato: t_prestamo;
        siguiente: t_lista;
    end;

    t_isbn = record
        isbn: integer;
        cantidad: integer;
    end;

    t_lista_isbn = ^t_nodo_isbn;

    t_nodo_isbn = record
        dato: t_isbn;
        siguiente: t_lista_isbn;
    end;

//Procesos

procedure leer_prestamo(var prestamo: t_prestamo);
begin
    with prestamo  do begin
        writeln('ingrese el isbn del libro');
        readln(prestamo.isbn);
        if (prestamo.isbn <> -1 ) then begin
            writeln('ingrese el numero de prestamo');
            readln(prestamo.numero);
            writeln('ingrese el numero de socio');
            readln(prestamo.numero_socio); 
            writeln('ingrese dia del prestamo (1..31)');
            readln(prestamo.dia_prestamo);
        end;
    end;
end;

procedure agregar_adelante (var lista_prestamo: t_lista; prestamo: t_prestamo);
var 
  nuevo: t_lista;
begin 
  new(nuevo);
  nuevo^.dato:= prestamo;
  nuevo^.siguiente:= lista;
  lista:= nuevo;
end;

procedure cargar_lista_prestamos(var lista_prestamo: t_lista);
var
    prestamo: t_prestamo;
begin
    leer_prestamo(prestamo);
    while (prestamo.isbn <> -1) do begin
        agregar_adelante(lista_prestamo, prestamo);
        leer_prestamo(prestamo);
    end;
end;

procedure insertar_ordenado(var lista_isbn: t_lista_isbn; dato: t_isbn);
var
	nuevo, actual, anterior: t_lista_isbn;
begin
	new(nuevo);
	nuevo^.dato:= dato;
	nuevo^.siguiente:= nil;

	anterior:= lista;
	actual:= lista;

	while ((actual <> nil) and (actual^.dato.isbn < dato.isbn)) do begin
		anterior:= actual;
		actual:= actual^.siguiente;
	end;

	if (lista = actual) then begin
		nuevo^.siguiente:= lista;
		lista:= nuevo;
	end
	else begin
		anterior^.siguiente:= nuevo;
		nuevo^.siguiente:= actual;
	end;
end;

var //Programa Principal
    lista_isbn: t_lista_isbn;
    lista_prestamo: t_lista;
begin
    lista_prestamo:= nil;
    lista_isbn:= nil;
    cargar_lista_prestamos(lista_prestamo);

    
end.