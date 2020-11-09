% CISC 330 Assignment 4
% Lauren Yates 10195969
% Compute Linear Function Test

% this testing function uses two points and an incrementing x value to test
% the validity of the Compute_Linear_Function function. The associated x
% and calculated y values are then printed in a table for visualization
% purposes.

% the two points to form the line
P1 = [1;1];
P2 = [5;5];
% establish a 7x2 matrix to hold x and y values
xs_ys = zeros(7,2);
% calculate the y value for every x value from {0,1,2,...,6} and store them
% in the matrix
for x = 0:6
    y = Compute_Linear_Function(P1,P2,x);
    xs_ys(x+1,1) = x;
    xs_ys(x+1,2) = y;
end

% plot the x and y values in a table for visualization
form_table = table(xs_ys(:,1),xs_ys(:,2),'VariableNames',{'x_value','y_value'});
disp(form_table);