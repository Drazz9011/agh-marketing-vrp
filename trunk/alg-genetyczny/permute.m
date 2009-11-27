function Y = permute(X, change)
% Permutacja wybranych genów chromosomu X.
% Wektor change zawiera pozycje wybranych genow.

Y = X;
len = length(change);

%permit_order = 1:N+2;
order = permute(randperm(len));

% X = 1 2 3 4 5 6 7 8 9
% c = 6 3 2
% o = 2 3 6
% Y = 1 6 3 4 5 2 7 8 9

for i = 1:len,
	Y(change(i))= X(order(i));
end

end %permute