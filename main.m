clc;
clear all;
close all;
addpath alg-pszczeli;
addpath gen;
addpath mrowkowy;

% ZADANIE PROBLEMU %
global n size cost_matrix type;
max_iter = 140;%maksymalna ilosc iteracji
n = 3; %ilosc ciezarowek
size = 20; %rozmiar miasta
global N Cn
Cn = n;
N = size;
type = 1;% typ funkcji celu od 0 do 2 - odsylam do quality.m

[cost_matrix points] = generate_matrix(size, n);
%%%%%%%%%%%%%%%%%%%%





% INICJALIZACJE ALGORYTMOW %
%algorytm pszczeli INIT
BEE_routes=[];
BEE_q=[];
BEE_time=[];
bee_init(cost_matrix,n,1000,500,200);

%algorytm mrowkowy INIT
ANT_routes=[];
ANT_q=[];
ANT_time=[];
ant_init(cost_matrix, n, inf, 2, 10.0,   1, 0.3, 1, 4.0,  1, 200, Inf);
%                    Cie,poj,bet,al1,  al2, ro, g1,  g2, g3, pop, popr

%algorytm genetyczny INIT
GEN_routes=[];
GEN_q=[];
GEN_time=[];
gen_init(100);
%%%%%%%%%%%%%%%%%%%%%%%%%%%





% GLOWNA PETLA ALGORYTMOW %
for k=1:max_iter
    %algorytm pszczeli STEP     
    tic;
    [best_route best_q] = bee_step; 
    BEE_time = [BEE_time toc];
    BEE_routes = [BEE_routes best_route];
    BEE_q = [BEE_q best_q];
    
    show_path( 1, best_route, points, n,0,'Best BEE algorithm solution graph');
    set(1,'Position',[0 0 704 772]);
    
    figure(2);
    hold on;
    title('Best solution graph');
    xlabel('Iteration');
    ylabel('Quality function');
    plot(BEE_q,'.b');
    set(2,'Position',[721 421 704 354]);
    grid on;
    hold off;
    
    figure(3);
    hold on;
    title('Step time graph / Cumulative time');
    xlabel('Iteration');
    ylabel('Time [s]');
    plot(BEE_time,'.b');
    plot(k,sum(BEE_time),'.b');
    set(3,'Position',[718 49 704 284]);
    grid on;
    
    %algorytm mrowkowy STEP
    %[najlepsze_rozw najlepsza_wartosc] = ant_step;
     
    tic;
    for ANT_k = 1:30
        [best_route best_q] = ant_step; 
    end;
    ANT_time = [ANT_time toc];
    ANT_routes = [ANT_routes best_route'];
    ANT_q = [ANT_q best_q];
    
    show_path( 5, best_route', points, n,0,'Best ANT algorithm solution graph');
    set(5,'Position',[0 0 704 772]);
    
    figure(2);
    hold on;
    title('Best solution graph');
    xlabel('Iteration');
    ylabel('Quality function');
    plot(ANT_q,'.g');
    set(2,'Position',[721 421 704 354]);
    grid on;
    hold off;
    
    figure(3);
    hold on;
    title('Step time graph / Cumulative time');
    xlabel('Iteration');
    ylabel('Time [s]');
    plot(ANT_time,'.g');
    plot(k,sum(ANT_time),'.g');
    set(3,'Position',[718 49 704 284]);
    grid on;

    %algorytm genetyczny STEP
%     if(false)
        
    tic;
    [best_route best_q] = gen_step; 
    GEN_time = [GEN_time toc];
    GEN_routes = [GEN_routes best_route];
    GEN_q = [GEN_q best_q];
    
    show_path( 4, best_route', points, n,0,'Best GEN algorithm solution graph');
    set(4,'Position',[0 0 704 772]);
    
    figure(2);
    hold on;
    title('Best solution graph');
    xlabel('Iteration');
    ylabel('Quality function');
    plot(GEN_q,'.r');
    set(2,'Position',[721 421 704 354]);
    grid on;
    hold off;
    
    figure(3);
    hold on;
    title('Step time graph / Cumulative time');
    xlabel('Iteration');
    ylabel('Time [s]');
    plot(GEN_time,'.r');
    plot(k,sum(GEN_time),'.r');
    set(3,'Position',[718 49 704 284]);
    grid on;
%     end;
    %%%%%%%%%%%%%%%%%%%%%%%%%
    pause(0.01);
end;

