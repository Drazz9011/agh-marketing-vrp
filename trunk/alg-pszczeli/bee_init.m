function bee_init(matrix,c)
clc;
global cost_matrix n gen_size workers scouts paths_count best_solution_val show_avr show_path;
global time_delay potential_paths paths_values step;

n=c;
cost_matrix = matrix;
step=0;
gen_size = length(cost_matrix)-n+1;

%[cost_matrix x y] = real_gen(gen_size,n);   %generator macierzy kosztow

workers = 400;      %liczba robotnic w populacji
scouts = 150;        %liczba zwiadowcow
paths_count = 50;    %liczba wybieranych dróg - musi byæ mniejsza od zwiadowców
best_solution_val = inf;

%save('cost_matrix_test.mat', 'cost_matrix','gen_size', 'x', 'y', 'n');
%load('cost_matrix_test.mat');          %wczytanie macierzy kosztow

%parametry wyswietlania
show_avr = 1;       %pokazuje œredni¹ wartoœæ najlepszego zwiadowcy
show_path = 1;      %pokazuje najlepsz¹ trasê na grafie 3D
time_delay = 0.01;  %opóŸnienie miêdzy iteracjami

%1. Inicjalizacja populacji za pomoc¹ losowych rozwi¹zañ.
for i=1:scouts
    potential_paths = [potential_paths random_solution(gen_size,n)'];
end
best_scout=inf;

%2. Wyliczenie funkcji celu dla populacji.
for i=1:scouts
    tmp = goal(potential_paths(:,end-i+1),n,gen_size,cost_matrix);
    if(best_scout>tmp) best_scout=tmp;end;
    paths_values = [paths_values tmp];
end

%3. While (kryterium stopu nie spe³nione) //Tworzenie nowej populacji.
%prealokacja
