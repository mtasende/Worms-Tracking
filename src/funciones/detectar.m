function [centroides,nReg]=detectar(frames,k,umbral,tamUnir,minTamGusano,criterio)
%frames es una matriz de 3 dimensiones: i,j,l (para cada l es una imagen)
%k es la cantidad de frames hacia adelante y atras que se toma la mediana
%umbral es la intensidad minima para el filtro de fondo
%tamUnir es el tamanio del disco para la cerradura
%minTamGusano es la minima fraccion de una region, respecto de la maxima 
%(u otro criterio si mejoro en otra version) para que se la considere un
%gusano
%Resultados: centroides son los centroides de las regiones
% nReg es la cantidad de regiones por frame

[framesRes,medianas]=medianaCentrada(frames,k);

N = size(frames,3);
%aviobj = avifile('../videos/deteccion.avi','FPS',2) %Para grabar video

disp('Detectando posibles gusanos')
for i=1:N-2*k
    
    %Umbralización y operaciones morfologicas--
    frameUmbral = framesRes(:,:,i)<umbral;
    se = strel('disk',tamUnir);
    frameClosed = imclose(frameUmbral,se);
    %------------------------------------------
    
    %Etiquetado y filtrado por tamanio-------------------------------------
    [frameEtiq,clases] = etiquetar(frameClosed,8);
    [frameEtiq,clasesRes]=soloGrandes(frameEtiq,minTamGusano,clases,criterio);
    %----------------------------------------------------------------------
    
    nReg(i) = length(clasesRes);
    
    
    %if i == 1  %Para debug de getCentroides()
        %frameEt = frameEtiq;
        %clasesEt = clasesRes;
        %save('etiquetada.mat','frameEt','clasesEt')
    %end
    
%     if i<=10 %Muestro algunas graficas para debug
%         figure
%         subplot(2,2,1)
%         imshow(frames(:,:,i+k),[0 255])
%         subplot(2,2,2)
%         m = min(min(framesRes(:,:,i)));
%         M = max(max(framesRes(:,:,i)));
%         imshow(255*round((framesRes(:,:,i)-m)/(M-m)),[0 255])
%         subplot(2,2,3)
%         imshow(255*uint8(frameClosed),[0 255])
%         subplot(2,2,4)
%         imshow(255*uint8(frameEtiq>0),[0 255])
%     end
%     
%     figure(100)
%     imagesc(frameEtiq)
    
    %Calculo de centroides-------------------------------------------------
    centroides{i} = getCentroidesR(frameEtiq,clasesRes);
%     hold on
%     plot(centroides{i}(:,2),centroides{i}(:,1),'*r')
    %----------------------------------------------------------------------
    %f = getframe; %Para grabar video
    %aviobj = addframe(aviobj,f); %Para grabar video
    disp([num2str(i*100/(N-2*k)) '%'])
end
%aviobj = close(aviobj); %Para grabar video

