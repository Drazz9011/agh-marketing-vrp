function [XX QQ] = genetic_algorithm(Ws, iter)
figure(2); close(2);
[XX QQ] = generate(Ws);
births = ceil(Ws/5);
mutations = ceil(Ws/20);
swaps = ceil(Ws/10);
switches = ceil(Ws/10);
lastQ = Inf;
best = zeros(1, iter+1);
for iteration = 1:iter,
    [XX QQ] = rank(XX, QQ);
    [XX QQ] = uniqueroute(XX, QQ);
    best(iteration) = QQ(1);
    XX = XX(1:Ws, :);
    QQ = QQ(1:Ws);
    if lastQ == QQ(1), change = false; else change = true; end
    %figure(1); hold off;
    show_route_step(QQ(1), XX(1,:), change);
    figure(2); hold on;
    plot(iteration, best(iteration), '.r');
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

%result = figure();
figure(2); hold on;
%plot(1:iter+1, best, '.r');
plot(iter+1, best(iter+1), '.r');

show_route_step(QQ(1), XX(1, :), true);
disp(XX(1, :));
% disp(['Q = ' QQ(1)]);
QQ(1)

end %genetic_algorithm