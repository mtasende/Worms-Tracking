clc
clear all
close all

archivosIma = dir('../frames/*.png');
N = length(archivosIma); %Cantidad de frames

disp('Leyendo imagenes')
ima1 = rgb2gray(imread(['../frames/' archivosIma(1).name]));
%ima1 = rgb2gray(imread(['../frames2/' archivosIma(1).name]));
[m n] = size(ima1);

%Primero intento trabajar con "diferencias por movimiento"

stack = zeros(m,n,N);
stack(:,:,1) = ima1;

for i=2:N
    stack(:,:,i) = rgb2gray(imread(['../frames/' archivosIma(i).name]));
    %stack(:,:,i) = rgb2gray(imread(['../frames2/' archivosIma(i).name]));
end

%submuestreo
subm = 1;
stack = stack(1:subm:end,1:subm:end,:);
[m n] = size(stack(:,:,1));

k = 3;
[stackRes,medianas]=medianaCentrada(stack,k);
%[stackRes,medianas]=medianaCorrida(stack,k);

aviobj = avifile('../videos/prueba3.avi','FPS',1)
disp('mostrando resultados iniciales')
for i=1:N-2*k
    figure
    subplot(2,2,1)
    imshow(stack(:,:,i+k),[0 255])
    title('Imagen original')
    subplot(2,2,2)
    m = min(min(stackRes(:,:,i)));
    M = max(max(stackRes(:,:,i)));
    imshow(255*round((stackRes(:,:,i)-m)/(M-m)),[0 255])
    title('Imagen con fondo restado')
    %imagesc(stackRes(:,:,i))
    subplot(2,2,3)
    stackUmbral = stackRes(:,:,i)<-10;
    se = strel('disk',6);
    %se = strel('disk',2);
    %erosionada = imopen(stackUmbral,se);
    erosionada = imclose(stackUmbral,se);
    %erosionada = imdilate(erosionada,se);
    imshow(255*uint8(erosionada),[0 255])
    title('Despues de umbralizar y operac. morfologicas')
    
    [stackEtiq(:,:,i),clases] = etiquetar(erosionada,8);
    [stackEtiq(:,:,i),clasesRes]=soloGrandes(stackEtiq(:,:,i),0.1,clases,'max');
    Ngusanos(i) = length(clasesRes);
    subplot(2,2,4)
    imshow(255*uint8(stackEtiq(:,:,i)>0),[0 255])
    title('Despues de etiquetado y filtrado de regiones chicas')
    
    figure
    imagesc(stackEtiq(:,:,i))
    f = getframe;
    aviobj = addframe(aviobj,f);
    %pause
end
aviobj = close(aviobj);

figure
plot(1:length(Ngusanos),Ngusanos)
xlabel('frame (después del descarte de 2*k)')
ylabel('Numero de gusanos')


% pause
% close all
% 
% figure
% imagesc(max(stackRes,[],3))
% 
% figure
% imagesc((max(stack,[],3)-min(stack,[],3))/2)
% 
% figure
% maximo = max(stack,[],3); %255 es el blanco
% imshow(maximo,[0 255])
% 
% for i=1:N
%     figure
%     subplot(1,2,1)
%     imshow(stack(:,:,i),[0 255])
%     subplot(1,2,2)
%     imshow(maximo-stack(:,:,i),[0 255])
% end
% 
% pause
% close all
% 
% figure
% maximo = max(stackRes,[],3); %255 es el blanco
% imshow(maximo,[0 255])
% 
% for i=1:N-2*k
%     figure
%     subplot(1,2,1)
%     imshow(stack(:,:,i+k),[0 255])
%     subplot(1,2,2)
%     imshow(maximo-stackRes(:,:,i),[0 255])
% end