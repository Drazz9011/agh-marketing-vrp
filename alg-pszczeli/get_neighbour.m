function new_r = get_neighbour( r,n )


a=2+round(rand*(length(r)-2));
b=a;
new_r = r;
while(a==b) 
    b=2+round(rand*(length(new_r)-2));
end;

tmp = new_r(a);
new_r(a)=new_r(b);
new_r(b) = tmp;

inx = 1;

for i=1:length(new_r)
    if(new_r(i)<=n)
       new_r(i) = inx;
       inx = inx +1;
    end    
end

end

