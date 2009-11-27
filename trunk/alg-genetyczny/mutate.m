function Y = mutate(X, N)
% Proces mutacji N+2 losowych genów chromosomu X.
% N >= 0. Mutuje N+2 losowych genów, nastepuje ich losowa permutacja. Permutacja tozsamosciowa jest zabroniona.

len = length(X);
change = randperm(len)(:N+2);  % Wybierz N+2 losowych genow

Y = permute(X, change);

% %permit_order = 1:N+2;
% mutate_order = permute(randperm(N+2));

% Y = X;

% % X = 1 2 3 4 5 6 7 8 9
% % c = 6 3 2
% % o = 2 3 6
% % Y = 1 6 3 4 5 2 7 8 9

% for i = 1:N+2,
	% Y(change(i))= X(mutate_order(i));
% end

end %mutate