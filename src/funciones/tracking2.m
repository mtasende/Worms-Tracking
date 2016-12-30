function tracks = tracking2(centroides)

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
    listaAgregados = [];
    for i = 1:N
        [m,jMin] = min(dists(i,:)); %Inicialmente me quedo con el que este mas cerca, con repeticion posible
        tracks(i,:,t) = centroides{t}(jMin,:);
        listaAgregados = [listaAgregados jMin];
    end
    %Los centroides no agregados generan nuevos tracks (por ahora; se puede mejorar)
    jAAgregar = setdiff(1:size(centroides{t},1),listaAgregados);
    %Por ahora agrego de a uno, se puede mejorar
    for k=1:length(jAAgregar)
        tracks = agregarTrack(tracks,centroides{t}(jAAgregar(k),:),t);
    end
    
    %Refinar estimacion
    
    %Hacer las nuevas predicciones
    pred = tracks(:,:,t);
    end

end

function tracksR = agregarTrack(tracks,puntoActual,tActual)
%Creo el padding de -1
N = size(tracks,1); %Cantidad de tracks previos
T = size(tracks,3); %Cantidad de frames ingresados

tracksR = ones(N,2,T)*(-1);
tracksR(1:N,:,:) = tracks;
for t =1:T
    tracksR(N+1,:,t) = [-1,-1];
end
tracksR(N+1,:,tActual) = puntoActual; %Agrego el punto inicial

end




