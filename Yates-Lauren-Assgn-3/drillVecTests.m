% CISC 330 Assignment 3
% Lauren Yates 10195969
% Drill Axis Calibration Test

% This file tests the validity and accuracy of the simulation function
% visually and then the calibration function by using the simulation
% function and introducing error to the points and seeing how far the
% calculated drill vector (Vm) is from the actual point that we know from
% calculating the ground truth (gt) [0,0,1].
% NOTE: required accuracy is within 2 degrees from the ground truth vector

% try 3 different rotation degrees and see if it affects the validity of
% the calibration ** remember using a guide sleeve for calibration **

% Test 1: Drill Axis Simulation Test

% use 20 poses as stated in Drill Axis Simulation verification
% For visualization/plotting purposes the rotation angle range chosen is 360
% error introduced is zero because this is verifying the ground truth
% visually
figure();
ABCs = drillVecSim(20,360,0);
% Test 2: Drill Axis Calibration Test

gt = [0;0;1];

erDiff = [];
% establish the angle between the two points and the initial error as zero
angle = 0;
error = 0;
index = 1;
while (angle < 2)
    % use rotation angle of 360 to have full spin motion of drill to
    % collect enough data for the circle planes
    % take 20 points to ensure accuracy but not redundancy (fewer poses,
    % less likely to repeat same poses, 20 was suggested in previous test)
    figure();
    hold on;
    ABCs = drillVecSim(20,360,error);
    Vm = drillVecCalib(ABCs);
    % calculate the angle between the ground truth and the Vm for error
    angle = atan2d(norm(cross(Vm,gt)),dot(Vm,gt)); % convert CosTheta to degrees
    erDiff(1,index) = error;
    erDiff(2,index) = angle;
    % verification test for calibration function
    if (error == 0 && angle < 2)
        disp('This calibration function works within the required accuracy.');
        Vm
        gt
    end
    if (angle < 2) % if the new difference is less then increment the error and try again
        error = error + 0.1;
    end
    hold off;
    index = index + 1;
end

figure();
hold on;
xlabel('Error Number (Emax)');
ylabel('Calibration Error (angle between Vm and Ground Truth)');
title('Calibration Error vs. Emax Value');

plot(erDiff(1,:),erDiff(2,:));
hold off;