program empresa_de_fletes;
const
    t_codigo_camion = 200..255;

type
    t_servicio = record
        codigo_camion: t_codigo_camion;
        provincia_origen: string;
        provincia_destino: string;
        kilometros_recorridos: integer;
        dni_cliente: integer;
    end;

    t_lista_servicio = ^t_nodo_servicio;

    t_nodo_servicio = record
        dato: t_servicio;
        siguiente: t_lista_servicio;
    end;

procedure leer(var servicio: t_servicio); //Se dispone
procedure cargar_lista_servicios(var lista: t_lista_servicio); //Se dispone
function validar_cliente(servicio: t_servicio): boolean;
begin
    if (((servicio.dni_cliente MOD 2) <> 0) and (servicio.provincia_origen = servicio.provincia_destino)) then
        validar_cliente:= true;
    validar_cliente:= false;
end;
procedure recorrer_y_procesar(lista: t_lista_servicio);
var
    cantidad_camiones, contador_viajes, contador_viajes_maximo, cantidad_clientes: integer;
    provincia_origen, nombre_provincia: string;
begin
    cantidad_camiones:= 0;
    contador_viajes_maximo:= -1;
    cantidad_clientes:= 0;
    while (lista <> nil) do begin
        provincia_origen:= lista^.dato.provincia_origen;
        contador_viajes:= 0;
        while ((lista <> nill) and (lista^.dato.provincia_origen = provincia_origen)) do begin
            if (lista^.dato.kilometros_recorridos > 5000) then
                cantidad_camiones:= cantidad_camiones + 1;
            contador_viajes:= contador_viajes + 1;
            if (validar_cliente(lista^.dato)) then
                cantidad_clientes:= cantidad_clientes + 1;
            lista:= lista^.siguiente;
        end;
        if (contador_viajes > contador_viajes_maximo) then begin
            nombre_provincia:= provincia_origen;
            contador_viajes_maximo:= contador_viajes;
        end;
    end;

    writeln('La cantidad de camiones que recorrieron más de 5000km es: ', cantidad_camiones);
    writeln('El nombre de la provincia de donde partieron más viajes es: ', nombre_provincia);
    writeln('La cantidad de clientes con dni impar y viajes dentro de la misma provincia es: ', cantidad_clientes);
end;
VAR
    lista: t_lista_servicio;
BEGIN
    lista:= nil;
    cargar_lista_servicios(lista);
    recorrer_y_procesar(lista);
END.