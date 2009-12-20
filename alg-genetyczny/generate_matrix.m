function [M points] = generate_matrix(N, Cn, x, y)

points = [x*rand(N+1,1), y*rand(N+1,1)];    % Wylosuj wspolrzedne 1 magazynu i N klientow

Nc = N+Cn;  % Okresl wielkosc macierzy kosztow

M = Inf * eye(Nc);  % Utworz macierz grafu bez petli
if Cn > 1,  % Dopelnianie tablicy wspolrzednych
    Mpt = [ones(Cn-1, 1)*points(1,1), ones(Cn-1, 1)*points(1,2)];   % Kopiowanie wspolrzenej magazynu Cn razy
    points = [Mpt; points];   % Dopelnienie tablicy wspolrzednych
end

for i = 1:Nc-1, % Obliczenie kosztow na krawedziach grafu
    for j=i+1:Nc,
       M(i,j) = sqrt(norm((points(i,:)-points(j,:))));
       M(j,i) = M(i,j);
    end
end

end