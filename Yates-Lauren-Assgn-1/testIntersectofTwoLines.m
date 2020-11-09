% CISC 330 Assignment 1 pt. 2
% Intersection of Two Lines Test
% Lauren Yates 10195969

% This testing file tests the validity of the IntersectofTwoLines 
% function using ground truth cases

% Test Case 1: The Two Lines Intersect
a1 = [0;0;0];
a2 = [1;1;1];
b1 = [1;0;0];
b2 = [1;1;1];
[pt1, error1] = IntersectofTwoLines(a1, a2, b1, b2);

% Test Case 2: The Two Lines are Parallel
c1 = [0;1;1];
c2 = [1;1;1];
d1 = [0;2;2];
d2 = [1;2;2];
[pt2, error2] = IntersectofTwoLines(c1, c2, d1, d2);

% Test Case 3: The Two Non-Parallel Lines Do Not Intersect
e1 = [0;0;-2];
e2 = [1;1;-1];
f1 = [1;0;2];
f2 = [1;1;3];
[pt3, error3] = IntersectofTwoLines(e1,e2,f1,f2);

% Graph Test 1
lineA = [a1.';a2.'];
lineB = [b1.';b2.'];
figure();
hold on;
plot3(lineA(:,1),lineA(:,2),lineA(:,3));
plot3(lineB(:,1),lineB(:,2),lineB(:,3));
title('Test 1: The Two Lines Intersect');
xlabel('X-Axis');
ylabel('Y-Axis');
zlabel('Z-Axis');
legend('line 1','line 2');
hold off;

% Graph Test 2
lineC = [c1.';c2.'];
lineD = [d1.';d2.'];
figure();
hold on;
plot3(lineC(:,1),lineC(:,2),lineC(:,3));
plot3(lineD(:,1),lineD(:,2),lineD(:,3));
title('Test 2: The Two Lines Are Parallel');
xlabel('X-Axis');
ylabel('Y-Axis');
zlabel('Z-Axis');
legend('line 1','line 2');
hold off;

% Graph Test 3
lineE = [e1.';e2.'];
lineF = [f1.';f2.'];
figure();
hold on;
plot3(lineE(:,1),lineE(:,2),lineE(:,3));
plot3(lineF(:,1),lineF(:,2),lineF(:,3));
title('Test 3: The Two Non-Parallel Lines Do Not Intersect');
xlabel('X-Axis');
ylabel('Y-Axis');
zlabel('Z-Axis');
legend('line 1','line 2');
hold off;

