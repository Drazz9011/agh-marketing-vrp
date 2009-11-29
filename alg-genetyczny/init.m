%function init()

global C c R cost_matrix points h orders P N Cn

Cn = 4;
C = [8 8 8 8];
c = [1 2 1 3];
R = [8 8 8 8];
P = [0 0];

x = 1;
y = 1;

N = 10;

[cost_matrix points h] = generate_matrix(N, Cn, x, y);
orders = generate_orders(N, Cn, false, 1);


%end %init


