% CISC 330 Assignment 2 pt. 3
% Tumor Projector
% Lauren Yates 10195969

% This function takes an array of tumor points given in C-arm coordinates
% and creates an array of the projected points in detector coordinates
% using the PointProjector function. The function then removes any points
% that are in the shadow and returns the edges as an array of tumor points.

% INPUT
% angle = the current imaging angle for the tumour
% pts = an array of tumor points given in C-arm coordinates (x,y,z)

% OUTPUT
% tumorContour = an array of the tumour points on the detector plane in 
% detector coordinates (u,v,w=0)

function tumorContour = tumorProjector(angle,pts)

% get the number of columns (points) in array of tumor points in C-arm
% coordinates (x,y,z)
[~,n] = size(pts);
% establish an empty array of tumor contour points in detector coordinates
% (u, v, w=0)
tumorPts = zeros(3,n);
% loop through each point in the given array in C-arm coordinates and use
% PointProjector function to calculate the point in detector coordinates
% figure();
% hold on
for i = 1:n
    newpt = pointProjector(angle,pts(:,i));
    % add the calculated detector coordinate to the tumorContour array
    tumorPts(:,i) = newpt;
end
% hold off

% find the edges/contour of the tumor using convhull
edges = convhull(tumorPts(1,:).',tumorPts(2,:).');

% the contour of the tumor is the edges of the projection
tumorContour = tumorPts(:,edges);

end