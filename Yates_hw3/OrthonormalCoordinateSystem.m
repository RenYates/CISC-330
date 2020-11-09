% CISC 330 Assignment 1 pt. 7
% Orthonormal Coordinate System
% Lauren Yates 10195969

% This function takes 3 points (a, b, and c) and calculates the orthonormal 
% coordinate system of that triangle

% INPUT
% a - first point from triangle
% b - second point from triangle
% c - third point from triangle

% OUTPUT
% x - x vector base
% y - y vector base
% z - z vector base

function [x, y, z, ctr] = OrthonormalCoordinateSystem(a, b, c)

% the center of the orthonormal vector base is at the center of gravity
% the center of gravity is equal to the unweighted average of the three
% points
ctr = (a + b + c)/3;
% X is the line AB
% need to find two other pairwise orthogonal vectors, use cross product to
% calculate vectors that are perpendicular to each other
X = b-a;
Z = cross(X,(c-a));
Y = cross(Z,X);

%normalize X Y and Z to their unit length vectors for the coordinate system
x = X/norm(X);
y = Y/norm(Y);
z = Z/norm(Z);