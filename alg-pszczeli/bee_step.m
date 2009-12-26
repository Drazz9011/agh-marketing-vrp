function [out_best_solution out_best_solution_val] = bee_step
%BEE_STEP Summary of this function goes here
%   Detailed explanation goes here

global cost_matrix avr n gen_size workers scouts paths_count x y best_solution best_solution_val show_avr show_path;
global time_delay potential_paths paths_values step;

%%%%%%%%%%%%%%%%%%%%%%%%%%%% PETLA GLOWNA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
step=1+step;
    
    %4.   Wybór najlepszych miejsc do przeszukiwania s¹siedztwa.
    best_paths_values = zeros(1, paths_count);
    best_paths = zeros(gen_size+n-1, paths_count);
    for i=1:paths_count
        [v index] = min(paths_values);
        best_paths(:,i) = potential_paths(:,index);
        best_paths_values(i) = v;
        paths_values(index) = inf;
    end

    %Werbunek pszczó³ dla wybranych miejsc (proporcjonalnie do najlepszych miejsc + sta³a wartoœæ 1)
    %workers = workers - paths_count;
    val_per_worker = sum(best_paths_values-min(best_paths_values))/workers;
    recruited_workers = zeros(1,paths_count);
    if(val_per_worker==0)
        for i=1:paths_count
            recruited_workers(i) = 1+round(workers/paths_count);
        end
    else
        for i=1:paths_count
            recruited_workers(i) = 1+floor((best_paths_values(i)-min(best_paths_values))/val_per_worker);
        end
    end
    %recruited_workers(1) = recruited_workers(1)+workers - sum(recruited_workers);
    %workers = workers + paths_count;

    %Badanie przez pozosta³e pszczo³y s¹siedztwa ( ponowne wyliczanie funkcji celu )
    potential_paths = best_paths;
    paths_values = best_paths_values;
    for i=1:paths_count
        for j=1:recruited_workers(i)
            potential_paths = [potential_paths get_neighbour(best_paths(:,i),n) ]; % czy droga moze sie powtarzac?
            paths_values = [paths_values goal(potential_paths(:,end),n,gen_size,cost_matrix)];
        end
    end

    %Nowi zwiadowcy
    current_length = length(paths_values);
    potential_paths = [potential_paths zeros(gen_size+n-1,scouts)];
    for i=1:scouts
        potential_paths(:,current_length+i) = random_solution(gen_size,n)';
    end
    best_scout=inf;
    paths_values = [paths_values zeros(1,scouts)];
    for i=1:scouts
        tmp = goal(potential_paths(:,end-i+1),n,gen_size,cost_matrix);
        if(best_scout>tmp) best_scout=tmp;end;
        paths_values(current_length+i) = tmp;
    end

    
    %Usuniecie powtorzonych tras
    for i=1:length(paths_values)
        tmp = paths_values(i);
        for j=1:i
            if(i==j); continue; end;
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
        if(i+1>length(paths_values)); break; end;
    end

    %wybór i rysowanie najlepszej trasy
	[v index] = min(best_paths_values);
	if(v<best_solution_val)
        best_solution = best_paths(:,index);
        best_solution_val = v;
	end;


    
    out_best_solution = best_solution;
    out_best_solution_val = best_solution_val; 
    
    
    



