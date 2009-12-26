clc;
clear all;
n=2;
[M points] = generate_matrix(10, n);
global x y;
x = points(:,1);
y = points(:,2);


cd alg-pszczeli

a=[];
b=[];

bee_init(M,n);
 
for k=1:40
[tmpa tmpb] = bee_step; 
a = [a tmpa];
b = [b tmpb];
end;
cd ..
show_path( 1, tmpa, points, n)