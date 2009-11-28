%plik glowny
clc;
clear all;
close all;

%paramery symulacji
max_iteration = 200; %liczba iteracji
n = 1;              %liczba ciezarowek
size = 30;          %rozmiar miasta
workers = 50;      %liczba robotnic w populacji
scouts = 10;        %liczba zwiadowcow
paths_count = 3;    %liczba wybieranych dróg - musi byæ mniejsza od zwiadowców

%[cost_matrix x y] = real_gen(size,n);   %generator macierzy kosztow
load('cost_matrix_test.mat');          %wczytanie macierzy kosztow

%parametry wyswietlania
show_markers = 0;   %pokazuje rozk³ad rozwi¹zañ wzglêdem zwiadowców
show_avr = 1;       %pokazuje œredni¹ wartoœæ najlepszego zwiadowcy
show_path = 1;      %pokazuje najlepsz¹ trasê na grafie 3D
time_delay = 0.01;  %opóŸnienie miêdzy iteracjami



hold on;
grid on;
title('Current best value and scout value');

best_solution_val = inf;
marker_index = 1;
potential_paths = [];
paths_values = [];
scouts_markers  = [];
avr = [];

%1. Inicjalizacja populacji za pomoc¹ losowych rozwi¹zañ.
for i=1:scouts
    potential_paths = [potential_paths random_solution(size,n)'];
    scouts_markers = [scouts_markers  marker_index];
    marker_index = marker_index+1;
end
best_scout=inf;

%2. Wyliczenie funkcji celu dla populacji.
for i=1:scouts
    tmp = goal(potential_paths(:,end-i+1),n,size,cost_matrix);
    if(best_scout>tmp) best_scout=tmp;end;
    paths_values = [paths_values tmp];
end
figure(1);
plot(0,best_scout,'bo');

%3. While (kryterium stopu nie spe³nione) //Tworzenie nowej populacji.
%%%%%%%%%%%%%%%%%%%%%%%%%%%% PETLA GLOWNA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for step=1:max_iteration
    clc;
    display('Postêp:');
    display(floor(100*step/max_iteration));
    
    %4.   Wybór najlepszych miejsc do przeszukiwania s¹siedztwa.
    best_paths = [];
    best_paths_values = [];
    best_markers = [];
    for i=1:paths_count
        [v index] = min(paths_values);
        best_paths = [best_paths potential_paths(:,index)];
        best_paths_values = [best_paths_values v];
        best_markers = [best_markers scouts_markers(index)];
        paths_values(index) = inf;
    end

    %Werbunek pszczó³ dla wybranych miejsc (proporcjonalnie do najlepszych miejsc + sta³a wartoœæ 1)
    workers = workers - paths_count;
    recruited_workers = [];
    val_per_worker = sum(best_paths_values-min(best_paths_values))/workers;
    if(val_per_worker==0)
        for i=1:paths_count
            recruited_workers = [recruited_workers 1+round(workers/paths_count)];
        end
    else
        for i=1:paths_count
            recruited_workers = [recruited_workers 1+floor((best_paths_values(i)-min(best_paths_values))/val_per_worker)];
        end
    end
    recruited_workers(1) = recruited_workers(1)+workers - sum(recruited_workers);
    workers = workers + paths_count;

    %Badanie przez pozosta³e pszczo³y s¹siedztwa ( ponowne wyliczanie funkcji celu )
    potential_paths = best_paths;
    paths_values = best_paths_values;
    for i=1:paths_count
        for j=1:recruited_workers(i)
            scouts_markers = [scouts_markers scouts_markers(i)];
            potential_paths = [potential_paths get_neighbour(best_paths(:,i),n) ]; % czy droga moze sie powtarzac?
            paths_values = [paths_values goal(potential_paths(:,end),n,size,cost_matrix)];
        end
    end

    %Nowi zwiadowcy
    for i=1:scouts
        potential_paths = [potential_paths random_solution(size,n)'];
        scouts_markers  = [scouts_markers  marker_index];
        marker_index = marker_index+1;
    end
    best_scout=inf;
    for i=1:scouts
        tmp = goal(potential_paths(:,end-i+1),n,size,cost_matrix);
        if(best_scout>tmp) best_scout=tmp;end;
        paths_values = [paths_values tmp];
    end

    figure(1);
    plot(step,best_scout,'bo');

    %Usuniecie powtorzonych tras
    for i=1:length(paths_values)
        tmp = paths_values(i);
        for j=1:i
            if(i==j) continue; end;
            if(paths_values(i)==paths_values(j))
                paths_values(i)=inf;
            end
        end
    end
    for i=1:length(paths_values)
        if( paths_values(i)==inf)
            paths_values = [paths_values(1:i-1) paths_values(i+1:end)];
            potential_paths = [potential_paths(:,1:i-1) potential_paths(:,i+1:end)];
        end
        if(i+1>length(paths_values)) break; end;
    end

    %Wybór najlepszego rozwi¹zania.
    if(show_markers==1)
        for i=1:paths_count
            figure(best_markers(i)+2);
            grid on;
            plot(step,best_paths_values(i),'r.');
            hold on;
            title(strcat('Marker numer: ',num2str(best_markers(i))));
        end
    end
    
    figure(1);
    grid on;
    hold on;
    title('Best solution and scout value');
    xlabel('Step number');
    ylabel('Goal function');
    subplot(2,1,1);
    plot(step,min(best_paths_values),'r.');

    %wybór i rysowanie najlepszej trasy
    if(show_path==1)
        [v index] = min(best_paths_values);
        if(v<best_solution_val)
            best_solution = best_paths(:,index);
            best_solution_val = v;
            x_sol = [];
            y_sol = [];
            for i=1:length(best_solution)
                x_sol = [x_sol x(best_solution(i))];
                y_sol = [y_sol y(best_solution(i))];
            end
            figure(2);
            plot3(x_sol,y_sol,1:length(x_sol),'g-');
            hold on;
            plot3(x_sol,y_sol,1:length(x_sol),'b.');
            title('Best solution graph');
            xlabel('x');
            ylabel('y');
            zlabel('Move number');
            axis([0 1 0 1 1 length(x_sol)]);
            grid on;
            hold off;
        end;
    end;

    %liczenie sredniej z najlepszych zwiadow
    if(show_avr==1)
        avr = [avr best_scout];
        figure(1);
        subplot(2,1,2);
        hold off;
        plot([0 step],[sum(avr)/step sum(avr)/step],'g');
        hold on;
        plot(1:step,avr,'b.');
        grid on;
        title('Best scout / step');
        xlabel('Step number');
        ylabel('Goal function');
        subplot(2,1,1);
        pause(time_delay);
    end;    
end;
%9. End FOR.
max(best_paths_values)



