% CISC 330 Assignment 2 pt. 2
% Point Projector
% Lauren Yates 10195969

% This function takes a rotation angle alpha and a given point in C-arm
% coordinates and calculates the location of the point on the detector
% plane in detector coordinates (where the w axis = 0). Instead of rotating
% the plane and source, the function rotates the given point in the opposite
% direction and calculates the intersection of that new rotated point.
% Mathematically these results are the same, and this method avoids the
% need for calculating and transforming coordinate systems.

% INPUT
% alpha = rotation angle in degrees
% point = a given point in C-arm coordinates

% OUTPUT
% Q = the given point translated onto the detector plane (in detector
% coordinates)

function Q = pointProjector(alpha,point)
% take the negative angle to rotate the body instead of the c-arm
negA = -1*alpha;

% calculate the rotation matrix for this angle rotating around the z-axis
rot = [cosd(negA),-sind(negA), 0;sind(negA),cosd(negA), 0; 0,0,1];

% apply this rotation matrix to the given point
rotP = rot*point;

% translation vector is also the center point for the detector 
% use this vector to move the point onto the detector
trans = [0;-75;0];

% source point is 75 cm above the origin in the y axis
source = [0;75;0];

% detector plane normal is a vector that is perpendicular to the plane
% since the plane is parallel to the floor, then the normal is
% perpendicular to the floor (therefore directly above the center point in
% the y axis
normal = [0;1;0];

% the following plane_line_intersect function is written by Nassim Khaled
% and has been sourced from MathWorks File Exchange
% https://www.mathworks.com/matlabcentral/fileexchange/17751-straight-line-and-plane-intersection
[inter,~] = plane_line_intersect(normal,trans,source,rotP);

% swap axis for u v and w where w=0
u = round(inter(1),10);
v = round(inter(3),10);
w = round((inter(2) + 75),10); % make w=0 instead of -75
Q = [u;v;w];

% rotS = rot*source; % rotated source point
% rotM = rot*trans; % rotated transformation/detector point
% rotN = rot*normal; % rotated normal to detector
% rotI = rot*inter; % rotated intersection point
%  scatter3([rotS(1);rotP(1);rotI(1)],[rotS(2);rotP(2);rotI(2)],[rotS(3);rotP(3);rotI(3)]);
%  plot3([rotS(1);rotI(1)],[rotS(2);rotI(2)],[rotS(3);rotI(3)]);
% % this circle plot function is sourced from MathWorks and is written by Andreas
% % Schmid
% % https://www.mathworks.com/matlabcentral/fileexchange/44047-plot-a-circle-in-3d
%  circle_3D(15,rotM,rotN);
end