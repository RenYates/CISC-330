% CISC 330 Assignment 1 pt. 6
% Line Reconstruction Test
% Lauren Yates 10195969

% this testing file is used to test the validity of the line reconstruction
% function using a given ground truth

A = [0;0;0];
B = [100;100;100];
N = 25;
% create a results matrix to hold the errors
errors = zeros(11,3);

% for loop cycles through all maxOff test cases
for maxOff = 0:10
    [lnPt, lnDir, dist, stdev] = lineReconstruction(A, B, N, maxOff)
    % add calculated distance and standard deviation to results matrix
    errors((maxOff+1),:) = [maxOff, dist, stdev];
end

% Graph Errors vs. MaxOff Value
figure();
hold on;
plot(errors(:,1),errors(:,2));
plot(errors(:,1),errors(:,3));
title('Average Dist and Standard Deviation vs. MaxOff Value');
legend('Average Distance','Standard Deviation');
xlabel('X-axis');
ylabel('Y-axis');
zlabel('Z-axis');
hold off;
