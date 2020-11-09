% CISC 330 assignment 2 pt. 4
% Ellipsoid Points Generator
% Lauren Yates 10195969

% This function takes the measurements of an ellipsoid and a number of
% points (N) to be generated and calculates N points on the ellipsoid
% surface.

% INPUT
% center = center of the ellipsoid
% a = principle axis of ellipsoid
% b = principle axis of ellipsoid
% c = principle axis of ellipsoid
% N = number of points on ellipsoid surface to be generated

% OUTPUT
% points = an array of size 3:N containing the generated points on the
% surface of the ellipsoid

function points = generateEllipsoidPts(center,a,b,c,N)
points = zeros(3,N);

for i = 1:N
    
    % first angle: -180 to 180 (xy)
    ang1Min = -180;
    ang1Max = 180;

    % randomly generate angle for x y plane
    ang1 = (ang1Max - ang1Min).*rand + ang1Min;

    % second angle: -90 to 90 (z)
    ang2Min = -90;
    ang2Max = 90;

    % randomly generate angle for positive z plane
    ang2 = (ang2Max - ang2Min).*rand + ang2Min;

    % transform the spherical coordinates (angles) into cartesian coordinates
    % use a b and c as the radius for each coordinate of the new point to
    % be on the surface (not the same radius for each direction x y z
    % because it's an ellipsoid not a sphere)
    x = a .* cosd(ang1) .* cosd(ang2);
    y = b .* cosd(ang1) .* sind(ang2);
    z = c .* sind(ang1);
    
    point = [x; y; z];
    point = point + center;
    points(:,i) = point;
end
