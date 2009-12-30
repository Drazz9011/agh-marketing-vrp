function gen_test()

global gen_S

[X Q] = gen_init(100);
show_route_step(Q, X, true);

figure(2); hold off;
plot(Q, '.r'); hold on;
plot(gen_S);

for i=1:200,
    [X Q1] = gen_step();
    Q = [Q Q1];
    figure(2); hold off;
    plot(Q, '.r'); hold on;
    plot(gen_S);
    show_route_step(Q1, X, true);
end

% figure(2); hold off;
% plot(Q, '.r'); hold on;
% plot(gen_S);
% show_route_step(Q, X, true);
end %gen_test