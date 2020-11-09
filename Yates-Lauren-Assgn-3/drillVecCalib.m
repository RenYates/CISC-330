% CISC 330 Assignment 3
% Lauren Yates 10195969
% Drill Axis Calibration

% This function takes an array of (A,B,C) markers in a variety of positions
% and fits a plane to each marker (i.e. one plane to fit A markers,
% one plane to fit B markers, and one plane to fit C markers).
% This function then calls the function planeFit to find the normal and 
% a point on the plane. The average of the normal vectors of the three 
% spheres is the drill axis on the tracker frame (i.e. the drill tip in 
% tracker coordinates). This function then converts the normal from 
% tracker frame to marker frame and returns it as vm.

% INPUT
% ABCs = an array of A,B,C marker points (a (3*n)x3 matrix) i.e. 3*n rows
% (where n is the number of rotations/sets of points) and 3 columns (one
% column for x y z of A B and C)

% OUTPUT
% Vm = the drill axis vector of the three calculated planes in marker
% coordinates

function Vm = drillVecCalib(ABCs)

[m,~] = size(ABCs);
numPoses = m/3;
% this for loop creates an nx3 matrix of all the A marker points in tracker
% coordinates in each position
As = zeros(numPoses,3);
index = 1;
for i = 1:3:m
    As(index,:) = ABCs(i,:);
    index = index + 1;
end
% this for loop creates an nx3 matrix of all the B marker points in tracker
% coordinates in each position
Bs = zeros(numPoses,3);
index = 1;
for i = 2:3:m
    Bs(index,:) = ABCs(i,:);
    index = index + 1;
end
% this for loop creates an nx3 matrix of all the C marker points in tracker
% coordinates in each position
Cs = zeros(numPoses,3);
index = 1;
for i = 3:3:m
    Cs(index,:) = ABCs(i,:);
    index = index + 1;
end

% calculate the normals for all the planes associated with the points
[~,normA] = planeFit(As.',numPoses);
[~,normB] = planeFit(Bs.',numPoses);
[~,normC] = planeFit(Cs.',numPoses);

% the average of the normals is the drill axis in tracker coordinates
% vt is a 3x1 vector
Vt = mean([normA normB normC],2);
% Fd (home) coordinate system is (1,0,0), (0,1,0), (0,0,1) = Ft orthonormal 
% coordinate system
Fd = [1,0,0;0,1,0;0,0,1];
AllVm = zeros(3,numPoses);
index = 1;
for i = 1:3:m
    At = As(1,:).';
    Bt = Bs(1,:).';
    Ct = Cs(1,:).';
    % find the orthonormal coordinate system for the points in this
    % position (x,y,z) are base vectors and ctr is the center of the system
    [x,y,z, ~] = OrthonormalCoordinateSystem(At,Bt,Ct);
    % rotation matrix is from Fd (aka. Ft) to Fm (x,y,z)
    rotate = [dot(x,Fd(:,1)),dot(x,Fd(:,2)),dot(x,Fd(:,3));
        dot(y,Fd(:,1)),dot(y,Fd(:,2)),dot(y,Fd(:,3));
        dot(z,Fd(:,1)),dot(z,Fd(:,2)),dot(z,Fd(:,3));];
    % translation is from Fd to Fm
    % find the Tm for this marker system and add it to the matrix
    AllVm(:,index) = rotate * Vt;
    index = index + 1;
end

Vm = mean(AllVm,2);

end