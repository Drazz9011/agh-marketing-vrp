function [XX QQ] = generate(Ws)
% function [XX QQ] = generate(size, N, sigma, delta, mi)
% Generuje populacje osobnikow.
%   N - dlugosc chromosomu
%   Ws - wielkosc populacji
%   sigma - czestosc [narodzin, mutacji]
%   delta - odchylka [narodzin, mutacji]
%   
% Zwracana jest populacja XX oraz wektor przystosowania QQ.

global C c R cost_matrix points h orders P N Cn
len = N+Cn;

% XX(Ws, N) = 0;
XX = [];
QQ = [];

for i = 1:Ws,
    X = randperm(len);
    XX = [XX; X];
    QQ = [QQ, quality(X)];
end

end %generate