% CISC 330 Assignment 1 pt. 4
% back substitution function
% Lauren Yates 10195969

function x = backsub(R,y)
[~,m] = size(R);
x = zeros(m,1);
x(m) = y(m)/R(m,m);
for i = (m-1):-1:1
    x(i) = (y(i)-R(i,i+1:m)*x(i+1:m))./R(i,i);
end
end

