% CISC 330 Assignment 1 pt. 5
% Sphere Reconstruction
% Lauren Yates 10195969

% This function takes a center of a sphere and the radius, the number of
% points being generated, and the maxOff value which is the maximum
% distance a point can be away from the radius (inside or outside the given
% sphere). This function generates a random set of points using the maxOff
% and N provided and uses those points to reconstruct a new sphere,
% creating a center and a radius. The error metric is then calculated by
% calculating the distance between the sphere and all random points generated 
% and finding the average dist and std of those distances.

% INPUT
% ctr - center point of the given sphere
% rad - radius of the given sphere
% N - the number of random points to be generated
% maxOff - the maximum off value for how far off the generated points can
%          be from the radius of the sphere

% OUTPUT
% center - the center of the new reconstructed sphere
% radius - the radius of the new reconstructed sphere
% dist - the average distance between the sphere and the randomly generated
%        points
% stdev - the standard deviation of the distances between the sphere and
%         the randomly generated points

function [center, radius, dist, stdev] = sphereReconstruction(ctr, rad, N, maxOff)

points = zeros(N,3);

for i = 1:N
    
    % calculate the shifted radius to give a maxOff range of pos or neg 
    % maxOff from the actual radius 
    radMin = rad - maxOff;
    radMax = rad + maxOff;
    newRad = (radMax - radMin).*rand + radMin;
    
    % first angle: -180 to 180 (xy)
    ang1Min = -180;
    ang1Max = 180;

    % randomly generate angle for x y plane
    ang1 = (ang1Max - ang1Min).*rand + ang1Min;

    % second angle: 0 to 90 (z)
    ang2Min = 0;
    ang2Max = 90;

    % randomly generate angle for positive z plane
    ang2 = (ang2Max - ang2Min).*rand + ang2Min;

    % transform the spherical coordinates (angles) into cartesian coordinates
    % to calculate the components of a new random point within maxOff

    x = newRad .* cosd(ang2) .* cosd(ang1);
    y = newRad .* cosd(ang2) .* sind(ang1);
    z = newRad .* sind(ang2);
    
    point = [x y z];
    point = point + ctr.';
    points(i,:) = point;
end
pointsT = points.';
if maxOff == 0 || maxOff == 10
    figure();
    hold on;
    scatter3(points(:,1),points(:,2),points(:,3));
    title('Sphere Reconstruction: Generated Points');
    xlabel('X-axis');
    ylabel('Y-axis');
    zlabel('Z-axis');
    hold off;
end

% SPHERE RECONSTRUCTION
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

% calculate the distance from the new radius to the points
distM = zeros(1,N);
for i = 1:N
    d = abs(DistTwoPoints3D(points(i,:).',center) - radius);
    distM(:,i) = d;
end
% calculate the average distance and standard deviation for error
dist = round(mean(distM),10);
stdev = round(std(distM),10);

end