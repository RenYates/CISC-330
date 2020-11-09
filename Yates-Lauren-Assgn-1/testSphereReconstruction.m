% CISC 330 Assignment 1 pt. 4
% Sphere Reconstruction Test
% Lauren Yates 10195969

% This testing file is used to test the validity of the Sphere
% reconstruction function using a given ground truth

C = [0;0;0];
R = 100;
N = 25;

% construct a matrix to catch all the errors and maxOff value to compare
errors = zeros(11,3);

for ij = 0:10
    maxOff = ij;
    [center, radius, dist, stdev] = sphereReconstruction(C, R, N, maxOff);
    errors(ij+1,:) = [maxOff, dist, stdev];
    if (maxOff == 0) || (maxOff == 10)
        figure();
        hold on;
        graphSphere(C,R);
        title('Sphere Reconstruction: Ground Truth Sphere');
        xlabel('X-axis');
        ylabel('Y-axis');
        zlabel('Z-axis');
        hold off;
        figure();
        hold on;
        graphSphere(center, radius);
        title('Sphere Reconstruction: Reconstructed Sphere');
        xlabel('X-axis');
        ylabel('Y-axis');
        zlabel('Z-axis');
        hold off;
    end
end

% Plot the Error Matrix
figure();
hold on;
plot(errors(:,1),errors(:,2));
plot(errors(:,1),errors(:,3));
title('Sphere Reconstruction: Reconstructed Sphere');
legend('Average Distance','Standard Deviation');
xlabel('X-axis');
ylabel('Y-axis');
zlabel('Z-axis');
hold off;