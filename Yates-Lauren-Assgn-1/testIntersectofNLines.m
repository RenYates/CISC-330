% CISC 330 Assignment 1 pt. 3
% Intersection of N Lines Test
% Lauren Yates 10195969

% This testing file is used to test the validity of the IntersectNLines
% function using ground truth cases

% Test 1: The lines all intersect
numLines1 = 4;
ln1 = horzcat([1;1;1],[0;0;0]);
ln2 = horzcat([2;3;0],[0;0;0]);
ln3 = horzcat([0;4;2],[0;0;0]);
ln4 = horzcat([2;3;3],[0;0;0]);
lnMatrix1 = horzcat(ln1,ln2,ln3,ln4);

[pt1, dist1, stdev1] = IntersectNLines(numLines1, lnMatrix1)

% Test 2: the lines are all parallel
numLines2 = 4;
ln5 = horzcat([1;1;1],[2;2;2]);
ln6 = horzcat([3;1;1],[4;2;2]);
ln7 = horzcat([5;1;1],[6;2;2]);
ln8 = horzcat([7;1;1],[8;2;2]);
lnMatrix2 = horzcat(ln5,ln6,ln7,ln8);

[pt2, dist2, stdev2] = IntersectNLines(numLines2, lnMatrix2)

% Test 3: Random N Lines chosen
errors = zeros(9,3);
index = 1;
for i = 2:10
lnMatrix3 = zeros(3,2*i);
for j = 1:2*i
    lnMatrix3(:,j) = rand(3,1);
end
[pt3, dist3, stdev3] = IntersectNLines(i, lnMatrix3);
errors(index,:) = [i, dist3, stdev3];
index = index + 1;
end

% Plot Test 1
figure();
hold on;
lnMatrix1 = lnMatrix1.';
for i = 1:2:8
    plot3(lnMatrix1(i:i+1,1),lnMatrix1(i:i+1,2),lnMatrix1(i:i+1,3));
end
title('Intersect of N Lines Test 1: All Intersect');
xlabel('X-axis');
ylabel('Y-axis');
zlabel('Z-axis');
hold off;

% Plot Test 2
figure();
hold on;
lnMatrix2 = lnMatrix2.';
for i = 1:2:8
    plot3(lnMatrix2(i:i+1,1),lnMatrix2(i:i+1,2),lnMatrix2(i:i+1,3));
end
title('Intersect of N Lines Test 2: None Intersect');
xlabel('X-axis');
ylabel('Y-axis');
zlabel('Z-axis');
hold off;

% Plot Test 3
figure();
hold on;
plot(errors(:,1),errors(:,2));
plot(errors(:,1),errors(:,3));
title('Intersect of N Lines Test 3: Average Dist and STD');
xlabel('Number of Lines');
ylabel('Error');
legend('average distance','standard deviation');
hold off;