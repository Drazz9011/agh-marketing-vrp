function [XX QQ] = genetic_algorithm(Ws, iter)

[XX QQ] = generate(Ws);
births = ceil(Ws/5);
mutations = ceil(Ws/20);
swaps = ceil(Ws/20);
switches = ceil(Ws/20);

best = zeros(1, iter+1);
for iteration = 1:iter,
    [XX QQ] = rank(XX, QQ);
    best(iteration) = QQ(1);
    XX = XX(1:Ws, :);
    QQ = QQ(1:Ws);
    for i = 1:births,
        couple = parent_selection(Ws);
        [X1 X2] = cross(XX(couple(1), :), XX(couple(2), :), ceil(rand*5));
        XX = [XX; X1; X2];
        QQ = [QQ quality(X1) quality(X2)];
    end
    if iteration > iter/2, mutations = ceil(Ws/10); end
    for i = 1:mutations,
        X1 = mutate(XX(ceil(rand*Ws),:), ceil(rand*4));
        XX = [XX; X1];
        QQ = [QQ quality(X1)];
    end
    for i = 1:swaps,
        X1 = swap2(XX(ceil(rand*Ws),:));
        XX = [XX; X1];
        QQ = [QQ quality(X1)];
    end
    for i = 1:switches,
        X1 = switchpoint(XX(ceil(rand*Ws),:));
        XX = [XX; X1];
        QQ = [QQ quality(X1)];
    end
end
[XX QQ] = rank(XX, QQ);
best(iter+1) = QQ(1);

result = figure();
plot(1:iter+1, best, '.r');

show_route(XX(1, :));
disp(XX(1, :));
% disp(['Q = ' QQ(1)]);
QQ(1)

end %genetic_algorithm