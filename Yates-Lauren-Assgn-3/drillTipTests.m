% CISC 330 Assignment 3
% Lauren Yates 10195969
% Drill Tip Testing File

% This file tests the validity and accuracy of the simulation function and
% then the calibration function by using the simulation function and
% introducing error to the points and seeing how far the calculated drill
% tip point (Tm) is from the actual point that we know from calculating the
% ground truth ([-7,0,-22]).
% NOTE: required accuracy is within 1mm

% Test 1: Drill Tip Simulation Test

% use 20 poses as stated in Drill Tip Simulation verification
% 75 degrees range chosen as the drill is bulky and it would be difficult
% to rotate the drill a full 90 degrees against the floor (more accurate
% simulated data)
ABCs = drillTipSim(20,75,0);
Tm = drillTipCalib(ABCs); % call this for the spheres plot on the same graph

% Test 2: Calibration Test

% the ground truth of the data (center point in marker coordinates)
gt = [-7;0;-22];

erDiff = [];
% establish the distance of the two points and the initial error as zero
TmDiff = 0;
error = 0;
index = 1;
while (TmDiff < 0.1)
    % can't have a range of 90 degrees cause the drill will never lie
    % completely flat
    % have a range of 75 degrees for motion
    % take 20 points to ensure accuracy but not redundancy (fewer poses,
    % less likely to repeat same poses, 20 was suggested in previous test)
    figure();
    hold on;
    ABCs = drillTipSim(20,75,error);
    Tm = drillTipCalib(ABCs);
    % calculate the distance between the calculated point and the ground
    % truth
    TmDiff = DistTwoPoints3D(Tm,gt);
    erDiff(1,index) = error;
    erDiff(2,index) = TmDiff;
    % verification test for calibration function
    if (error == 0 && TmDiff < 0.1)
        disp('This calibration function works within the required accuracy.');
        Tm
        gt
    end
    if (TmDiff < 0.1) % if the new difference is less then increment the error and try again
        error = error + 0.1;
    end
    hold off;
    index = index + 1;
end

figure();
hold on;
xlabel('Error Number (Emax)');
ylabel('Calibration Error (distance between Tm and Ground Truth)');
title('Calibration Error vs. Emax Value');

plot(erDiff(1,:),erDiff(2,:));
hold off;