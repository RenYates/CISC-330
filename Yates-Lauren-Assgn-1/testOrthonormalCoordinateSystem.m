% CISC 330 Assignment 1 pt. 7
% Orthonormal Coordinate System
% Lauren Yates 10195969

% This testing file is used to test the validity of the
% OrthonormalCoordinateSystem function using two ground truths

% Ground truths for these tests have been calculated on paper

% Test 1
a = [0;0;0];
b = [1;0;0];
c = [0;1;0];

[x1, y1, z1, ctr1] = OrthonormalCoordinateSystem(a, b, c);

% Test 2
d = [-2;-2;0];
e = [2;-2;0];
f = [-2;4;0];

[x2, y2, z2, ctr2] = OrthonormalCoordinateSystem(d, e, f);
