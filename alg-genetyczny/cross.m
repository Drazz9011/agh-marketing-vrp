function [Y1, Y2] = cross(X1, X2, N)
% Procedura krzyzowania N-punktowa chromosomow X1, X2.
% |X1| = |X2|, N >=1.

X = [X1; X2];
len = length(X1);

cr = [sort(randperm(len-1)(:N))+1, len+1];	% N random points of crossing, last point is to avoid array overriding.

% X = [ 1 2 3 4 5 6 7 8 9;
%       5 6 7 8 9 1 2 3 4];
% c =     2 3     6      10
% P =   0 1 0 0 0 1 1 1 1
% Y = [ 1 6 3 4 5 1 2 3 4;
%       5 2 7 8 9 6 7 8 9];

Y = X;

last = 1;
val = 1;
for i = 1:len,	% Crossing
	if i = cr(last),
		val = -val;
		last = last+1;
	end
	if val = 1,
		Y(i,1) = X(i,2);
		Y(i,2) = X(i,1);
	end
end

Y1 = fixchromosome(Y(:,1));	% Deleting repetitions
Y2 = fixchromosome(Y(:,2));

end	%cross

