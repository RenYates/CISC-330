% CISC 330 Assignment 4
% Lauren Yates 10195969
% Test_Compute_Point_Dose_From_Beam

% This testing file uses the testing method outlined in the assignment. The
% file uses beams at the required longitudes and latitudes {0,90} and
% {0,90} respectively, and calculates the dose from the beams. Since the
% radial dose should be 1, the dosage should be equal to the depth dose of
% the beam. when testing, add a display(); in the
% Compute_Point_Dose_From_Beam function to display the depth dose values in
% the command window. Then compare the values in the generated table to
% their associated depth dose values to verify their equality visually.

global beam_rad; global head_a; global head_b; global head_c; 
global head_cent;
poi = head_cent;
fake_iso_cent = head_cent;

% create an empty matrix to hold the calculated doses
doses = [];

index = 1;
% iterate through the specified longitudes and latitudes and calculate the
% point doses from the beams and add them to the table
for beam_lon = 0:90:90
    for beam_lat = 0:90:90
        doses(1,index) = beam_lon;
        doses(2,index) = beam_lat;
        doses(3,index) = Compute_Point_Dose_From_Beam(head_a,head_b,head_c,head_cent,beam_rad,beam_lon,beam_lat,fake_iso_cent,poi);
        index = index + 1;
    end
end

% Create a formatted table of doses
form_table = table(doses(1,:).',doses(2,:).',doses(3,:).','VariableNames',{'Longitude','Latitude','Dosage'});
disp(form_table);
