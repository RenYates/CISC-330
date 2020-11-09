% CISC 330 Assignment 4
% Lauren Yates 10195969
% Draw_3D_Scene

% This function takes the head of the patient, the PTV, OAR, Isocenter
% point, and Dose Box as input and draws a 3D scene mapping them into one
% plot for visualization. This function uses smaller functions and calls
% them to plot each object separately and then puts them on the same graph.

% INPUT
% head_a: the x-axis radius of the head (single value)
% head_b: the y-axis radius of the head (single value)
% head_c: the z-axis radius of the head (single value)
% head_cent: the center point of the head (3x1 matrix)
% PTV_rad: the radius of the ptv sphere (single value)
% PTV_center: the center of the ptv sphere (3x1 matrix)
% OAR_rad: the radius of the oar sphere (single value)
% OAR_center: the center of the oar sphere (3x1 matrix)
% isocent: the center location of the helmet (3x1 matrix)
% lowerLeft: the lowest left most point of the dose box (3x1 matrix)
% upperRight: the highest right most point of the dose box (3x1 matrix)

% OUTPUT
% N/a

function Draw_3D_Scene(head_a, head_b, head_c, head_cent,PTV_rad,PTV_center,OAR_rad,OAR_center,isocent,lowerLeft,upperRight)

hold on;
xlabel('X-Axis');
ylabel('Y-Axis');
zlabel('Z-Axis');
title('3D Scene Plot');
% plot the head
graphEllipsoid(head_cent,head_a,head_b,head_c,'y');

% plot the PTV
graphSphere(PTV_center,PTV_rad,'r');

% plot the OAR
graphSphere(OAR_center,OAR_rad,'b');

% plot the isocenter point
scatter3(isocent(1),isocent(2),isocent(3),'m','filled');

% plot the dose box
graphBox(lowerLeft,upperRight);


