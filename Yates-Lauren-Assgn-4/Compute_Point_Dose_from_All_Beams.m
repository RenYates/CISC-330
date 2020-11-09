% CISC 330 Assignment 4
% Lauren Yates 10195969
% Compute_Point_Dose_from_All_Beams

% This function takes the head, helmet (beam), OAR sphere, iso center point
% (where all the beams intersect), and the point of interest and computes
% the dose at the point of interest from all valid beams. The beam safety
% table is calculated and if a beam is marked as unsafe in the safety table
% it is skipped and the dose is not added to the total point dose value.

% INPUT
% head_a:    the radius of the head along the x axis
% head_b:    the radius of the head along the y axis
% head_c:    the radius of the head along the z axis
% head_cent: the center of the head
% beam_sep:  the separation angle between the beams
% beam_rad:  the radius of the beam
% oar_rad:   the radius of the OAR sphere
% oar_cent:  the center of the OAR sphere
% iso_cent:  the center point of the helmet where all beams intersect
% poi:       the point of interest

% OUTPUT
% point_dose_value: the total dose value at the given point from all beams

function point_dose_value = Compute_Point_Dose_from_All_Beams(head_a,head_b,head_c,head_cent,beam_sep,beam_rad,oar_rad,oar_cent,iso_cent,poi)

point_dose_value = 0;

max_long = 360;
max_lat = 180;

% calculate the beam safety table
global beam_safety_table;

index = 1;
for i = 0:beam_sep:max_long
    for j = 0:beam_sep:max_lat
        % sum the point dose values to get the total dosage at this point
        % from all the beams
        if (isequal(beam_safety_table(:,index), [i;j;1])) % if the current beam is safe
            current = Compute_Point_Dose_From_Beam(head_a,head_b,head_c,head_cent,beam_rad,i,j,iso_cent,poi);
            point_dose_value = point_dose_value + current;
        end
        index = index + 1;
    end
end

end