function centroides=getCentroidesR(imagen,clases)

%Se le pasa una imagen etiquetada y las etiquetas (clases)
%Devuelve una matriz de centroides de cada clase

N = length(clases);
[m n] = size(imagen);

masa = zeros(N,1); %Una masa por clase
Xm = zeros(N,2); %Un centroide por clase

%Voy a hallar los centroides para cada clase
for i=1:m
    for j=1:n
        for k=1:N
            if imagen(i,j)==clases(k)
                Xm(k,:) = Xm(k,:) + [i j];
                masa(k) = masa(k) + 1;
            end
        end
    end
end
centroides = Xm./[masa masa];