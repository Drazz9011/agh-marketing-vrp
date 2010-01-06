function [XX QQ] = generate(Ws)
% function [XX QQ] = generate(Ws)
% Generuje populacje osobnikow.
%   Ws - wielkosc populacji
%   
% Zwracana jest populacja XX oraz wektor przystosowania QQ.

global N Cn
len = N+Cn-1;

XX = [];
QQ = [];

for i = 1:Ws,
    X = randperm(len)+1;
    XX = [XX; X];
    QQ = [QQ, gen_quality(X)];
end

end %generate