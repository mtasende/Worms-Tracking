function [clase,relacionesNuevas,claseNueva]=vecinos(clasesVentana)
%Se pasan las clases de la ventana en un array
%Se devuelve la clase del elemento a probar, y las nuevas relaciones
%Si se creo una clase nueva, se devuelve en claseNueva=true

claseNueva = [];
relacionesNuevas = [];

N = length(clasesVentana);
claseTemp = 0; %Si no encuentro una clase previa, devuelvo 0
for i=1:N
    if(clasesVentana(i)~=0)
        if(claseTemp == 0)
            claseTemp = clasesVentana(i); %Se cambia la clase del pixel. No se agregan relaciones
        else
            %No se cambia la clase del pixel en estudio, pero se agregan
            %relaciones si es necesario
            if(clasesVentana(i) ~= claseTemp)
                relacionesNuevas = [relacionesNuevas; claseTemp, clasesVentana(i);clasesVentana(i),claseTemp];
            end
        end
    end
end

if(claseTemp==0) %Se agrega una clase nueva
    claseNueva = true;
end
clase = claseTemp;

end %Fin de vecinos