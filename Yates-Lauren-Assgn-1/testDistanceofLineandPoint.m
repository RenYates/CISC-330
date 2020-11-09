% CISC 330 Assignment 1 pt. 1
% Distance of a line and point 
% Lauren Yates 10195969

% This testing file tests the validity of the DistanceofLineandPoint
% function using ground truths

% Test Case 1: Line and point intersect
v11 = [0;0;0];
v12 = [2;2;2];
p1 = [1;1;1];
dist1 = DistanceofLineandPoint(v11, v12, p1);

% Test Case 2: Line and point do not intersect
v21 = [0;1;0]; 
v22 = [1;1;0];
p2 = [2;2;0];
dist2 = DistanceofLineandPoint(v21, v22, p2);

% Plot Test Case 1
line1 = [v11.'; v12.'];
figure();
plot3(line1(:,1),line1(:,2),line1(:,3));
hold on;
scatter3(p1(1),p1(2),p1(3));
hold off;

% Plot Test Case 2
line2 = [v21.';v22.'];
figure();
plot3(line2(:,1),line2(:,2),line2(:,3));
hold on;
scatter3(p2(1),p2(2),p2(3));