% CISC 330 Assignment 4
% Lauren Yates 10195969
% Compute_Depth_Dose

% This function takes a maximum depth (max_depth), minimum depth (d0), and
% a step size for the depths (depth_resolution) and assembles a table
% containing the calculated dose at every step. The function uses
% information from the provided graph in the assignment to determine which
% linear equation to use to calculate the dose at the current depth.

% INPUT
% max_depth: the maximum depth of the doses, where the table stops
%            computing doses (single value)
% d0: the minimum depth of the doses, where the table starts computing the
%     doses (single value)
% depth_resolution: the step size of the depths

% OUTPUT
% depth_dose_LUT: the table containing the depths in the first row and
%                 their corresponding doses in the second row (2xn matrix
%                 where n is the number of doses calculated)

function depth_dose_LUT = Compute_Depth_Dose(max_depth,d0,depth_resolution)

% calculate the size of the LUT matrix
LUT_size = (max_depth-d0)*(1/depth_resolution);
depth_dose_LUT = zeros(2,LUT_size);
index = 1;
% loop through the step sizes starting at d0 and ending at max_depth
for i = d0:depth_resolution:max_depth
    depth_dose_LUT(1,index) = i;
    % if the depth is less than 2 use this linear function
    if i < 2
        depth_dose_LUT(2,index) = Compute_Linear_Function([0;0],[2;1],i);
    % otherwise if the depth is less than 22 use this linear function
    elseif i < 22 
        depth_dose_LUT(2,index) = Compute_Linear_Function([2;1],[12;0.5],i);
    % if the depth is >= 22 use this linear function (set it equal to 0)
    else
        depth_dose_LUT(2,index) = 0;
    end
    index = index + 1;
end

end