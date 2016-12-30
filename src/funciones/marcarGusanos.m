function marcarGusanos(nombreImagen,fmt,X)
%La variable "X" puede contener el "Xgus" de una ejecucion previa de la
%funcion. Normalmente seria cargada de "nombreImagen.mat", que es el
%resultado final de ejecutar esta funcion.
%Si no hay datos anteriores pasar X={}
%"nombreImagen" es el nombre del archivo sin la extension. "fmt" es la
%extension
% Se termina guardando nombreImagen.mat con los datos

imagen = imread([nombreImagen '.' fmt]);

imaTemp = imagen;
Xgus = X;
M = length(Xgus);
imaTemp = mostrarGusanos(imaTemp,Xgus,'no');

resp = 0;
i = M+1;
while(resp~=1)
    %Consigo las coordenadas de un gusano
    figure(1) %La imagen completa que se ira actualizando

    imshow(imaTemp)
    v = ginput();
    Xgus{i} = v;
    %----------------------------------------
    
    %Voy a mostrar el resultado en la imagen general
    imaTemp = mostrarGusanos(imaTemp,Xgus,'no');

    i = i+1;
    resp = input('Seguir? [1] = no, [2] = descartar y salir, [otro] = si');
    if size(resp)==0
        resp = 0;
    end
    if resp==2
        return
    end
end

imshow(imaTemp)

%Guardo las coordenadas de los gusanos
save([nombreImagen '.mat'],'Xgus')

%Guardo la imagen resultante
imwrite(imaTemp,[nombreImagen '.' fmt],fmt)

%Muestro los gusanos resultantes (opcional)