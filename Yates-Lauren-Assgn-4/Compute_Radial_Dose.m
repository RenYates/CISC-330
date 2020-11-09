% CISC 330 Assignment 4
% Lauren Yates 10195969
% Compute_Radial_Dose

% This function takes a maximum distance (max_dist), the radius of the beam
% (beam_radius), and a step size for the radius (beam_resolution) and
% assembles a table containing the calculated dose at every step. The
% function uses information from the provided graph in the assignment to
% determine which linear equation to use to calculate the dose at the
% current distance from the center beam.

% INPUT
% max_dist: the maximum distance from the center of the beam, where the
%           table stops computing doses (single value)
% beam_radius: the radius of the beam from the center line (single value)
% radius_resolution: the step size of distance from the center line

% OUTPUT
% radial_dose_LUT: the table containing the distance in the first row and
%                  their corresponding doses in the second row (2xn matrix
%                  where n is the number of doses calculated)

function radial_dose_LUT = Compute_Radial_Dose(max_dist,beam_radius,beam_resolution)

% calculate the size of the LUT matrix
LUT_size = (max_dist*2)*(1/beam_resolution);
radial_dose_LUT = zeros(2,LUT_size);
index = 1;
% loop through the step sizes starting at negative max_dist and ending at
% max_dist (covers both sides of the beam)
for i = -max_dist:beam_resolution:max_dist
    % set the x value
    radial_dose_LUT(1,index) = i;
    % conditionally calculate the y value (3 possible linear equations)
    % if the distance is less than -22.5
    if i <= -22.5
        radial_dose_LUT(2,index) = 0;
    % if the distance is with in -22.5 and -1*half the beam radius
    elseif i <= (-1*(beam_radius/2))
        radial_dose_LUT(2,index) = Compute_Linear_Function([-22.5;0],[(-1*(beam_radius/2));1],i);
    % if the distance is within half of the beam radius (both negative and
    % positive)
    elseif abs(i) < (beam_radius/2)
        radial_dose_LUT(2,index) = Compute_Linear_Function([(-1*(beam_radius/2));1],[(beam_radius/2);1],i);
    % if the distance is less than 22.5
    elseif i < 22.5
        radial_dose_LUT(2,index) = Compute_Linear_Function([(beam_radius/2);1],[22.5;0],i);
    % if the distance is greater than 22.5
    else
        radial_dose_LUT(2,index) = 0;
    end
    index = index + 1;
end

end