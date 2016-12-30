function [imRes,clases]=etiquetar(imagen,nVecinos)
%Se asume que la imagen tiene valor 0 para el fondo, y otro valor para los
%objetos a etiquetar
%nVecinos dice si usar 4 u 8. Por defecto son 8.

[M N] = size(imagen);

%Listas de cosas auxiliares
clasesIni = [];
clases = [];
relaciones = [];

%Matriz de etiquetas
etiquetasGrande = zeros(M+2,N+2); %Le agrego un borde temporal de ceros

%Loops de etiquetado inicial y armado de relaciones
proximaClase = 1;
for i=1:M
    for j=1:N
        if(imagen(i,j)~=0)
            
            if(nVecinos == 4)
                clasesVentana = [etiquetasGrande(i,j+1) etiquetasGrande(i+1,[j,j+2]) etiquetasGrande(i+2,j+1)];
            else
                clasesVentana = [etiquetasGrande(i,j:j+2) etiquetasGrande(i+1,[j,j+2]) etiquetasGrande(i+2,j:j+2)];
            end
            
            [clase,relacionesNuevas,claseNueva]=vecinos(clasesVentana);
            
            if(claseNueva)
                etiquetasGrande(i+1,j+1) = proximaClase;
                clasesIni = [clasesIni, proximaClase];
                proximaClase = proximaClase + 1;
            else
                etiquetasGrande(i+1,j+1) = clase;
                relaciones = [relaciones; relacionesNuevas];
            end
        end
    end
end
etiquetas = etiquetasGrande(2:M+1,2:N+1);

%Ahora encuentro las clases de equivalencia y reetiqueto
if(size(relaciones,1)~=0)
    clasesNuevas = equivR(relaciones,length(clasesIni));

    for i=1:length(clasesNuevas)
        etiquetas = aplicarRelacion(etiquetas,i,clasesNuevas{i});
    end
    
    clases = 1:length(clasesNuevas);
end

imRes = etiquetas;

end %Fin de la funcion principal


function etiquetasS = aplicarRelacion(etiquetas,valor,clases)
%Pone el "valor" en todos los pixels que tenian alguno de los valores de
%"clases"
etiquetasS = etiquetas;
for i=1:length(clases)
    etiquetasS(etiquetas==clases(i)) = valor;
end

end