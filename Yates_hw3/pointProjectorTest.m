% CISC 330 Assignment 2 pt. 2
% Point Projector Test
% Lauren Yates 10195969

% This testing file is used to test the validity of the pointProjector
% function using ground truths and plot visualization.

% Ground Truth 1: Rotate point [0;0;0] 0 degrees
figure();
hold on
title('Point Projector Test 1: Rotate Point [0;0;0] 0 Degrees');
xlabel('X-Axis');
ylabel('Y-Axis');
zlabel('Z-Axis');
proj = pointProjector(0,[0;0;0])
hold off

% Ground Truth 2: Rotate point [1;1;1] 90 degrees
figure();
hold on
title('Point Projector Test 2: Rotate Point [1;1;1] 90 Degrees');
xlabel('X-Axis');
ylabel('Y-Axis');
zlabel('Z-Axis');
proj = pointProjector(90,[1;1;1])
hold off

% Ground Truth 3: Rotate point [1;1;1] 45 degrees
figure();
hold on
title('Point Projector Test 3: Rotate Point [1;1;1] 45 Degrees');
xlabel('X-Axis');
ylabel('Y-Axis');
zlabel('Z-Axis');
proj = pointProjector(45,[1;1;1])
hold off

% Ground Truth 4: Rotate point [0;1;0] -30 degrees
figure();
hold on
title('Point Projector Test 4: Rotate Point [0;1;0] -30 Degrees');
xlabel('X-Axis');
ylabel('Y-Axis');
zlabel('Z-Axis');
proj = pointProjector(-30,[0;1;0])
hold off

% Ground Truth 5: Rotate point [0;1;0] 330 degrees
figure();
hold on
title('Point Projector Test 5: Rotate Point [0;1;0] 330 Degrees');
xlabel('X-Axis');
ylabel('Y-Axis');
zlabel('Z-Axis');
proj = pointProjector(330,[0;1;0])
hold off


