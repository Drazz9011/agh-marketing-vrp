function couple = parent_selection(Ws)

% global C c R cost_matrix points h orders P N Cn
% len = N+Cn;

couple = [0 0];
for i = 1:2,
    while couple(i) == 0,
        couple(i) = ceil(rand* Ws);
    end
end

end %parent_selection