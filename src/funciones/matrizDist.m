function M=matrizDist(x,y)
% x es de Nx2
% y es de Mx2
% M es de NxM y tiene todas las combinaciones de distancias cuadraticas

%Gran for aqui, o manipulacion vectorial
N = size(x,1);
M = size(y,1);

coord1X = repmat(x(:,1),1,M);
coord1Y = repmat(y(:,1)',N,1);
coord2X = repmat(x(:,2),1,M);
coord2Y = repmat(y(:,2)',N,1);

M = (coord1X-coord1Y).^2 + (coord2X-coord2Y).^2;
