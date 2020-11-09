% CISC 330 Assignment 4
% Lauren Yates 10195969
% Compute_Dose_Box function

% this function takes the PTV and OAR as input (radius and center of the
% spheres) and calculates the size of the dose box using the edges of the
% spheres in the x, y, and z directions (positive and negative). The
% function takes the max value for each direction from both spheres and
% uses it as the direction in the upperRight point of the box, and the
% function takes the min value for each direction from both spheres and
% uses it as the direction in the lowerLeft point of the box.

% INPUT
% PTV_rad: the radius of the PTV sphere (single value)
% PTV_center: the center of the PTV sphere (3x1 matrix)
% OAR_rad: the radius of the OAR sphere (single value)
% OAR_center: the center of the OAR sphere (3x1 matrix)

% OUTPUT
% lowerLeft: the lowest left most point of the dose box
% upperRight: the highest right most point of the dose box

function [lowerLeft, upperRight] = Compute_Dose_Box(PTV_rad,PTV_center,OAR_rad,OAR_center)

upperRight = zeros(3,1);
lowerLeft = zeros(3,1);

% compute radius of PTV and OAR in x direction (positive and negative)
PTVxps = PTV_center(1,:) + PTV_rad;
PTVxng = PTV_center(1,:) - PTV_rad;
OARxps = OAR_center(1,:) + OAR_rad;
OARxng = OAR_center(1,:) - OAR_rad;

% max of positive x values is x in upperRight
upperRight(1,:) = max([PTVxps OARxps]);
% min of negative x values is x in lowerLeft
lowerLeft(1,:) = min([PTVxng OARxng]);

% compute radius of PTV and OAR in y direction (positive and negative)
PTVyps = PTV_center(2,:) + PTV_rad;
PTVyng = PTV_center(2,:) - PTV_rad;
OARyps = OAR_center(2,:) + OAR_rad;
OARyng = OAR_center(2,:) - OAR_rad;

% max of positive y values is y in upperRight
upperRight(2,:) = max([PTVyps OARyps]);
% min of negative y values is y in lowerLeft
lowerLeft(2,:) = min([PTVyng OARyng]);

% compute radius of PTV and OAR in z direction (positive and negative)
PTVzps = PTV_center(3,:) + PTV_rad;
PTVzng = PTV_center(3,:) - PTV_rad;
OARzps = OAR_center(3,:) + OAR_rad;
OARzng = OAR_center(3,:) - OAR_rad;

% max of positive z values is z in upperRight
upperRight(3,:) = max([PTVzps OARzps]);
% min of negative z values is z in lowerLeft
lowerLeft(3,:) = min([PTVzng OARzng]);

end