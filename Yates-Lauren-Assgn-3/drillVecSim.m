% CISC 330 Assignment 3
% Lauren Yates 10195969
% Drill Axis/Vector Simulator

% This function takes a set number of points (N) and an angle range (angle)
% and simulates a set of N data points rotated around the z axis within
% that angle range. The error value in the input is used to introduce that
% amount of error to the data points to randomly shift them by that error.

% INPUT
% N = number of poses to be generated
% angle = the angle/rotation range that the points may be generated in
% error = the amount error to be added to the generated points randomly to
% disperse them

% OUTPUT
% ABCs = the set of N poses in order (A1,B1,C1,...AN,BN,CN)

function ABCs = drillVecSim(N, angle, error)

Amat = zeros(N,3);
Bmat = zeros(N,3);
Cmat = zeros(N,3);
ABCs = zeros(N*3,3);

At = [5;0;20];
Bt = [11;0;20];
Ct = [5;0;26];

index = 1;
for i= 1:3:N*3
    
    angMin = 90-angle;
    angMax = 90;
    
    % introduce the error to the z coordinates of the 3 points to move them
    % off the plane randomly
    AtzMin = 20 - error;
    AtzMax = 20 + error;
    At(3,:) = (AtzMax - AtzMin).*rand + AtzMin;
    
    BtzMin = 20 - error;
    BtzMax = 20 + error;
    Bt(3,:) = (BtzMax - BtzMin).*rand + BtzMin;
    
    CtzMin = 26 - error;
    CtzMax = 26 + error;
    Ct(3,:) = (CtzMax - CtzMin).*rand + CtzMin;
    
    % randomly generate an angle within this range of motion
    ang = (angMax - angMin).*rand + angMin;
    
    % build the rotation matrix using the angle generated
    rotMat = [cosd(ang) sind(ang) 0; -sind(ang) cosd(ang) 0; 0 0 1];
    
    % apply the rotation matrix to the points to move them around
    A = (rotMat*At).';
    B = (rotMat*Bt).';
    C = (rotMat*Ct).';
    
    % add points A B and C to their own matrices for graphing
    Amat(index,:) = A;
    Bmat(index,:) = B;
    Cmat(index,:) = C;
    
    % add the points A B and C to the matrix of points
    ABCs(i,:) = A;
    ABCs(i+1,:) = B;
    ABCs(i+2,:) = C;
    index = index + 1;
end
hold on;
scatter3(Amat(:,1),Amat(:,2),Amat(:,3),'r','filled');
scatter3(Bmat(:,1),Bmat(:,2),Bmat(:,3),'g','filled');
scatter3(Cmat(:,1),Cmat(:,2),Cmat(:,3),'b','filled');
title('Drill Axis Calibration: Marker Points');
xlabel('X-axis');
ylabel('Y-axis');
zlabel('Z-axis');
hold off;
end