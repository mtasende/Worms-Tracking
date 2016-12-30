clc
clear all
close all


load etiquetada
%frameEt, clasesEt

tic
centroides = getCentroides(frameEt,clasesEt);
toc

tic
centroides2 = getCentroidesR(frameEt,clasesEt);
toc

imshow(frameEt)
hold on
plot(centroides(:,2),centroides(:,1),'*g')
plot(centroides2(:,2),centroides2(:,1),'*r')

