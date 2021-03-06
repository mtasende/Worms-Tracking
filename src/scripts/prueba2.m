clc
clear all
close all

archivosIma = dir('../frames/*.png');
N = length(archivosIma); %Cantidad de frames

disp('Leyendo imagenes')
ima1 = rgb2gray(imread(['../frames/' archivosIma(1).name]));
[m n] = size(ima1);

%Primero intento trabajar con "diferencias por movimiento"

stack = zeros(m,n,N);
stack(:,:,1) = ima1;

for i=2:N
    stack(:,:,i) = rgb2gray(imread(['../frames/' archivosIma(i).name]));
end

%submuestreo
subm = 2;
stack = stack(1:subm:end,1:subm:end,:);
[m n] = size(stack(:,:,1));

disp('Calculando la mediana')
k = 2;
[stackRes,medianas]=medianaCorrida(stack,k);

disp('mostrando resultados iniciales')
for i=1:N-k
    figure
    subplot(1,2,1)
    imshow(stack(:,:,i+k),[0 255])
    subplot(1,2,2)
    imshow(stackRes(:,:,i),[0 255])
end