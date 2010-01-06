function Q = quality(X)
% Funkcja oceny jakosci chromosomu X

first = 0;
for i = 1:length(X),	% Find first car
	if X(i) == 1,
		first = i;	% Select first car position
		break
	end
end
if first ~= 1,  % Zawin sciezke tak, zeby zaczynala sie od wyjazdu ciezarowki z magazynu
    X = [X(first:end); X(1:first-1)];
end

dir = pwd;
cd ..

Q = quality(X);

cd(dir);

% %   r - wektor wejsciowy
% %   C - wektor pojemnosci ciezarowek
% %   c - wektor kosztow ciezarowek
% %   R - wektor maksymalnego czasu jazdy ciezarowek
% %   cost_matrix - macierz kosztow
% %   orders - wektor wielkosci zamowien
% %   P = [przeladowanie, nadgodziny] - wspolczynniki kary - opcjonalnie 
% 
% global C c R cost_matrix orders P
% 
% len = length(X);	% Dlugosc chromosomu
% Cn = length(C);		% Liczba ciezarowek
% 
% first = 0;
% car = 0;
% for i = 1:len,	% Find first car
% 	if X(i) <= Cn,
% 		car = X(i);	% Select car
% 		first = i;	% Select first car position
% 		break
% 	end
% end
% 
% X = [X(first:end), X(1:first)];	% Rotate chromosome X and close cycle
% 
% Q = 0;
% L = 0;	% Car load
% r = 0;	% Length of route
% 
% for i = 1:len+1,
% 	%Q = Q + c(car)*cost_matrix(X(i)X(i+1));
% 	if X(i) <= Cn,	% Car is back in magazine
% 		Q = Q + c(car)*r;	% Add cost of transport using actual car
% 		if L > C(car),	% Add punishment for exceeding car load capacity
% 			Q = Q + P(1)*(L - C(car));
% 		end
% 		if r > R(car),	% Add punishment for exceeding maximum length of car route (worktime)
% 			Q = Q + P(2)*(r - R(car));
% 		end
% 		car = X(i);	% Select new car
% 		L = 0;
% 		r = 0;
% 	else
% 		L = L + orders(X(i));	% Actualize load
% 		r = r + cost_matrix(X(i), X(i+1));	% Actualize length of route
% 	end
% % 	disp ([X(i) car Q L r])
% end

end