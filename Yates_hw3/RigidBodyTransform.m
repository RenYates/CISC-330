% CISC 330 Assignment 1 pt. 8
% Rigid Body Transformation
% Lauren Yates 10195969

% This function takes the input of two fiducial marker triangles and
% calculates the transformation matrix, the average FLE (fiducual
% localization error), the average FRE (fiducual registration error), and
% the ctrTRE (target registration error in the centre point)

% INPUT
% a1 - fiducial marker position 1, point 1
% b1 - fiducial marker position 1, point 2
% c1 - fiducial marker position 1, point 3
% a2 - fiducial marker position 2, point 1
% b2 - fiducial marker position 2, point 2
% c2 - fiducial marker position 2, point 3

% OUTPUT
% transform - the 4x4 homogeneous transformation matrix
% avgFLE - the average fiducual localization error
% avgFRE - the average fiducual registration error
% ctrTRE - the target registration error in the center point

function [transform, avgFLE, avgFRE, ctrTRE] = RigidBodyTransform(a1, b1, c1, a2, b2, c2)

% the orthonormal coordinate system for both triangles is calculated (the
% center of the coordinate system is the center of gravity of the triangle)
[v1, v2, v3, ctr1] = OrthonormalCoordinateSystem(a1, b1, c1);
[e1, e2, e3, ctr2] = OrthonormalCoordinateSystem(a2, b2, c2);

% procrustes is a built in function that is used to generate the rotation
% matrix from one set of base vectors [v1 v2 v3] to another [e1 e2 e3]
% [~,~, trans] = procrustes([e1 e2 e3], [v1 v2 v3]);
% rot = trans.T; % trans.T accesses the rotation matrix from the procrustes output
% rotCtr1 = rot * ctr1; % calculate the rotated center of the position 1 triangle
% % the translation vector is the difference between the center point of the
% % second orthonormal coordinate system and the rotated center point of the
% % first orthonormal coordinate system

% the rigid_transform_3D function was sourced online from:
% http://nghiaho.com/uploads/code/rigid_transform_3D.m
% the function has been modified to fit this problem
[rot,~] = rigid_transform_3D([v1.'; v2.'; v3.'], [e1.'; e2.'; e3.']);
rotCtr1 = rot * ctr1; % calculate the rotated center of the position 1 triangle
tlnVec = ctr2 - rotCtr1;
% make the 4x4 rotation matrix
rotMat = vertcat(horzcat(rot,[0;0;0]),[0,0,0,1]);
% make the 4x4 translation matrix
tlnMat = vertcat(horzcat(eye(3),tlnVec),[0,0,0,1]);

% transformation matrix = translation matrix(rotation matrix(scale matrix))
% scale matrix not used so just translation matrix * rotation matrix
transform = tlnMat*rotMat;

% calculate transformed markers a b and c
ta = transform*[a1;1]
tb = transform*[b1;1]
tc = transform*[c1;1]

% calculate the new transformed center of the first triangle
% (using the transformed markers ta tb tc)
[~,~,~,tCtr] = OrthonormalCoordinateSystem(ta(1:3,:), tb(1:3,:), tc(1:3,:));

% calculate the lengths of each side of both inputed triangles
% find the absolute value of the difference between the line lengths
abDiff = abs(DistTwoPoints3D(a2,b2)-DistTwoPoints3D(a1,b1));
acDiff = abs(DistTwoPoints3D(a2,c2)-DistTwoPoints3D(a1,c1));
bcDiff = abs(DistTwoPoints3D(b2,c2)-DistTwoPoints3D(b1,c1));

% calculate the average between the distance differences as a "dummy check"
% to see the average Fiducial Localization Error (avgFLE)
% round errors to 10 decimal places for simplicity
avgFLE = round((abDiff+acDiff+bcDiff)/3, 10);
% the target registration error is the distance between the center point
% of the second fiducial marker triangle and the calculated center point of
% the transformed first triangle
ctrTRE = round(DistTwoPoints3D(ctr2, tCtr),10);
% the average fiducual registration error is the distance between each
% fiducual marker from the second triangle and the new transformed
% fiducual markers from the first triangle
avgFRE = round((DistTwoPoints3D(a2,ta(1:3))+DistTwoPoints3D(b2,tb(1:3))+DistTwoPoints3D(c2,tc(1:3)))/3,10);
end
