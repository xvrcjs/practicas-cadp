{
    Realizar un programa que lea información de los candidatos ganadores de las últimas elecciones a intendente de
la provincia de Buenos Aires. Para cada candidato se lee: localidad, apellido del candidato, cantidad de votos
obtenidos y cantidad de votantes de la localidad. La lectura finaliza al leer la localidad ‘Zárate’, que debe procesarse.
Informar:
        ● El intendente que obtuvo la mayor cantidad de votos en la elección.
        ● El intendente que obtuvo el mayor porcentaje de votos de la elección.
}
program ultimasElecciones;
type
    substring = string[50];

    candidato = record
        localidad:  substring;
        apellido: substring;
        cantidadDeVotos: integer;
        cantidadDeVotantes: integer;
    end;

procedure leer(var intendente: candidato);
begin
    write('Ingrese el nombre de la localidad: ');
    readln(intendente.localidad);
    write('Ingrese el apellido del candidato: ');
    readln(intendente.apellido);
    write('Ingrese la cantidad de votos: ');
    readln(intendente.cantidadDeVotos);
    write('Ingrese la cantidad de votantes: ');
    readln(intendente.cantidadDeVotantes);
end;

function calcularPorcentaje(intendente: candidato):real;
begin
    calcularPorcentaje:= intendente.cantidadDeVotos * 100 / intendente.cantidadDeVotantes;
end;
VAR
    intendente: candidato;
    intendenteMasVotado: candidato;
    intendenteMayorPorcentaje: candidato;
    porcentaje: real;
    mayorPorcentaje: real;
    masVotado: integer;
BEGIN
    mayorPorcentaje:= -1;
    masVotado:= -1;
    repeat
        leer(intendente);
        porcentaje:= calcularPorcentaje(intendente);
        if (porcentaje > mayorPorcentaje) then
        begin
            mayorPorcentaje:= porcentaje;
            intendenteMayorPorcentaje:= intendente;
        end;

        if (intendente.cantidadDeVotos > masVotado) then
        begin
            masVotado:= intendente.cantidadDeVotos;
            intendenteMasVotado:= intendente;
        end;
    until (intendente.localidad = 'Zárate');
    
    writeln('El intendente que obtuvo la mayor cantidad de votos en la elección es ', intendenteMasVotado.apellido, ' de la localidad ', intendenteMasVotado.localidad, ' con un total de ', intendenteMasVotado.cantidadDeVotos, ' votos');
    writeln('El intendente que obtuvo el mayor porcentaje de votos es ', intendenteMayorPorcentaje.apellido, ' de la localidad ', intendenteMayorPorcentaje.localidad);
END.

