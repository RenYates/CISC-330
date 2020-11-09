% CISC 330 Assignment 3
% Lauren Yates 10195969
% Drill Tip Simulator

% This function takes a set number of points (N) and an angle range (angle)
% and simulates a set of N data points rotated randomly around the center
% point (0,0,0) within that angle range. The error value in the input is
% used to introduce that amount of error to the data points to randomly
% shift them by that error.

% INPUT
% N = number of poses to be generated
% angle = the angle/rotation range that the points may be generated in
% error = the amount error to be added to the generated points randomly to
% disperse them

% OUTPUT
% ABCs = the set of N poses in order (A1,B1,C1,...AN,BN,CN)

function ABCs = drillTipSim(N, angle, error)

Amat = zeros(N,3);
Bmat = zeros(N,3);
Cmat = zeros(N,3);
ABCs = zeros(N*3,3);

index = 1;
for i = 1:3:N*3
    
    %calculate the radius for A and C because they're both on the Z axis
    radAmin = 20 - error; % distance from origin to point (with error)
    radAmax = 20 + error; % distance from origin to point (with error)
    radA = (radAmax - radAmin).*rand + radAmin;
    radCmin = 26 - error; % distance from origin to point (with error)
    radCmax = 26 + error; % distance from origin to point (with error)
    radC = (radCmax - radCmin).*rand + radCmin;    
    % first angle: -180 to 180 (xy)
    ang1Min = -180;
    ang1Max = 180;

    % randomly generate angle for x y plane
    ang1 = (ang1Max - ang1Min).*rand + ang1Min;

    % second angle: 90-angle to angle (z)
    ang2Min = 90 - angle;
    ang2Max = 90; 

    % randomly generate angle for positive z plane
    ang2 = (ang2Max - ang2Min).*rand + ang2Min;

    % transform the spherical coordinates (angles) into cartesian coordinates
    % to calculate the new A and C points at the randomly generated angles
    ax = radA .* cosd(ang2) .* cosd(ang1);
    ay = radA .* cosd(ang2) .* sind(ang1);
    az = radA .* sind(ang2);
    
    cx = radC .* cosd(ang2) .* cosd(ang1);
    cy = radC .* cosd(ang2) .* sind(ang1);
    cz = radC .* sind(ang2);
    
    A = [ax ay az];
    C = [cx cy cz];
    % B must be perpendicular to the line created by AC and the Z axis)
    tempB = cross([0 0 1],C-A);
    unitB = tempB/norm(tempB); % unit vector of B
    A = A+(5*unitB);
    C = C+(5*unitB);
    B = (A + unitB*6); % scale the vector to be of length 6 and add A
  
    
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
title('Drill Tip Calibration: Marker Points');
xlabel('X-axis');
ylabel('Y-axis');
zlabel('Z-axis');
hold off;
end