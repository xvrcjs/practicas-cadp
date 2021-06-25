{
    Una empresa de transporte de cargas dispone de la información de su flota compuesta por 100
camiones. De cada camión se tiene: patente, año de fabricación y capacidad (peso máximo en
toneladas que puede transportar).

Realizar un programa que lea y almacene la información de los viajes realizados por la empresa. De
cada viaje se lee: código de viaje, código del camión que lo realizó (1..100), distancia en kilómetros
recorrida, ciudad de destino, año en que se realizó el viaje y DNI del chofer. La lectura finaliza cuando
se lee el código de viaje -1.
    Una vez leída y almacenada la información, se pide:
        1. Informar la patente del camión que más kilómetros recorridos posee y la patente del camión que 
        menos kilómetros recorridos posee.
        2. Informar la cantidad de viajes que se han realizado en camiones con capacidad mayor a 30,5 toneladas
        y que posean una antigüedad mayor a 5 años al momento de realizar el viaje (año en que se realizó el viaje).
        3. Informar los códigos de los viajes realizados por choferes cuyo DNI tenga sólo dígitos impares.
        Nota: Los códigos de viaje no se repiten.
}
program ejercicio_5_v1;
const
    CODIGO_CORTE = -1;
    LIMITE = 100;
type
    t_subrango = 1..LIMITE;

    t_camion = record
        patente: string;
        anio_fabricacion: integer;
        capacidad: real;
    end;

    t_vector_camion = array [t_subrango] of t_camion;
    t_vector_acumulador = array[t_subrango] of real;

    t_viaje = record
        codigo_viaje: integer;
        codigo_camion = t_subrango;
        kilometros_recorridos: real;
        ciudad_destino: string;
        anio_viaje: integer;
        dni_chofer: integer;
    end;

    t_lista_viaje = ^t_nodo_viaje;
    
    t_nodo_viaje = record
        dato: t_viaje;
        siguiente: t_lista_viaje;
    end;

// procedure cargar_vector_camiones(var vector: t_vector_camion); // Se dispone

procedure agregar_al_principio(var lista: t_lista_viaje; dato: t_viaje);
var
    nuevo: t_lista_viaje;
begin
    new(nuevo);
    nuevo^.dato:= dato;
    nuevo^.siguiente:= lista;
    lista:= nuevo;
end;

procedure leer_viaje(var viaje: t_viaje);
begin
    with viaje  do begin
        writeln('Ingrese el código del viaje');
        readln(codigo_viaje);
        if (codigo_viaje <> CODIGO_CORTE) then begin
            writeln('Ingrese el código del camión');
            readln(codigo_camion);
            writeln('Ingrese los kilometros recorridos');
            readln(kilometros_recorridos);
            writeln('Ingrese el nombre de la ciudad de destino');
            readln(ciudad_destino);
            writeln('Ingrese el año de viaje');
            readln(anio_viaje);
            writeln('Ingrese el dni del chofer');
            readln(dni_chofer);
        end;
    end;
end;

procedure cargar_viajes(var lista: t_lista_viaje);
var
    viaje: t_viaje;
begin
    leer_viaje(viaje);
    while (viaje.codigo_viaje <> CODIGO_CORTE) do begin
        agregar_al_comienzo(lista, viaje);
        leer_viaje(viaje);
    end;
end;

function validar_dni(dni: integer): boolean;
var
    digito: integer;
begin
    while (dni <> 0) do begin
        digito:= dni MOD 10;
        if (digito MOD 2 = 0)) then // puede ser también  digito MOD 2 <> 1
            validar_dni:= false;
        dni:= dni DIV 10;
    end;
    validar_dni:= true;
end;

procedure obtener_maximo_minimo(vector: t_vector_acumulador; var codigo_maximo, codigo_minimo: t_subrango);
var
    indice: t_subrango;
    kilometros_maximo, kilometros_minimo: real;
begin
    kilometros_maximo:= -1;
    kilometros_minimo:= 99999999999;
    for indice := 1 to LIMITE do begin
        if (vector[indice] > kilometros_maximo) then begin
            codigo_maximo:= indice;
            kilometros_maximo:= vector[indice];
        end;
        if (vector[indice] < kilometros_minimo) then begin
            codigo_minimo:= indice;
            kilometros_minimo:= vector[indice];
        end;
    end;
end;

procedure inicializar_vector(var vector: t_vector_acumulador);
var 
    indice: t_subrango;
begin
    for indice := 1 to LIMITE do
        vector[indice]:= vector[indice] + 1;
end;


procedure recorrer_e_informar(lista: t_lista_viaje; vector: t_vector_camion);
var
    vector_acumulador: t_vector_acumulador;
    codigo_minimo, codigo_maximo: t_subrango;
    contador_viajes: integer;
    dato: t_viaje;
begin
    if (lista <> nil) then begin
        inicializar_vector(vector_acumulador);
        contador_viajes:= 0;
        while (lista <> nil ) then begin
            dato:= lista^.dato;

            vector_acumulador[dato.codigo_camion]:= vector_acumulador[dato.codigo_camion] + dato.kilometros_recorridos;

            if ((vector[dato.codigo_camion].capacidad > 30.5) and ((dato.anio_viaje - vector[dato.codigo_camion].anio_fabricacion > 5))) then
                contador_viajes:= contador_viajes + 1;

            if (validar_dni(dato.dni_chofer)) then
                writeln('El chofer con el DNI ', dato.dni_chofer, ' contiene sólo dígitos pares');
            lista:= lista^.siguiente;
        end;
        obtener_maximo_minimo(vector_acumulador, codigo_maximo, codigo_minimo);
        writeln('La patente del camión que más kilómetros recorridos posee es: ', vector[codigo_maximo].patente, ' con ', vector_acumulador[codigo_maximo], ' recorridos');
        writeln('La patente del camión que menos kilómetros recorridos posee es: ', vector[codigo_minimo].patente, ' con ', vector_acumulador[codigo_minimo], ' recorridos');
        writeln('La cantidad de viajes que se han realizado en camiones con capacidad mayor a 30,5 toneladas
        y que posean una antigüedad mayor a 5 años al momento de realizar el viaje es: ', contador_viajes);       

    end
    else
        writeln('La lista se encuentra vacía');
end;

var
    lista: t_lista_viaje;

    vector_camion: t_vector_camion;

begin
    lista:= nil;
    cargar_vector_camiones(vector); //Se dispone de proceso
    cargar_viajes(lista, vector);
    recorrer_e_informar(lista);
end.
