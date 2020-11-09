% CISC 330 Assignment 4
% Lauren Yates 10195969
% Test_Compute_Radial_Distance

% This file tests the validity of the Compute_Radial_Distance function
% using two known ground truths that were calculated on paper.

% Ground Truth Test 1
% point 1 of line: (0,0,0)
% point 2 of line: (2,2,0)
line_1 = [0,2;0,2;0,0];

% point is a point on the line
pt_1 = [1;1;0];

% the distance from the center line of the beam and the point should be
% zero as the point is on the line
dist_1 = Compute_Radial_Distance(pt_1,line_1);
fprintf('The Distance between the line (0,0,0) to (2,2,0) and the point (1,1,0) is %.4f\n',dist_1);

% Ground Truth Test 2
% point 1 of line: (0,0,0)
% point 2 of line: (0,5,0)
line_2 = [0,0;0,5;0,0];

% point is 5 mm away from the center line of the beam
pt_2 = [5;3;0];

dist_2 = Compute_Radial_Distance(pt_2,line_2);
fprintf('The Distance between the line (0,0,0) to (0,5,0) and the point (5,3,0) is %.4f\n',dist_2);