% CISC 330 assignment 2 pt. 4
% Testing superSphere function
% Lauren Yates 10195969

% This test is used to test the validity of the superSphere function using
% a provided ground truth

% the center point of the ellipsoid/tumor points
center = [0;0;0];
points = generateEllipsoidPts(center,1,2,3,100);

% the projected tumor points when C-arm is rotated 0 degrees and 90 degrees
deg0Tum = tumorProjector(0,points);
deg90Tum = tumorProjector(90,points);

% the radius of the super sphere surrounding all the tumor points in C-arm
% coordinates
radius = superSphere([0,90],deg0Tum,deg90Tum);

% plot the generated points of the ellipsoid and the calculated super
% sphere
transPoints = points.';
figure();
hold on;
title('Ellipsoid Points and Super Sphere');
xlabel('X-Axis');
ylabel('Y-Axis');
zlabel('Z-Axis');
scatter3(transPoints(:,1),transPoints(:,2),transPoints(:,3),'filled');
graphSphere(center,radius);
hold off;
