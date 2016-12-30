function preds = prediccion2(tracks,tracksPre1,tracksPre2)
%Inicialmente, tomo lo mas facil. Estimo velocidad con los 2 anteriores.
%Si alguno de los anteriores no esta definido (= -1) la prediccion es que
%se queda quieto

N = size(tracks,1); %Cant. de tracks
preds = ones(N,2)*(-1); %Por las dudas pongo el valor de "indefinido"

for i=1:N
    if(tracksPre1(i,1)==-1 || tracksPre2(i,1)==-1)
        preds(i,:) = tracksPre1(i,:);
    else
        preds(i,:) = tracksPre1(i,:) + (tracksPre1(i,:) - tracksPre2(i,:));
    end
end

