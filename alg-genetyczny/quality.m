function Q = quality(X, C, c, R, cost_matrix, request_vector, P)
% Funkcja oceny jakosci chromosomu X
%   r - wektor wejsciowy
%   C - wektor pojemnosci ciezarowek
%   c - wektor kosztow ciezarowek
%   R - wektor maksymalnego czasu jazdy ciezarowek
%   cost_matrix - macierz kosztow
%   request_vector - wektor wielkosci zamowien
%   P = [przeladowanie, nadgodziny] - wspolczynniki kary - opcjonalnie 

len = length(X);	% Dlugosc chromosomu
N = length(C);		% Liczba ciezarowek

Q = 0;
first = 0;
car = 0;
L = 0;	% Car load
r = 0;	% Length of route

for i = 1:len,	% Find first car
	if X(i) <= N,
		car = X(i);	% Select car
		first = i;	% Select first car position
		break
	end
end

X = [X(first:), X(:first)];	% Rotate chromosome X and close cycle

for i = 1:len,
	%Q = Q + c(car)*cost_matrix(X(i),X(i+1));
	
	if X(i) <= N,	% Car is back in magazine
		Q = Q + c(car)*r;	% Add cost of transport using actual car
		if L > C(car),	% Add punishment for exceeding car load capacity
			Q = Q + P(1)*(L - C(car));
		end
		if r > R(car),	% Add punishment for exceeding maximum length of car route (worktime)
			Q = Q + P(2)*(r - R(car));
		end
		car = X(i);	% Select new car
		L = 0;
		r = 0;
	else
		L = L+request_vector(i);	% Actualize load
		r = r + cost_matrix(X(i),X(i+1));	% Actualize length of route
	end
end

end