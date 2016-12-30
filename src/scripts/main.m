%---------------------Inicialización------------------------
clc
clear all
close all

os = 'lin';

if(os=='win')
    addpath('.','..\funciones','..\frames','..\videos','..\imagenes','..\funciones\hungarian');
else
    addpath('.','../funciones','../frames','../videos','../imagenes','../funciones/hungarian');
end
%----------------------------------------------------------

%Leer los frames---------------------------------------------------
tic
archivosIma = dir('../frames3/*.jpg');
N = length(archivosIma); %Cantidad de frames

disp('Leyendo imagenes')
ima1 = rgb2gray(imread(['../frames3/' archivosIma(1).name]));
[m n] = size(ima1);

frames = zeros(m,n,N);
frames(:,:,1) = ima1;

for i=2:N
    frames(:,:,i) = rgb2gray(imread(['../frames3/' archivosIma(i).name]));
end
toc
%-------------------------------------------------------------------

%Consigo los centroides de los gusanos tentativos-------------------
k = 20;
umbral = -17;
tamUnir = 6;
minTamGusano = 0.80;
criterio = 'media'

%Opcion larga, completa (481 frames)
%[centroides,nReg] =
%detectar(frames,k,umbral,tamUnir,minTamGusano,criterio);
%inicio = 1;
%fin = N;

%debug, con 120 frames
inicio = 151;
fin = 270;
[centroides,nReg] = detectar(frames(:,:,inicio:fin),k,umbral,tamUnir,minTamGusano,criterio);
%-------------------------------------------------------------------

figure
plot(nReg)

%Los frames 201..220 son los de evaluación. Muestro algunos, para ver qué
%tan buena es la detección
for i=201:204
    eval = imread(['../frames3/eval/frame' num2str(i) '.jpg']);
    figure
    imshow(eval)
    hold on
    plot(centroides{i-150-k}(:,2),centroides{i-150-k}(:,1),'*r')
end
%--------------------------------------------------------------------------

%Ahora el tracking y desambiguacion de gusanos-----------------------------
%tracks = tracking(centroides);
%tracks = tracking2(centroides);
%tracks = tracking3(centroides);
tracks = tracking4(centroides);
figure
plotTracks(tracks,20,archivosIma(inicio+k:fin-k))
%--------------------------------------------------------------------------

%Cantidad de gusanos
[Ntracks,d,T] = size(tracks);
for t=1:T
    nTracks(t) = sum(tracks(:,1,t) ~=-1);
end
figure
plot(nReg)
hold on
plot(nTracks,'r')
axis([0 T 0 (max(nTracks)*(1.15))])
legend('Num. Regiones','Num. Tracks','Location','SouthWest')




