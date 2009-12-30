function O = generate_orders(N, Cn, Random, weight)
% Funkcja tworzy wektor zamowien dla N klientow, przy wykorzystaniu Cn ciezarowek.
% Zamowienia maja wartosc (ciezar) losowa, lub stala, w zaleznosci od ustawienia parametru Random.
% Wartosc oczekiwana ciezaru przesylek okreslona jest przez parametr weight.

if Random,
    O = [zeros(1,Cn), rand(1, N)*weight*2];
else
    O = [zeros(1,Cn), ones(1, N)*weight];
end

end