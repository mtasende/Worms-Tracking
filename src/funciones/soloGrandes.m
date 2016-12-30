function [imaRes,clasesRes]=soloGrandes(imagen,p,clases,criterio)
%Devuelve una imagen con las regiones que tienen mas de la fraccion p de los 
%pixels que tiene la region mas grande
%Pasarle las clases facilita la division en bins, para el histograma (ahorra tiempo)

N = length(clases);

imVec = imagen(:);
histograma = hist(imVec(imVec~=0),1:N);
[mOrd,ind] = sort(histograma,'descend');

claseMax = ind(1);
%maximo = mOrd(1);
if strcmp(criterio,'max')
    patron = mOrd(1);
elseif strcmp(criterio,'media')
    patron = mean(mOrd);
else %default (para ir agregando criterios después)
    patron = mOrd(1);
end

frac = 1;
k=1;
clasesRes = [];
imaGrandes = zeros(size(imagen));
while(frac>p)
    clasesRes(k) = ind(k);
    imaGrandes = imaGrandes | imagen==ind(k); %Agrego 1s donde haya una clase grande
    frac = mOrd(k)/patron;
    k = k+1;
end

imaRes = imagen.*imaGrandes;

