function [stackRes,medianas]=medianaCorrida(stack,k)
%Se descartan las k primeras imagenes
% stackRes devuelve un stack de imagenes que consiste en la resta
% de la imagen actual, con la mediana de las k imagenes anteriores
% En "medianas" se guardan las medianas resultantes

[m n N] = size(stack);

medianas = zeros(m,n,N-k);
stackRes = zeros(m,n,N-k);

for l = k+1:N
    medianas(:,:,l-k) = median(stack(:,:,l-k:l-1),3);
    stackRes(:,:,l-k) = imsubtract(stack(:,:,l),medianas(:,:,l-k));
    disp([num2str((l-k)*100/(N-k)) '%'])
end



