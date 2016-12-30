function tracks = tracking(centroides)

%Tracks en una matriz de dim=3. La tercer entrada es el numero de frame
%Cuando el track no esta activo se pone x=-1.
%Los valores x=-1 solo pueden estar al principio y al final del track

T = length(centroides);

%Primero asigno todos los centroides a un track
tracks(:,:,1) = centroides{1};
pred = tracks(:,:,1); % Se predicen los mismos centroides para t=1, porque no hay anteriores

for t = 2:T
    N = size(tracks(:,:,t-1),1);
    dists = matrizDist(pred,centroides{t});
    for i = 1:N
        [m,jMin] = min(dists(i,:)); %Inicialmente me quedo con el que este mas cerca, con repeticion posible
        tracks(i,:,t) = centroides{t}(jMin,:);
    end
    
    %Refinar estimacion
    
    %Hacer las nuevas predicciones
    pred = tracks(:,:,t);
end


