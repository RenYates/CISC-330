% CISC 330 Assignment 1 pt. 4
% Intersection of Line and Ellipsoid Test
% Lauren Yates 10195969

% This test has three ground truths used to test the validity of the
% IntersectLineandEllipsoid function

% Test 1: Two Intersections
l1p1 = [-3;0;0];
l1p2 = [3;0;0];
cent1 = [0;0;0];
a1 = 1;
b1 = 1;
c1 = 1;

% intersects at points (-1,0,0) and (1,0,0)
[numInt1, i11, i12] = IntersectLineandEllipsoid(l1p1,l1p2,cent1,a1,b1,c1)

% Test 2: One Intersection
l2p1 = [2;2;0];
l2p2 = [2;-2;0];
cent2 = [0;0;0];
a2 = 2;
b2 = 1;
c2 = 1;

% intersects at the point (2,0,0), the line is tangent to the ellipsoid so
% there is only one intersection
[numInt2, i21, i22] = IntersectLineandEllipsoid(l2p1,l2p2,cent2,a2,b2,c2)

% Test3: Zero Intersections
l3p1 = [0;3;0];
l3p2 = [2;3;0];
cent3 = [0;0;0];
a3 = 1;
b3 = 2;
c3 = 3;

% there are no intersections because the line is above the ellipsoid
[numInt3, i31, i32] = IntersectLineandEllipsoid(l3p1,l3p2,cent3,a3,b3,c3)

% Graph Test 1
[x1, y1, z1] = ellipsoid(cent1(1),cent1(2),cent1(3),a1,b1,c1);
line1 = vertcat(l1p1.',l1p2.');
figure();
hold on;
surf(x1,y1,z1)
plot3(line1(:,1),line1(:,2),line1(:,3),'red');
title('Line and Ellipsoid Test 1: Two Intersections');
xlabel('X-axis');
ylabel('Y-axis');
zlabel('Z-axis');
axis equal;
hold off;

% Graph Test 2
[x2, y2, z2] = ellipsoid(cent2(1),cent2(2),cent2(3),a2,b2,c2);
line2 = vertcat(l2p1.',l2p2.');
figure();
hold on;
surf(x2,y2,z2)
plot3(line2(:,1),line2(:,2),line2(:,3),'red');
title('Line and Ellipsoid Test 2: One Intersection');
xlabel('X-axis');
ylabel('Y-axis');
zlabel('Z-axis');
axis equal;
hold off;

% Graph Test 3
[x3, y3, z3] = ellipsoid(cent3(1),cent3(2),cent3(3),a3,b3,c3);
line3 = vertcat(l3p1.',l3p2.');
figure();
hold on;
surf(x3,y3,z3)
plot3(line3(:,1),line3(:,2),line3(:,3),'red');
title('Line and Ellipsoid Test 3: No Intersections');
xlabel('X-axis');
ylabel('Y-axis');
zlabel('Z-axis');
axis equal;
hold off;
