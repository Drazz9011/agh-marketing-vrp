clc;
clear all;
close all;
addpath alg-pszczeli;

% ZADANIE PROBLEMU %
global n size cost_matrix type;
max_iter = 150;%maksymalna ilosc iteracji
n = 3; %ilosc ciezarowek
size = 20; %rozmiar miasta
type = 1;% typ funkcji celu od 0 do 2 - odsylam do quality.m

[cost_matrix points] = generate_matrix(size, n);
%%%%%%%%%%%%%%%%%%%%





% INICJALIZACJE ALGORYTMOW %
%algorytm pszczeli INIT
BEE_routes=[];
BEE_q=[];
BEE_time=[];
bee_init(cost_matrix,n,600,100,50);

%algorytm mrowkowy INIT
%TODO

%algorytm genetyczny INIT
%TODO
%%%%%%%%%%%%%%%%%%%%%%%%%%%





% GLOWNA PETLA ALGORYTMOW %
for k=1:max_iter
    %algorytm pszczeli STEP     
    tic;
    [best_route best_q] = bee_step; 
    BEE_time = [BEE_time toc];
    BEE_routes = [BEE_routes best_route];
    BEE_q = [BEE_q best_q];
    
    show_path( 1, best_route, points, n,0);
    set(1,'Position',[0 -251 704 772]);
    
    figure(2);
    hold on;
    title('Best solution graph');
    xlabel('Iteration');
    ylabel('Quality function');
    plot(BEE_q,'.b');
    set(2,'Position',[725 167 704 354]);
    grid on;
    hold off;
    
    figure(3);
    hold on;
    title('Step time graph / Cumulative time');
    xlabel('Iteration');
    ylabel('Time [s]');
    plot(BEE_time,'.b');
    plot(k,sum(BEE_time),'.r');
    set(3,'Position',[725 -238 704 320]);
    grid on;
    
    %algorytm mrowkowy STEP
    %TODO

    %algorytm genetyczny STEP
    %TODO

    pause(0.01);
end;

