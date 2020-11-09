% CISC 330 Assignment 2 pt. 4
% Super Sphere Construction
% Lauren Yates 10195969

% This function takes an array of angles and an unknown (varying) number of
% tumor silhouette arguments and calculates the radius of the super sphere
% covering these points around the center in C-arm coordinates. The radius
% is divided by 2 to make it the correct length to fit the tumor (similar
% triangles).

% INPUT
% angles = an array of rotation angles for the tumour silhouettes provided
% varargin = a variable input of tumour silhouettes in detector coordinates
% on the detector plane

% OUTPUT
% radius = the radius of the super sphere surrounding the tumor points in
% C-arm coordinates

function radius = superSphere(angles,varargin)
% nargin counts the total number of arguments being inputted
% subtract 1 to not include angles argument in total
num = nargin-1;
% create an array/list to hold the maximum distances for each angle
dists = zeros(1,num);
% loop through each set of tumour silhouettes for all angles
for i = 1:num
    % pts is the tumour silhouette provided for the current imaging angle
    pts = varargin{i};
    % build a list to hold the distances from each point to the center of
    % the detector
    dists1 = zeros(1,length(pts));
    % center is the center translated in detector coordinates using the
    % angle for this projection
    center = pointProjector(angles(:,i),[0;0;0]);
    for j = 1:length(pts)
        % calculate the distances from the center in detector coordinates
        % and the given tumor silhouette points and add them to a list
        dists1(:,j) = DistTwoPoints3D(pts(:,j),center);
    end
    % add the maximum distance to the list of distances
    dists(:,i) = max(dists1);
end
% find the maximum distance from a detector point to the center of the
% detector in any angle
% divide that distance by 2 to make it the length of the radius for the
% supersphere that will cover all points (similar triangles)
radius = ((max(dists))/2);
end
