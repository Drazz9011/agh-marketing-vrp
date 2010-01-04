function sciezka = ant_przemarsz(graf, L, feromon, par)

% graf - graf z wagami krawêdzi
% L - wektor ciê¿aru ³adunków do poszczególnych wêz³ów
% feromon - macierz feromonów na krawêdziach
% par - parametry symulacji

mrowka.Li = par.poj;
mrowka.odw = 0;
mrowka.sciezka = [];


[blad cel] = krok_mrowka(graf, L, feromon, mrowka, par);

%aktualizacja danych po zwyk³ym przejœciu do nastêpnego wêz³a
%licznik mrowka.odw zlicza tylko wêz³y w³aœciwe (nie magazyny)
while (strcmp(blad,'ok'))
    mrowka.sciezka = [mrowka.sciezka cel];
    if (cel <= par.C)
        mrowka.Li = par.poj;
    else
        mrowka.Li = mrowka.Li - L(cel);
        mrowka.odw = mrowka.odw + 1;
    end
    
    [blad cel] = krok_mrowka(graf, L, feromon, mrowka, par);
end

if (strcmp(blad,'koniec trasy'))
    sciezka = [1 mrowka.sciezka 1];
    return;
end

sciezka = [];

