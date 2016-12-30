function [stackRes,medianas]=medianaCentrada(stack,k)
%Se descartan las k primeras imagenes y las k ultimas
% stackRes devuelve un stack de imagenes que consiste en la resta
% de la imagen actual, con la mediana de las k imagenes anteriores y k
% posteriores (con la imagen incluida)
% En "medianas" se guardan las medianas resultantes

disp('Calculando la mediana')

[m n N] = size(stack);

medianas = zeros(m,n,N-(2*k+1));
stackRes = zeros(m,n,N-(2*k+1));

for l = k+1:N-k
    medianas(:,:,l-k) = median(stack(:,:,l-k:l+k),3);
    stackRes(:,:,l-k) = imsubtract(stack(:,:,l),medianas(:,:,l-k));
    disp([num2str((l-k)*100/(N-2*k)) '%'])
end


