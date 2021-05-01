{
    Se dispone de un vector con números enteros, de dimensión física dimF y dimensión lógica dimL.
        a- Realizar un módulo que imprima el vector desde la primera posición hasta la última
        b- Realizar un módulo que imprima el vector desde la última posición hasta la primera.
        c- Realizar un módulo que imprima el vector desde la mitad (dimL DIV 2) hacia la primera posición, y desde la mitad más uno hacia la última posición
        d- Realizar un módulo que reciba el vector, una posición X y otra posición Y ,e imprima el vector desde la posición X hasta la Y.Asuma que tanto X como Y 
        son menores o igual a la dimensión lógica. Y considere que, dependiendo de los valores de X e Y, podría ser necesario recorrer hacia adelante o hacia atrás.
        e- Utilizando el módulo implementado en el inciso anterior,vuelva a realizar los incisos a, b y c
}
program ejercicio_3_v1;
uses crt; //Librería para usar la función ClrScr para limpiar pantalla
const
    dim_f = 100;
    dim_l = 10;
type
    t_vector = array [1..dim_f] of integer;

// a- Realizar un módulo que imprima el vector desde la primera posición hasta la última
procedure recorrerVectorA(vector: t_vector);
var
    indice: integer;
begin
    for indice := 1 to dim_l do
    begin
        writeln('vector[', indice,'] := ', vector[indice]);
    end;
end;

// b- Realizar un módulo que imprima el vector desde la última posición hasta la primera.
procedure recorrerVectorB(vector: t_vector);
var
    indice: integer;
begin
    for indice := dim_l downto 1 do
    begin
        writeln('vector[', indice,'] := ', vector[indice]);
    end;
end;

// c- Realizar un módulo que imprima el vector desde la mitad (dimL DIV 2) hacia la primera
// posición, y desde la mitad más uno hacia la última posición
procedure recorrerVectorC(vector: t_vector);
var
    mitad, indice: integer;
begin
    mitad:= dim_l DIV 2;

    //for desde la mitad (dim_l DIV 2) hacia la primera posición
    for indice := mitad downto 1 do
    begin
        writeln('vector[', indice,'] := ', vector[indice]);
    end;

    //for desde la mitad más uno hacia la última posición
    for indice := mitad + 1 to dim_l do
    begin
        writeln('vector[', indice,'] := ', vector[indice]);
    end;
end;

// d- Realizar un módulo que reciba el vector, una posición X y otra posición Y, e imprima el vector
// desde la posición X hasta la Y. Asuma que tanto X como Y son menores o igual a la dimensión lógica.
// Y considere que, dependiendo de los valores de X e Y, podría ser necesario recorrer hacia adelante o hacia atrás.
procedure recorrerVectorD(vector: t_vector; posicion_x: integer; posicion_y: integer);
var
    indice: integer;
begin
    if (posicion_x <  posicion_y) then 
    begin
        for indice := posicion_x to posicion_y do
        begin
             writeln('vector[', indice,'] := ', vector[indice]);
        end;
    end
    else
    begin
        for indice := posicion_x downto posicion_y do
        begin
             writeln('vector[', indice,'] := ', vector[indice]);
        end;
    end;
end;

// e- Utilizando el módulo implementado en el inciso anterior,vuelva a realizar los incisos a, b y c

// a- Realizar un módulo Utilizando el módulo implementado en el inciso D que imprima el vector desde la primera posición hasta la última
procedure recorrerVectorAD(vector: t_vector);
begin
    recorrerVectorD(vector, 1, dim_l);
end;

// b- Realizar un módulo Utilizando el módulo implementado en el inciso D que imprima el vector desde la última posición hasta la primera.
procedure recorrerVectorBD(vector: t_vector);
begin
    recorrerVectorD(vector, dim_l, 1);
end;

// c- Realizar un módulo Utilizando el módulo implementado en el inciso D que imprima el vector desde la mitad (dimL DIV 2) hacia la primera
// posición, y desde la mitad más uno hacia la última posición
procedure recorrerVectorCD(vector: t_vector);
var
    mitad: integer;
begin
    mitad:= dim_l DIV 2;

    //for desde la mitad (dim_l DIV 2) hacia la primera posición
    recorrerVectorD(vector, mitad, 1);

    //for desde la mitad más uno hacia la última posición
    recorrerVectorD(vector, mitad + 1, dim_l);
end;
//Carga el vector con números random y muestra su contenido
procedure generarVector(var vector: t_vector);
var
    indice: integer;
begin
    for indice := 1 to dim_l do
        vector[indice] := random(indice);
    ClrScr;
    recorrerVectorA(vector);
end;

VAR
    vector: t_vector;
    opcion: integer;
BEGIN
    writeln('Presione <enter> para empezar... ');
    readln;

    generarVector(vector);

    repeat
        ClrScr; //Limpia la pantalla
        writeln('1 - Imprimir el vector desde la primera posición hasta la última');
        writeln('2 - Imprimir el vector desde la última posición hasta la primera');
        writeln('3 - Imprimir el vector desde la mitad (dimL DIV 2) hacia la primera posición, y desde la mitad más uno hacia la última posición');
        writeln('4 - Imprimir el vector desde posición X hasta la posición Y');
        writeln('5 - Imprimir el vector desde la primera (posición X) hasta la última (posición Y)');
        writeln('6 - Imprimir el vector desde la última (posición X) hasta la primera (posición Y)');
        writeln('7 - Imprimir el vector desde la mitad (dimL DIV 2)(posición X)  hacia la primera (posición Y), y desde la mitad (posición X) más uno hacia la última (posición X)');
        writeln('8 - Regenerar valores del vector');
        writeln('0 - Terminar');
        readln(opcion);
        ClrScr;
        case opcion of
            1: recorrerVectorA(vector);
            2: recorrerVectorB(vector);
            3: recorrerVectorC(vector);
            4: recorrerVectorD(vector, 2, 8); //posición X = 2 posición Y = 8
            5: recorrerVectorAD(vector);
            6: recorrerVectorBD(vector);
            7: recorrerVectorCD(vector);
            8: generarVector(vector);
        end;
        if opcion <> 0 then begin
            writeln('Presione <enter> para continuar... ');
            readln;
        end;    
    until (opcion = 0);
    ClrScr;
END.