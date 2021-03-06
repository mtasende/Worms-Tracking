function tracks = tracking4(centroides)

%Tracks en una matriz de dim=3. La tercer entrada es el numero de frame
%Cuando el track no esta activo se pone x=-1.
%Los valores x=-1 solo pueden estar al principio y al final del track

radioCuadratico = 2500;

T = length(centroides);

%Primero asigno todos los centroides a un track
tracks(:,:,1) = centroides{1};
tracksActivos(:,:,1) = tracks(:,:,1); %Todos son activos, al principio
indiceActivo = 1:size(tracks,1);%Para modificar en tracks
pred = tracks(:,:,1); % Se predicen los mismos centroides para t=1, porque no hay anteriores
perdidos = zeros(size(tracks,1),1); %Para llevar la cuenta de cuanto llevan perdidos los tracks.
tolerancia = 5; %Cuanto rato lo aguanto perdido

for t = 2:T
    
    N = size(tracksActivos,1);
    dists = matrizDist(pred,centroides{t});
    
    %Uso el algoritmo hungaro para la asignacion
    [listaAgregados,costo]=munkres(dists);
    %Asigno los que hayan quedado bien
    for i = 1:N
        if(listaAgregados(i) ~= 0)
            %Me fijo que no de un salto muy grande...
            distParticular = dists(i,listaAgregados(i));
            if(distParticular > radioCuadratico)
                tracks(indiceActivo(i),:,t) = pred(i,:); %Lo pongo como la prediccion
                perdidos(indiceActivo(i)) = perdidos(indiceActivo(i)) +1; %Sigue perdido...
            else
                tracks(indiceActivo(i),:,t) = centroides{t}(listaAgregados(i),:);
                perdidos(indiceActivo(i)) = 0; %Lo encontre!
            end
        else
            tracks(indiceActivo(i),:,t) = pred(i,:); %Si no se asigno, lo pongo como la prediccion
            perdidos(indiceActivo(i)) = perdidos(indiceActivo(i)) +1; %Sigue perdido...
        end
        
        %Si un track se sale de la pantalla, pasa a ser -1
        
        %Si un track esta perdido hace mucho, lo mato
        if(perdidos(indiceActivo(i))>=tolerancia)
            tracks(indiceActivo(i),:,t) = [-1 -1];
            %disp(['se perdio el ' num2str(indiceActivo(i))])
        end
    end
    
    %Los centroides no agregados generan nuevos tracks (por ahora; se puede mejorar)
    jAAgregar = setdiff(1:size(centroides{t},1),listaAgregados);
    %Por ahora agrego de a uno, se puede mejorar
    for k=1:length(jAAgregar)
        tracks = agregarTrack(tracks,centroides{t}(jAAgregar(k),:),t);
        perdidos = [perdidos;0];
    end
    
    %Refinar estimacion
    
    
    %Los tracks que estan en -1 quedan en -1 para siempre, y no entran
    %al analisis
    clear tracksActivos indiceActivo
    j=1;
    for k=1:size(tracks,1)
        if(tracks(k,1,t) ~= -1)
            tracksActivos(j,:) = tracks(k,:,t);
            indiceActivo(j) = k;%Para modificar en tracks
            j=j+1;
        else
            tracks(k,:,t+1) = [-1 -1]; %Queda en -1 para siempre
        end
    end
    
    %perdidos
    %tracks(:,:,t)
    %Hacer las nuevas predicciones
    pred = tracksActivos;
    %keyboard
    %pred = prediccion(tracksActivos,t+1);
end

tracks = tracks(:,:,1:T);

end %function

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




