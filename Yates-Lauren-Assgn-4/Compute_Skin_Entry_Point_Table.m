% CISC 330 Assignment 4

% This function takes the radiuses and center point of the ellipsoidal
% head, the center point of the helmet, and the beam separation value and
% computes a table of entry points for every beam and puts it in a table,
% and then plots the beams from the skin entry point to the center of the
% helmet.

% INPUT
% head_a: the radius of the head on the x-axis (single value)
% head_b: the radius of the head on the y-axis (single value)
% head_c: the radius of the head on the z-axis (single value)
% head_cent: the center point of the head (3x1 matrix)
% iso_cent: the center point of the helmet (where the beams all intersect)
% beam_sep: the separation angle of the beams (degrees)

% OUTPUT
% skin_entry_point_table: a table of the skin entry points from all the
% beams in cartesian coordinates

function skin_entry_point_table = Compute_Skin_Entry_Point_Table(head_a,head_b,head_c,head_cent,iso_cent,beam_sep,beam_rad)

% create an empty table to be filled
skin_entry_point_table = [];

global max_lon;
global max_lat;

index = 1;
% loop through each beam and calculate the skin entry point of the beams
% and add it to the table, making the step size be the separation angle in
% degrees
for i = 0:beam_sep:max_lon %longitude
    for j = 0:beam_sep:max_lat %latitude
        current = Compute_Skin_Entry_Point(head_a,head_b,head_c,head_cent,i,j,iso_cent);
        skin_entry_point_table(:,index) = current;
        index = index+1;
    end
end

% plot the beams from the skin entry point to the iso center point
hold on;
for k = 1:(index-1)
    plot3([skin_entry_point_table(1,k) iso_cent(1)],[skin_entry_point_table(2,k) iso_cent(2)],[skin_entry_point_table(3,k) iso_cent(3)],'b');
end

end