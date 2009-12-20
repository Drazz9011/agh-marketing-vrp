function show_route_step(Q, X, change)
% Pokazuje wybrana marszrute na mapie

global Cn N cost_matrix points h
len = N + Cn;

if ~change,
    return
end

route = zeros(Cn, len);
distance = zeros(1,Cn);

first = 0;
for i = 1:len,	% Find first car
	if X(i) <= Cn,
		first = i;	% Select first car position
		break
	end
end

if first == 1,  % Zawin sciezke tak, zeby zaczynala sie od wyjazdu ciezarowki z magazynu
    Y = X;
else
    Y = [X(first:len), X(1:first-1)];
end

i = 1;
while i<=len,
    if Y(i) <= Cn,
		car = Y(i);	% Select car
    end
    distance(car) = distance(car) + 1;
    route(car, distance(car)) = Y(i);
    i = i+1;
end
%figure(h);
%hold on;
figure(1); hold off;
plot(points(Cn+1:end,1), points(Cn+1:end,2), '.b'); % Wyrysuj polozenia klientow
hold on;
plot(points(1,1), points(1,2), 'or');   % Wyrysuj magazyn
%hold off;
colors = ['mcyrgbk'];
col = 1;

for i = 1:Cn,
    if distance(i)>1,
        xx = zeros(distance(i)+1);
        yy = xx;
        for k = 1:distance(i),
            xx(k) = points(route(i,k), 1);
            yy(k) = points(route(i,k), 2);
        end
        xx(distance(i)+1) = points(i, 1);
        yy(distance(i)+1) = points(i, 2);
        plot(xx, yy, ['-' colors(col)]);
        col = col+1; if col > 7, col = 1; end
    end
end
hold off;

end %show_route_step