% CISC 330 Assignment 3
% Lauren Yates 10195969
% Drill Tip Calibration

% This function takes an array of (A,B,C) markers in a variety of positions
% and fits a sphere to each marker (i.e. one sphere to fit A markers,
% one sphere to fit B markers, and one sphere to fit C markers).
% This function then calls the function spherefit to find the radius and 
% center of the spheres. The average of the center points of the three 
% spheres is the pivot point on the tracker frame (i.e. the drill tip in 
% tracker coordinates). This function then converts the center point from 
% tracker frame to marker frame and returns it as Tm.

% INPUT
% ABCs = an array of A,B,C marker points (a (3*n)x3 matrix) i.e. 3*n rows
% (where n is the number of rotations/sets of points) and 3 columns (one
% column for x y z of A B and C)

% OUTPUT
% Tm = the center point of the three calculated spheres in marker
% coordinates

function Tm = drillTipCalib(ABCs)

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
% calculate the centers of the spheres for A, B, and C markers
hold on;
[Actr,Arad] = sphereFit(As);
graphSphere(Actr,Arad,'r');
[Bctr,Brad] = sphereFit(Bs);
graphSphere(Bctr,Brad,'g');
[Cctr,Crad] = sphereFit(Cs);
graphSphere(Cctr,Crad,'b');
hold off;

% the average center of the spheres is the drill tip location in tracker
% coordinates
% Tt is a 3x1 vector
Tt = mean([Actr; Bctr; Cctr]).';
% Fd (home) coordinate system is (1,0,0), (0,1,0), (0,0,1) = Ft orthonormal 
% coordinate system
Fd = [1,0,0;0,1,0;0,0,1];
AllTm = zeros(3,numPoses);
index = 1;
for i = 1:3:m
    At = As(index,:).';
    Bt = Bs(index,:).';
    Ct = Cs(index,:).';
    % find the orthonormal coordinate system for the points in this
    % position (x,y,z) are base vectors and ctr is the center of the system
    [x,y,z, ctr] = OrthonormalCoordinateSystem(At,Bt,Ct);
    % rotation matrix is from Fd (aka. Ft) to Fm (x,y,z)
    rotate = [dot(x,Fd(:,1)),dot(x,Fd(:,2)),dot(x,Fd(:,3));
        dot(y,Fd(:,1)),dot(y,Fd(:,2)),dot(y,Fd(:,3));
        dot(z,Fd(:,1)),dot(z,Fd(:,2)),dot(z,Fd(:,3));];
    % translation is from Fd to Fm
    translate = ctr;
    % find the Tm for this marker system and add it to the matrix
    AllTm(:,index) = rotate * (Tt - translate);
    index = index + 1;
end
% take the average of the Tms for the Tm
Tm = mean(AllTm,2);

end % end of function