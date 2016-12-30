function imaRes = mostrarGusanos(imagen,X,contorno)
%Funcion que devuelve la imagen con los gusanos dado un vector de celdas "gusano"
%Se puede pedir el contorno o el area (contorno='si')

N = length(X);

r = imagen(:,:,1);
g = imagen(:,:,2);
b = imagen(:,:,3);

[Ly,Lx] = size(r);
xima = 1:Lx;
yima = 1:Ly;
    
[xx yy] = meshgrid(xima,yima);

for i=1:N
    v = X{i};
    
    x = v(:,1);
    y = v(:,2);
     
    [gusano, gusanoC] = inpolygon(xx,yy,x,y);
    
    if(contorno=='si')
        r(gusanoC) = 0;
        g(gusanoC) = 255;
        b(gusanoC) = 0;
    else
        r(gusano) = 0;
        g(gusano) = 255;
        b(gusano) = 0;
    end

end

imaRes(:,:,1) = r;
imaRes(:,:,2) = g;
imaRes(:,:,3) = b;



