function gen_test()

[X Q] = gen_init(100);
show_route_step(Q, X, true);

    figure(2); hold off;
    plot(Q, '.r');
    show_route_step(Q, X, true);

for i=1:1000,
    [X Q1] = gen_step();
    Q = [Q Q1];
    figure(2); hold off;
    plot(Q, '.r');
    show_route_step(Q1, X, true);
end

end %gen_test