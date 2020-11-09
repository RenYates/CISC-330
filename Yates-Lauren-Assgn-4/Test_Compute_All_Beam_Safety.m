% CISC 330 Assignment 4
% Lauren Yates 10195969
% Test_Compute_All_Beam_Safety

% This testing file calls the Compute_All_Beam_Safety function and prints
% the created table by longitude and latitude and displays whether or not
% the beam is safe (1 is safe, 0 is unsafe).

global beam_sep; global beam_rad; global iso_cent; global oar_rad; 
global oar_cent; global head_a; global head_b; global head_c;

% calculate the safety for all beams
global beam_safety_table;
beam_safety_table = Compute_All_Beam_Safety(beam_rad,beam_sep,iso_cent,oar_rad,oar_cent,head_a,head_b,head_c);

% Create a formatted table of safetys
form_table = table(beam_safety_table(1,:).',beam_safety_table(2,:).',beam_safety_table(3,:).','VariableNames',{'Longitude','Latitude','Unsafe'});
disp(form_table);