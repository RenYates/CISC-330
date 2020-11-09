% % CISC 330 Assignment 2 pt. 3
% Tumor Projector Test
% Lauren Yates 10195969

% This testing function tests the validity of the tumorProjector function
% using provided ground truths.

% Ground truth 1: Project a Sphere with center [0;0;0] and radius = 3

pts = generateEllipsoidPts([0;0;0],3,3,3,100);
hold on
title('Sphere Tumor Projection 3D');
xlabel('X-Axis');
ylabel('Y-Axis');
zlabel('Z-Axis');
projected = tumorProjector(0,pts);
hold off

figure();
hold on
title('Sphere Tumor Projection 2D');
xlabel('X-Axis');
ylabel('Y-Axis');
zlabel('Z-Axis');
plot(projected(1,:).',projected(2,:).');
hold off

% Ground Truth 2: Project an Ellipsoid centered at [0;0;0], with principle
% axes a=1 b=2 c=3 at 0 and 90 degree projection angles
pts = generateEllipsoidPts([0;0;0],1,2,3,100);
proj0 = tumorProjector(0,pts);
figure();
hold on
title('Ellipsoid Tumor Projection 2D: 0 Degrees');
xlabel('X-Axis');
ylabel('Y-Axis');
zlabel('Z-Axis');
plot(proj0(1,:).',proj0(2,:).');
hold off

proj90 = tumorProjector(90,pts);
figure();
hold on
title('Ellipsoid Tumor Projection 2D: 90 Degrees');
xlabel('X-Axis');
ylabel('Y-Axis');
zlabel('Z-Axis');
plot(proj90(1,:).',proj90(2,:).');
hold off

