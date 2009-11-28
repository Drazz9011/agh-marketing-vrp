function g=goal(r,n,size,cost_matrix)
    g = 0;
    r=r';
    for i=1:size+n-2
       g = g + cost_matrix(r(i),r(i+1));        
    end
    g = g+cost_matrix(r(end),1);
end