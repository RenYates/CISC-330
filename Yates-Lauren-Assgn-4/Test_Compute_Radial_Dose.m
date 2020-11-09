% CISC 330 Assignment 4
% Lauren Yates 10195969
% Test_Compute_Radial_Dose

% This function visually tests the validity of the Compute_Radial_Dose
% function and the table it returns by plotting the points in the table as
% a line. The validity can be checked visually by comparing the original
% radial dose plot and the generated plot here.

global beam_rad;
max_dist = 25; % set for visual representation
beam_resolution = 0.1; % set for visual representation

radial_dose_LUT = Compute_Radial_Dose(max_dist,beam_rad,beam_resolution);

figure();
hold on;
title('Radial Dose Testing Plot');
xlabel('Radial Distance from Beam');
ylabel('Dose Percentage');
plot(radial_dose_LUT(1,:),radial_dose_LUT(2,:));
scatter([-22.5,(-1*(beam_rad/2)),(beam_rad/2),22.5],[0,1,1,0],80,'r','filled');
hold off;

% Create a formatted table of depth doses
form_table = table(radial_dose_LUT(1,:).',radial_dose_LUT(2,:).','VariableNames',{'Depth','Dose_Percentage'});
disp(form_table);