% CISC 330 Assignment 4
% Lauren Yates 10195969
% Test_Compute_Depth_Dose

% This function visually tests the validity of the Compute_Depth_Dose
% function and the table it returns by plotting the points in the table as
% a line. The validity can be checked visually by comparing the original
% depth dose plot and the generated plot here.

% the min and max x values are set to be the same as the values illustrated
% on the original table
depth_dose_LUT = Compute_Depth_Dose(16,0,0.1);

figure();
hold on;
title('Depth Dose Testing Plot');
xlabel('Depth of Skin');
ylabel('Dose Percentage');
plot(depth_dose_LUT(1,:),depth_dose_LUT(2,:));
scatter([0,2,12],[0,1,0.5],80,'r','filled');
hold off;

% Create a formatted table of depth doses
form_table = table(depth_dose_LUT(1,:).',depth_dose_LUT(2,:).','VariableNames',{'Depth','Dose_Percentage'});
disp(form_table);