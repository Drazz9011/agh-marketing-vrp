function sciezka = ant_przemarsz(graf, L, feromon, par)

% graf - graf z wagami kraw�dzi
% L - wektor ci�aru �adunk�w do poszczeg�lnych w�z��w
% feromon - macierz feromon�w na kraw�dziach
% par - parametry symulacji

mrowka.Li = par.poj;
mrowka.odw = 0;
mrowka.sciezka = [];


[blad cel] = krok_mrowka(graf, L, feromon, mrowka, par);

%aktualizacja danych po zwyk�ym przej�ciu do nast�pnego w�z�a
%licznik mrowka.odw zlicza tylko w�z�y w�a�ciwe (nie magazyny)
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

