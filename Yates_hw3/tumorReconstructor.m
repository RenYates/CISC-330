% CISC 330 Assignment 2 pt. 5
% Tumor Reconstructor
% Lauren Yates 10195969

% This function takes a vector of imaging angles and an array of tumor
% silhouettes and returns an array of triangles defining the tumor surface
% and the volume of the tumor using the convex hull matlab function
% convhull.

% INPUT
% angles = an array of rotation angles of the C-arm
% varargin = a variable argument that intakes arrays of tumor silhouettes
% at the corresponding given angles

% OUTPUT
% K = an array of triangles defining the tumor surface
% V = tumor volume

function [K,V] = tumorReconstructor(angles, varargin)

num = nargin-1;
centers = zeros(3,num);
for i = 1:num
    % center point of tumor silhouettes is approximately the mean of all the
    % points
    sil = varargin{i};
    center = (mean(sil.')).';
    % convert center in detector coordinates to center in C-arm coordinates
    x = round(center(1),10);
    y = round(center(3)-75,10);
    z = round(center(2),10);
    centers(:,i) = [x;y;z];
end

lines = zeros(3,2*num);
index = 1;
for i = 1:num
    % find the rotation matrix about the z-axis for the current angle
    rot = [cosd(angles(:,i)),-sind(angles(:,i)), 0;sind(angles(:,i)),cosd(angles(:,i)), 0; 0,0,1];
    % rotate the source by the rotation angle
    source = rot*[0;75;0];
    centers(:,i) = rot*centers(:,i);
    lines(:,index) = centers(:,i);
    lines(:,index+1) = source;
    index = index + 2;
end

% if only one tumor silhouette is given or if 2 lines are given where they
% are parallel then use the intersection of the line(s) and the plane
% instead for an approximation of the center
if length(angles) == 1
    normal = source - [0;0;0];
    tumCenter = plane_line_intersect(normal,[0;0;0],source,centers);
elseif length(angles) == 2
    normal1 = lines(:,2) - [0;0;0];
    tumCenter1 = plane_line_intersect(normal1,[0;0;0],lines(:,2),lines(:,1));
    normal2 = lines(:,4) - [0;0;0];
    tumCenter2 = plane_line_intersect(normal2,[0;0;0],lines(:,4),lines(:,3));
    tumCenter = (tumCenter1+tumCenter2)/2;
else
    % tumCenter is the approximate center of the tumor calculated by the
    % intersection of all the lines
    [tumCenter, ~,~] = IntersectNLines(num,lines);
end

radius = superSphere(angles,varargin{1:num});

% check to see what voxels are in the Super Sphere
% if they are in the super sphere then add them to inSphere matrix
inSphere = [];
for x = (-1*radius):0.1:radius
    for y = (-1*radius):0.1:radius
        for z = (-1*radius):0.1:radius
            if (x-tumCenter(1,:))^2/radius + (y-tumCenter(2,:))^2/radius +(z-tumCenter(3,:))^2/radius <= 1
                % add the current point in the cube to the matrix if it's
                % in the sphere
                inSphere = horzcat(inSphere,[x;y;z]);
            end
        end
    end
end

% create an empty matrix to hold all voxels that are in the tumor
inTumor = [];
for i = 1:length(inSphere)
    notIn = 0; % set not in to false
    for j = 1:num
        point = pointProjector(angles(:,j),inSphere(:,i));
        tumorProj = varargin{j};
        in = inpolygon(point(1),point(2),tumorProj(1,:),tumorProj(2,:));
        if in == 0 % if the voxel is not in the tumor, set notIn to true (1)
            notIn = 1;
        end 
    end
    if notIn == 0
        inTumor = horzcat(inTumor,inSphere(:,i));
    end
end

[K,V] = convhull(inTumor(1,:).',inTumor(2,:).',inTumor(3,:).');

hold on;
trisurf(K,inTumor(1,:).',inTumor(2,:).',inTumor(3,:).');
hold off;
end