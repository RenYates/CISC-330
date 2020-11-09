% CISC 330 Assignment 1 pt. 8
% Rigid Body Transformation Test File
% Lauren Yates 10195969

% This test file creates three different ground truth cases with an FLE of 
% zero to test the validity of the RigidBodyTransform function
% For each ground truth test case, a random FLE vector is then added 
% who's magnitude is 5%, 10%, 15%, and 20% of the shortest side
% of the starting fiducial marker triangle
% The resulting avgFLE, avgFRE, and ctrTRE are added to a results matrix
% for that ground truth

% Ground truth test 1: pure translation
a11 = [1;0;0];
b11 = [0;2;0];
c11 = [0;0;1];

% The fiducial markers are translated +1 in the z direction
a12 = [1;0;1];
b12 = [0;2;1];
c12 = [0;0;2];
% The resulting 1-by-4 matrix will be added to the first row of the 
% results matrix for this test case (resultsT)
[transform1, avgFLE1, avgFRE1, ctrTRE1] = RigidBodyTransform(a11,b11,c11,a12,b12,c12);

% Ground truth test 2: pure rotation
a21 = [-2;-2;0];
b21 = [2;-2;0];
c21 = [-2;4;0];

% The fiducial markers are rotated by 90 degrees around the origin (0,0,0)
a22 = [2;-2;0];
b22 = [2;2;0];
c22 = [-4;-2;0];
% The resulting 1-by-4 matrix will be added to the first row of the 
% results matrix for this test case (resultsR)
[transform2, avgFLE2, avgFRE2, ctrTRE2] = RigidBodyTransform(a21,b21,c21,a22,b22,c22);

% Ground truth test 3: translation and rotation
a31 = [0;0;0];
b31 = [5;0;0];
c31 = [0;6;0];

% The fiducial markers are rotated 180 degrees about the origin (0,0,0) 
% and are shifted -4 in the x direction and +6 in the y direction
a32 = [-4;6;0];
b32 = [-9;6;0];
c32 = [-4;0;0];
% The resulting 1-by-4 matrix will be added to the first row of the 
% results matrix for this test case (resultsTR)
[transform3, avgFLE3, avgFRE3, ctrTRE3] = RigidBodyTransform(a31,b31,c31,a32,b32,c32);

% FLE Error creation: pure translation
dists = [DistTwoPoints3D(a11,b11), DistTwoPoints3D(a11,c11), DistTwoPoints3D(b11,c11)];
minDist = min(dists); % the minimum distance between the three fiducial markers
resultsT = zeros(5,4); % 5 test cases (0%,5%,10%,15%,20%) and 4 results (actual fle,avgFLE,avgFRE,ctrTRE)
resultsT(1,:) = [0, avgFLE1, avgFRE1, ctrTRE1]; % fle=0 results are added to the first row
index = 2;
for i = 5:5:20 % increments the percentage by 5, starting at 5 and ending at 20
    fle = (i/100)*minDist; % the fle is calculated using the min distance of the points and the percentage
    % the randomly displaced points are calculated and created using fle
    % and the original point
    newA11 = FLEVecAdd(a11,fle);
    newB11 = FLEVecAdd(b11,fle);
    newC11 = FLEVecAdd(c11,fle);
    newA12 = FLEVecAdd(a12,fle);
    newB12 = FLEVecAdd(b12,fle);
    newC12 = FLEVecAdd(c12,fle);
    % the resulting avgFLE, avgFRE, and ctrTRE are calculated and added to
    % the next row in the results matrix
    [transformF1, avgFLEF1, avgFREF1, ctrTREF1] = RigidBodyTransform(newA11,newB11,newC11,newA12,newB12,newC12);
    resultsT(index,:) = [i, avgFLEF1, avgFREF1, ctrTREF1];
    index = index + 1;
end

% FLE Error creation: pure rotation
dists = [DistTwoPoints3D(a11,b11), DistTwoPoints3D(a11,c11), DistTwoPoints3D(b11,c11)]; %DistTwoPoints3D calculates the distance between two points in 3D
minDist = min(dists);% the minimum distance between the three fiducial markers
resultsR = zeros(5,4);% 5 test cases (0%,5%,10%,15%,20%) and 4 results (actual fle,avgFLE,avgFRE,ctrTRE)
resultsR(1,:) = [0, avgFLE2, avgFRE2, ctrTRE2];% fle=0 results are added to the first row
index = 2;
for i = 5:5:20 % increments the percentage by 5, starting at 5 and ending at 20
    fle = (i/100)*minDist; % the fle is calculated using the min distance of the points and the percentage
    % the randomly displaced points are calculated and created using fle
    % and the original point    
    newA21 = FLEVecAdd(a21,fle);
    newB21 = FLEVecAdd(b21,fle);
    newC21 = FLEVecAdd(c21,fle);
    newA22 = FLEVecAdd(a22,fle);
    newB22 = FLEVecAdd(b22,fle);
    newC22 = FLEVecAdd(c22,fle);
    % the resulting avgFLE, avgFRE, and ctrTRE are calculated and added to
    % the next row in the results matrix
    [transformF1, avgFLEF1, avgFREF1, ctrTREF1] = RigidBodyTransform(newA21,newB21,newC21,newA22,newB22,newC22);
    resultsR(index,:) = [i, avgFLEF1, avgFREF1, ctrTREF1];
    index = index + 1;
end

% FLE Error creation: rotation and translation
dists = [DistTwoPoints3D(a11,b11), DistTwoPoints3D(a11,c11), DistTwoPoints3D(b11,c11)];
minDist = min(dists);% the minimum distance between the three fiducial markers
resultsTR = zeros(5,4);% 5 test cases (0%,5%,10%,15%,20%) and 4 results (actual fle,avgFLE,avgFRE,ctrTRE)
resultsTR(1,:) = [0, avgFLE3, avgFRE3, ctrTRE3];% fle=0 results are added to the first row
index = 2;
for i = 5:5:20 % increments the percentage by 5, starting at 5 and ending at 20
    fle = (i/100)*minDist; % the fle is calculated using the min distance of the points and the percentage
    % the randomly displaced points are calculated and created using fle
    % and the original point
    newA31 = FLEVecAdd(a31,fle);
    newB31 = FLEVecAdd(b31,fle);
    newC31 = FLEVecAdd(c31,fle);
    newA32 = FLEVecAdd(a32,fle);
    newB32 = FLEVecAdd(b32,fle);
    newC32 = FLEVecAdd(c32,fle);
    % the resulting avgFLE, avgFRE, and ctrTRE are calculated and added to
    % the next row in the results matrix
    [transformF1, avgFLEF1, avgFREF1, ctrTREF1] = RigidBodyTransform(newA31,newB31,newC31,newA32,newB32,newC32);
    resultsTR(index,:) = [i, avgFLEF1, avgFREF1, ctrTREF1];
    index = index + 1;
end

% Plot Translation Results
figure();
hold on;
title('Rigid Body Transformation: Translation Only');
plot(resultsT(:,1),resultsT(:,2));
plot(resultsT(:,1),resultsT(:,3));
plot(resultsT(:,1),resultsT(:,4));
xlabel('Magnitude of Displacement (percent)');
ylabel('Error values');
legend('avgFLE', 'avgFRE', 'ctrTRE');
hold off;

% Plot Rotation Results
figure();
hold on;
title('Rigid Body Transformation: Rotation Only');
plot(resultsR(:,1),resultsR(:,2));
plot(resultsR(:,1),resultsR(:,3));
plot(resultsR(:,1),resultsR(:,4));
xlabel('Magnitude of Displacement (percent)');
ylabel('Error values');
legend('avgFLE', 'avgFRE', 'ctrTRE');
hold off;

% Plot Rotation and Translation Results
figure();
hold on;
title('Rigid Body Transformation: Rotation and Translation');
plot(resultsTR(:,1),resultsTR(:,2));
plot(resultsTR(:,1),resultsTR(:,3));
plot(resultsTR(:,1),resultsTR(:,4));
xlabel('Magnitude of Displacement (percent)');
ylabel('Error values');
legend('avgFLE', 'avgFRE', 'ctrTRE');
hold off;