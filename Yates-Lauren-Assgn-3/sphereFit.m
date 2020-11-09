% CISC 330 Assignment 3
% Lauren Yates 10195969
% Sphere Fit

% This function takes a set of data points and returns the center and
% the radius of the sphere that best fits the points given using QR
% decomposition.

% INPUT
% points: an Nx3 array of points to be fitted to a sphere

% OUTPUT
% center: the center of the sphere fit to the set of points
% radius: the radius of the sphere fit to the set of points
function [center,radius] = sphereFit(points)
[N,~] = size(points);
pointsT = points.';

% create M matrix
neg2points = (-2) * points;
M = [neg2points ones(N,1)];

% create b vector
b = zeros(N,1);
for i = 1:N
    b(i,1) = dot((-1)*pointsT(:,i),pointsT(:,i));
end

% solve for y using QR decomposition of M and b
[Q,R] = qr(M,0);
y = (Q.')*b;

% use the back substitute function to calculate x and the new center point
x = backsub(R,y);
center = round(x(1:3,1),10);

% calculate the radius of the circle using the calculated sigma from
% backsub
sigma = x(4,1);
radius = sqrt(dot(center,center) - sigma);

end