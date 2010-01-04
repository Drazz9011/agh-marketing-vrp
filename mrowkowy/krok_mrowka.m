function [blad, cel] = krok_mrowka(graf, L, feromon, mrowka, par)

%graf - graf z wagami wszystkich krawedzi, osobny wêze³
%       ka¿dej ciê¿arówki
%feromon - tablica feromonów dla ka¿dej krawêdzi
%L - wektor ciê¿arów paczek dla poszczególnych wêz³ów
%mrowka - rekord zmiennych okreœlaj¹cych stan mrówki
%par - rekord parametrów symulacji
%
%blad - 'koniec trasy' jesli trasa jest juz kompletna
%       'dead' jest mrowka weszla w œlepy zau³ek i umar³a
%       'ok' wybrano nastêpny wêze³ grafu
%cel - wybrany wêze³ grafu. Ma sens, jeœli blad 'ok'

if (mrowka.odw >= par.N)
    blad = 'koniec trasy';
    cel = -1;
    return;
end

%przygotowanie listy celów, 1. Punkty jeszcze nie odwiedzone
%wybrane spoœród wêz³ów grafu
lista = (par.C+1):(par.C+par.N);
lista = setdiff(lista, mrowka.sciezka);

%przygotowanie listy celów
%2. zlokalizowanie i dodanie nastêpnego magazynu (ciê¿arówki)
lista_magazynow = intersect(1:(par.C), mrowka.sciezka);
if isempty(lista_magazynow)
    lista = [2 lista];
elseif (max(lista_magazynow)+1) <= par.C
    lista = [max(lista_magazynow)+1 lista];
end

%przygotowanie listy celów, 3. Punkty wymagaj¹ce zbyt wiele pojemnoœci
zbyt_ciezkie = [];
for i = (par.C+1):(par.C+par.N)
    if (L(i) > mrowka.Li)
        zbyt_ciezkie = [zbyt_ciezkie i];
    end
end
lista = setdiff(lista, zbyt_ciezkie);

%lista jest pusta, œlepy zau³ek
if isempty(lista)
    blad = 'dead';
    cel = -1;
    return;
end

%obliczenie wag prawdopodobieñstwa, loc - aktualne po³o¿enie mrówki
if isempty(mrowka.sciezka)
    loc = 1;
else
    loc = mrowka.sciezka(end);
end
wagi_lista = [];
for i = lista
    if (graf(loc,i) > 0)
        waga = (1.0 + par.alfa1*feromon(loc,i)^par.alfa2)/graf(loc,i)^par.beta; 
    else
        waga = par.gamma1 + par.gamma2*feromon(loc,i)^par.gamma3;
    end
    wagi_lista = [wagi_lista waga];
end

index = rand_wagi(wagi_lista);
cel = lista(index);
blad = 'ok';



    



