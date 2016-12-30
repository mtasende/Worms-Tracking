function centroides=getCentroides(imagen,clases)

%Se le pasa una imagen etiquetada y las etiquetas (clases)
%Devuelve una matriz de centroides de cada clase

N = length(clases);
[m n] = size(imagen);

%Voy a hallar los centroides para cada clase
for k = 1:N
    imaTemp = imagen==clases(k);
    masa = sum(sum(imaTemp));
    Xm = [0 0];
    for i=1:m
        for j=1:n
            Xm = Xm + [i j]*imaTemp(i,j);
        end
    end
    centroides(k,:) = Xm / masa;
end



