function clases = equivR(relacion,Nobj)
%Dada una relacion simetrica, esta funcion impone la transitividad y
%devuelve las clases de equivalencia
% NOTA: No se impone la simetria (seria facil, pero se pide que "relacion" ya sea simetrica)
% Nobj es la cantidad de objetos. Se asume una codificacion de 1 a N en
% relacion

obj = 1:Nobj;

nClase = 1;
for i=1:Nobj
    if(obj(i) ~= 0) %No esta incluido en una clase todavia
        
        estaClase = buscarClase([],relacion,obj(i));
        
        clasesTemp{nClase} = estaClase;
        nClase = nClase+1;
        obj(estaClase) = 0;%Borro los incluidos. Uso que el indice es igual al valor del objeto
    end
end

clases = clasesTemp;

end


function estaClaseS = buscarClase(estaClase,relacion,objeto)

relacionados = relacion(relacion(:,1) == objeto,2);
relacionadosValidos = [];
for i=1:length(relacionados)
    if(relacionados(i)~=objeto) %Por las dudas
        if(~any(estaClase==relacionados(i))) %Esto evita loops infinitos en la recursion
            relacionadosValidos = [relacionadosValidos relacionados(i)];
        end
    end
end
Nvalidos = length(relacionadosValidos);

if(Nvalidos==0)
    estaClaseS = [estaClase objeto];
else
    estaClaseTemp = [estaClase objeto];
    for i=1:Nvalidos
        if(~any(estaClaseTemp==relacionadosValidos(i))) %Evito repetidos
            estaClaseTemp = buscarClase(estaClaseTemp,relacion,relacionadosValidos(i)); %Devuelve todo lo que le paso mas lo que encuentra abajo
        end
    end
    estaClaseS = estaClaseTemp;
end

end