function [X Q] = gen_step()
% Krok algorytmu genetycznego.
% Zwraca:
% X   - najlepsza dotychczas trase
% Q   - ocene najlepszej trasy
%
% Przed pierwszym wywolaniem gen_step nalezy wykonac gen_init.

global gen_Ws gen_births gen_mutations gen_swaps switches gen_XX gen_QQ gen_S

% Do cross operation
for i = 1:gen_births,
    couple = parent_selection(gen_Ws);
    [X1 X2] = cross(gen_XX(couple(1), :), gen_XX(couple(2), :), ceil(rand*5));
    gen_XX = [gen_XX; X1; X2];
    gen_QQ = [gen_QQ quality(X1) quality(X2)];
end

% Do random mutation
for i = 1:gen_mutations,
    X1 = mutate(gen_XX(ceil(rand*gen_Ws),:), ceil(rand*4));
    gen_XX = [gen_XX; X1];
    gen_QQ = [gen_QQ quality(X1)];
end

% Do swap mutation
for i = 1:gen_swaps,
    X1 = swap2(gen_XX(ceil(rand*gen_Ws),:));
    gen_XX = [gen_XX; X1];
    gen_QQ = [gen_QQ quality(X1)];
end

% Do switch mutation
for i = 1:switches,
    X1 = switchpoint(gen_XX(ceil(rand*gen_Ws),:));
    gen_XX = [gen_XX; X1];
    gen_QQ = [gen_QQ quality(X1)];
end

% Sort population
[gen_XX gen_QQ] = rank(gen_XX, gen_QQ);
% Eliminate repeated routes
[gen_XX gen_QQ] = uniqueroute(gen_XX, gen_QQ);
% Reduce population's size
gen_XX = gen_XX(1:gen_Ws, :);
gen_QQ = gen_QQ(1:gen_Ws);

X = gen_XX(1,:);
Q = gen_QQ(1);

gen_S = [gen_S mean(gen_QQ)];

end %gen_step