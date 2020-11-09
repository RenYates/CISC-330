% CISC 330 Assignment 1 pt. 6
% Line Reconstruction
% Lauren Yates 10195969

% This function takes two points of a line (A and B), the number of points
% being generated (N), and a maximum off value (maxOff) that is the maximum
% distance the randomly generated points can be from the line (the
% magnitude of the random translation vector). This function then generates
% N random points using the maxOff and creates a new reconstructed line
% from those points. The function returns the line (as a point and unit
% vector of the line), the average distance from all the generated points
% to the line and the standard deviation of the distances

% INPUT
% A - point 1 from the line
% B - point 2 from the line
% N - number of randomly displaced points to be generated
% maxOff - the maximum offset/distance for the points from the given line

% OUTPUT
% lnPt - the calculated point of the regenerated line
% lnVec - the calculated unit vector of the regenerated line
% dist - the average distance from the displaced points to the line
% stdev - the standard deviation of the distances from the displaced points
%         to the line

function [lnPt, lnVec, dist, stdev] = lineReconstruction(A, B, N, maxOff)

abVec = B-A;
abMat = vertcat(A.', B.');
abVec = abVec/norm(abVec);

points = zeros(N,3);
% calculate the distance between the two points to keep the randomly
% generated points between them
max = DistTwoPoints3D(A,B);
% use the direction vector (abVec) and given point (A or B) to create a
% vector equation for the line
for j = 1:N
    t = max.*rand; % randomly generates a number t where 0 <= t <= max
    v = rand(3,1); % randomly generates a 3 by 1 vector
    v = v/norm(v); % normalize the random vector to length 1
    v = v.*maxOff; % change the magnitude of the vector to maxOff
    new = (t*abVec) + v;
    % calculate a new point on the line and offset it with the maxOff vector
    points(j,:) = A + new;
end

% reconstruct a line using the randomly generated points and their average
% point to get the direction vector of the reconstructed line
% the following 4 lines of code is by Matt J answering a question on MathWorks and has
% been modified to be applicable to this assignment
% https://www.mathworks.com/matlabcentral/answers/78363-3d-line-of-best-fit
lnPt = mean(points).';
temp = bsxfun(@minus,points,lnPt.');
[~,~, recVec] = svd(temp, 0);
lnVec = recVec(:,1);
lnVec = (lnVec/norm(lnVec));

% create a second point on the reconstructed line using the line point and
% the line vector (set t=1 for the equation L = P + t*v)
lnPt2 = lnPt + lnVec;
lnPt3 = lnPt + (-(max/2))*lnVec;
lnPt4 = lnPt + (max/2)*lnVec;
lnMat = vertcat(lnPt3.', lnPt4.');
% calculate the distances from the points to the new line and add them to a
% matrix
distM = zeros(1,N);
for i = 1:N
    d = DistanceofLineandPoint(lnPt3,lnPt4,points(i,:).');
    distM(1,i) = d;
end
dist = round(mean(distM),10); % take the average of the distances
stdev = round(std(distM),10); % take the std of the distances

% Plot the lines and points on a graph
if maxOff == 0 || maxOff == 10
    figure();
    hold on;
    title('Line Reconstruction: Ground Truth, Points, and Reconstructed Line');
    xlabel('X-axis');
    ylabel('Y-axis');
    zlabel('Z-axis');
    % graph the ground truth line
    plot3(abMat(:,1),abMat(:,2),abMat(:,3),'red');
    % graph the reconstructed line
    plot3(lnMat(:,1),lnMat(:,2),lnMat(:,3),'blue');
    % graph the points on the graph
    scatter3(points(:,1),points(:,2),points(:,3));
    legend('ground truth line', 'reconstructed line');
end

end