% CISC 330 Assignment 1 pt. 1
% Distance of a line and point 
% Lauren Yates 10195969

% This function takes two points of a line and another separate point and
% calculates and returns the distance from the point to the line

% INPUT
% v1 - first point of the line
% v2 - second point of the line
% p - given separate point not associated with the line

% OUTPUT
% dist - the distance between the line and the point

function dist = DistanceofLineandPoint(v1, v2, p)

% a is the vector of the line given
a = v1 - v2;
% b is the vector of a line connecting v2 of the line and the point
b = p - v2;
% dist is the perpendicular distance from point p to the line
% have the hypotenuse (b) and one side (a), dist is 3rd side of the
% triangle
% the cross product of a and b is perpendicular to both if they are
% linearly independent
% the norm calculates the euclidean length of the vector given
% dividing the norm of the perpendicular line from cross(a,b) by the
% norm(a) gives the ordinary/euclidean perpendicular distance of the point to the line
dist = norm(cross(a,b))/norm(a);