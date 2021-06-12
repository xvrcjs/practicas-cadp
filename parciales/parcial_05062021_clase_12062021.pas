program parcial;
const limite = 1200;
type
    t_codigo_vuelo = 1..limite;

    t_ticket = record
        codigo_vuelo: t_codigo_vuelo;
        dni: integer;
        pais_origen: string;
        pais_destino: string;
        valor_ticket: real;
    end;

    t_lista_ticket = ^t_nodo_ticket;
    
    t_nodo_ticket = record
        dato: t_ticket;
        siguiente: t_lista_ticket;
    end;

    t_vector_contador_vuelos = array [t_codigo_vuelo] of integer;

procedure leerTicket(var ticket: t_ticket);
begin
    writeln('Ingrese el código de vuelo: ');
    readln(ticket.codigo_vuelo);
    writeln('Ingrese el dni: ');
    readln(ticket.dni);
    writeln('Ingrese el pais de origen: ');
    readln(ticket.pais_origen);
    writeln('Ingrese el pais de destino: ');
    readln(ticket.pais_destino);
    writeln('Ingrese el valor de ticket: ');
    readln(ticket.valor_ticket);
end;
procedure insertarOrdenado(var lista: t_lista_ticket; dato: t_ticket);
var
	nuevo, actual, anterior: t_lista_ticket;
begin
	new(nuevo);
	nuevo^.dato:= dato;
	nuevo^.siguiente:= nil;

	anterior:= lista;
	actual:= lista;

	while ((actual <> nil) and (actual^.dato.dni < dato.dni)) do begin
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

procedure cargarListaTicket(var lista: t_lista_ticket);
var
    ticket: t_ticket;
begin
    leerTicket(ticket);
    while (ticket.dni <> 0) do begin
        insertarOrdenado(lista, ticket);
        leerTicket(ticket);
    end;
end;

function obtenerVuelosAlMismoPais(vector_contador: t_vector_contador_vuelos): integer;
var
    indice: integer;
    cantidad: integer;
begin
    cantidad:= 0;
    for indice := 1 to limite do
    begin
        if vector_contador[indice] > 50  then
            cantidad:= cantidad + 1;
    end;
    obtenerVuelosAlMismoPais:= cantidad;
end;
procedure inicializarVectorContador(var vector_contador: t_vector_contador_vuelos);
var
    indice: integer;
begin
    for indice := 1 to limite do
        vector_contador[indice]:= 0;
end;

function validarDni(dni: integer): boolean;
var
    digito: integer;
begin
    while (dni <> 0) do begin
        digito:= dni MOD 10;
        dni:= dni DIV 10;
    end;
    if ((digito = 0) OR (digito = 5)) then
        validarDni:= true
    else
        validarDni:= false;
end;

VAR
    lista, lista_auxiliar: t_lista_ticket;
    dni_auxiliar: integer;
    dni_gasto_en_ticket_max: integer;
    gasto_en_ticket: real;
    gasto_en_ticket_max: real;
    vuelos_mismo_pais: integer;
    contador_terminacion_dni: integer;
    vector_contador: t_vector_contador_vuelos;
BEGIN
    lista:= nil;
    cargarListaTicket(lista); //Se dispone de la información 
    lista_auxiliar:= lista; //salvamos la lista original para no perder la referencia

    inicializarVectorContador(vector_contador);
    vuelos_mismo_pais:= 0;
    gasto_en_ticket_max:= -1;
    dni_gasto_en_ticket_max:= -1;
    contador_terminacion_dni:= 0;

    while (lista_auxiliar <> nil) do begin
        dni_auxiliar:= lista_auxiliar^.dato.dni;

        gasto_en_ticket:= 0;

        while ((lista_auxiliar <> nil) and (lista_auxiliar^.dato.dni = dni_auxiliar)) do begin
            gasto_en_ticket:= gasto_en_ticket + lista_auxiliar^.dato.valor_ticket;

            if (lista_auxiliar^.dato.pais_origen = lista_auxiliar^.dato.pais_destino) then
                vector_contador[lista_auxiliar^.dato.codigo_vuelo]:= vector_contador[lista_auxiliar^.dato.codigo_vuelo] + 1;      
            
            lista_auxiliar:= lista_auxiliar^.siguiente;     
        end;

        if (validarDni(dni_auxiliar)) then
            contador_terminacion_dni:= contador_terminacion_dni + 1;
            
        if (gasto_en_ticket > gasto_en_ticket_max) then begin
            dni_gasto_en_ticket_max:= dni_auxiliar;
            gasto_en_ticket_max:= gasto_en_ticket;
        end;
    end;

    vuelos_mismo_pais:= obtenerVuelosAlMismoPais(vector_contador);

    writeln('La cantidad de vuelos al mismo pais de origen es: ', vuelos_mismo_pais);

    writeln('El dni del cliente que más dinero gastó es: ', dni_gasto_en_ticket_max);

    writeln('La cantidad de clientes de cuyo dni terminan en 2 o en 3 es: ', contador_terminacion_dni);
END.