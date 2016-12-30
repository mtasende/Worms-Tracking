function [imRes,umbral]=otsu(imagen)

M = 255;

bordes = (0:M+1)-0.5;
histo = histc(imagen(:),bordes); %M+1 elementos
histograma = histo(1:end-1)'; %Descarto el ultimo valor que contaria los 255.5

total = sum(histograma);
valores = (0:M)';
vInter = zeros(M+1,1);
%Ahora considero todos los umbrales posibles, de 0 a M
for u=0:M
    nFondo = sum(histograma(1:u+1));
    nCosa = sum(histograma(u+2:end));
    
    wFondo = nFondo/total;
    wCosa = nCosa/total;

    if(nFondo~=0)
        muFondo = histograma(1:u+1)*valores(1:u+1)/nFondo;
    else
        muFondo = 0;
    end
    if(nCosa~=0)
        muCosa = histograma(u+2:end)*valores(u+2:end)/nCosa; %mu...Cosa :P
    else
        muCosa = 0;
    end
    
    vInter(u+1) = wFondo*wCosa*(muFondo-muCosa)^2;
end

[interMax,umbral] = max(vInter);
umbral = umbral - 1; %Para ajustar del indice al valor

imRes = imagen>umbral; %Tiene un bias minimo (para todo umbral puede haber fondo, para umbral=255 no hay cosas).
%keyboard
