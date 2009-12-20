function [XX QQ] = generate(Ws)
% function [XX QQ] = generate(Ws)
% Generuje populacje osobnikow.
%   Ws - wielkosc populacji
%   
% Zwracana jest populacja XX oraz wektor przystosowania QQ.

global N Cn
len = N+Cn;

XX = [];
QQ = [];

for i = 1:Ws,
    X = randperm(len);
    XX = [XX; X];
    QQ = [QQ, quality(X)];
end

end %generate