function Y = permute_vector(X, P)
% Permutuje macierz welug zadanej kolejnosci

len = length(X);
if len == length(P),
    Y = zeros(1, len);
    for i = 1:len,
        Y(i) = X(P(i));
    end
end

end %permute_vector