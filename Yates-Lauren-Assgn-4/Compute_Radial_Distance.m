% CISC 330 Assignment 4
% Lauren Yates 10195969
% Compute_Radial_Distance

% This function takes a point (3x1 matrix) and a line (3x2 matrix) and
% calculates the distance from the point to the line.

% INPUT
% pt: the point to calculate the distance from the line (3x1 matrix)
% line: the line used to calculate the distance from the pt to the line
%       (3x2 matrix)

% OUTPUT
% distance: the distance between the line and the point (single value)

function distance = Compute_Radial_Distance(pt,line)
pt1 = line(:,1);
vec = line(:,2);
% calculate the direction vector of the line using the two points
pt2 = pt1+vec;
% calculate the distance from the line to the point
distance = DistanceofLineandPoint(pt1,pt2,pt);
end