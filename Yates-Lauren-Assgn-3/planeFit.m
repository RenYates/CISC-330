% CISC 330 Assignment 3
% Lauren Yates 10195969
% Plane Fit

% This function takes a set of data points and returns a point on the plane 
% and the normal of the plane that best fits the points given.

% INPUT 
% ABCs: an Nx3 array of points to be fit to a plane

% OUTPUT
% pt: a point on the plane (the average of all the points in ABCs
% normal: the normal vector to the plane

function [pt, normal] = planeFit(ABCs,N)

% get the mean of the points for a point on the plane
sum1 = zeros(3,1);
for i = 1:N
sum1 = sum1 + ABCs(:,i);
end
pt = sum1./N;

% establish Z
Z = zeros(3,3);

% find all zj values and fill Z
 for j = (1:N)
    zj = ABCs(:,j)-pt;
    z = zj * zj.';
    Z = Z + z;
 end

% find the eigenvalues of Z
[eigvecZ,eigvalZ] = eig(Z);

val1 = eigvalZ(1:1);

spot = 1;

% find the smallest eigenvalue in Z
for i = 2:3
    if eigvalZ(i:i) < val1
        val1 = eigvalZ(i:i);
        spot = i;
    end
end

% use the corresponding eigenvector from the smallest eigenvalue
n1 = eigvecZ(:,spot);

% take the norm of the normal to make it a unit vector
normal = n1/norm(n1);