function init()

global C c R cost_matrix points orders P N Cn 

Cn = 4;
C = [8 8 8 8];
c = [1 1 1 1];
R = [8 8 8 8];
P = [1 2];

x = 1;
y = 1;

N = 300;

[cost_matrix points] = generate_matrix(N, Cn, x, y);
orders = generate_orders(N, Cn, false, 1);


end %init
