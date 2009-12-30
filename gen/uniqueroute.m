function [YY Q1] = uniqueroute(XX, QQ)

[rows, cols] = size(XX);
YY = [];
Q1 = [];
for i=1:rows-1,
    if QQ(i) ~= QQ(i+1),
        if XX(i,:) == XX(i+1,:),
        else
            YY = [YY; XX(i,:)];
            Q1 = [Q1 QQ(i)];
        end
    end
end

if YY(end,:) == XX(rows,:),
else
    YY = [YY; XX(rows,:)];
    Q1 = [Q1 QQ(rows)];
end

end %uniqueroute