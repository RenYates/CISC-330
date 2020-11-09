% CISC 330 Assignment 4
% Lauren Yates 10195969
% Compute_All_Beam_Safety

% This function takes the helmet information, the center of the helmet 
% where the beams intersect, the OAR radius and center point, and the
% radiuses of the head (x, y, and z axis). The function then determines for
% all beams whether or not the beam is safe (if it intersects with the OAR)
% and creates a table of all the beams and their indicator for safety (0
% means unsafe, 1 means safe).

% INPUT
% beam_rad: the radius of the beam
% beam_sep: the degree of separation of each beam
% iso_cent: the center point of the helmet where all beams intersect
% oar_rad:  the radius of the OAR sphere
% oar_cent: the center of the OAR sphere
% head_a:   the radius of the head along the x axis
% head_b:   the radius of the head along the y axis
% head_c:   the radius of the head along the z axis

% OUTPUT
% beam_safety_table: a 3xn table (where n is the number of beams)
% containing the latitude, longitude, and safety value of all the beams (0
% is unsafe, 1 is safe)

function beam_safety_table = Compute_All_Beam_Safety(beam_rad,beam_sep,iso_cent,oar_rad,oar_cent,head_a,head_b,head_c)

beam_safety_table = [];

global max_lon;
global max_lat;

index = 1;
% loop through each beam and calculate the safety of the beam, then store
% it in the table
for i = 0:beam_sep:max_lon %longitude
    for j = 0:beam_sep:max_lat %latitude
        beam_safety_table(1,index) = i;
        beam_safety_table(2,index) = j;
        beam_safety_table(3,index) = Compute_Beam_Safety(beam_rad,i,j,iso_cent,oar_rad,oar_cent,head_a,head_b,head_c);
        index = index +1;
    end
end

end