% CISC 330 Assignment 4
% Lauren Yates 10195969
% Compute_Linear_Function

% This function takes two points (P1 and P2) and an x value as input. It
% computes a linear equation using the two points to calculate the linear
% equation and returns the calculated y value when x is inputted to the
% equation y = mx + b.

% INPUT
% P1: first point of the linear equation line (2x1 matrix)
% P2: second point of the linear equation line (2x1 matrix)
% x: the x value of a point on the line (single value)

% OUTPUT
% y: the y value associated with the x value of a point on the line (single
%    value)

function y = Compute_Linear_Function(P1,P2,x)

% Calculate the slope: (y2-y1)/(x2-x1)
m = (P2(2)-P1(2))/(P2(1)-P1(1));

% Calculate the y-intercept: b = y - (m*x)
b = P1(2) - (m*P1(1));

% Calculate y given 
y = (m*x) + b;

end