function [najlepsze_rozw najlepsza_wartosc] = ant_step

global ANT_iteracja ANT_iteracja_poprawa ANT_poprawa ANT_k ANT_populacja;
global ANT_fer ANT_ro ANT_ferIt ANT_M ANT_L ANT_par ANT_najlepszy_koszt;
global ANT_najlepsza_sc;

%sprawdzenie warunku przerwania algorytmu
%Je�li jest spe�niony, wykonujemy krok
if ((ANT_iteracja-ANT_iteracja_poprawa) <= ANT_poprawa)

    %Je�li przesz�a ju� ca�a populacja (ANT_k = ANT_populacja)
    %to zako�czenie poprzedniej du�ej interacji i inicjalizacja nast�pnej
    if (ANT_k >= ANT_populacja)
        %parowanie
        ANT_fer = (1 - ANT_ro)*ANT_fer + ANT_ferIt;
        ANT_ferIt = zeros(size(ANT_M));
        ANT_iteracja = ANT_iteracja + 1;
        ANT_k = 0;
    end

    %Przej�cie mr�wki przez graf
    sc = ant_przemarsz(ANT_M, ANT_L, ANT_fer, ANT_par);
    ANT_k = ANT_k + 1;

    %je�li mr�wka dotar�a do celu:
    %  1.naniesienie feromonu
    %  2.sprawdzenie, czy rozwi�zanie jest najlepsze
    %je�li nie dotar�a:
    %  
    if ~(isempty(sc))
        koszt_sc = quality2(sc(1:end-1));
        dawka = 1/koszt_sc;
        for i = 1:(max(size(sc))-1)
            ANT_ferIt(sc(i),sc(i+1)) = ANT_ferIt(sc(i),sc(i+1)) + dawka;
            %ferIt(sc(i+1),sc(i)) = ferIt(sc(i+1),sc(i)) + dawka;
        end
        if (koszt_sc < ANT_najlepszy_koszt)
            ANT_najlepszy_koszt = koszt_sc;
            ANT_najlepsza_sc = sc;
            ANT_iteracja_poprawa = ANT_iteracja;
        end
    end
   %zwr�cenie wyniku
   najlepsze_rozw = ANT_najlepsza_sc(1:end-1);
   najlepsza_wartosc = ANT_najlepszy_koszt;    

%Nie wykonujemy kroku
else
    najlepsze_rozw = [];
    najlepsza_wartosc = []; 
end