% CISC 330 Assignment 2 pt. 6
% Test and Analysis
% Lauren Yates 10195969

center = [1;1;1];
% randomly generated points of the ellipsoid
pts = generateEllipsoidPts(center,1,2,3,100);

% plot the x-ray images of the tumor at every 15 degrees
for i = 0:15:360
    figure();
    hold on;
    xlabel('X-Axis');
    ylabel('Y-Axis');
    zlabel('Z-Axis');
    title(['Tumor X-Ray Taken at ' num2str(i) ' Degrees'])
    tumorContour = tumorProjector(i,pts);
    plot(tumorContour(1,:).',tumorContour(2,:).');
    hold off;
end

% Test 1: Reconstruction With One Image
% images taken at every 0 degrees
tc0 = tumorProjector(0,pts);
figure();
hold on;
xlabel('X-Axis');
ylabel('Y-Axis');
zlabel('Z-Axis');
title('0 Degrees Tumor Reconstruction');
[x,y,z] = ellipsoid(center(1),center(2),center(3),1,2,3);
h = surf(x,y,z);
set(h,'FaceAlpha',0); % makes the sphere being generated transparent
[tumorRec0,vol0] = tumorReconstructor(0,tc0);


% % Test 2: Reconstruction With Two Images
% % images taken at every 180 degrees
tc180 = tumorProjector(180,pts);
figure();
hold on;
xlabel('X-Axis');
ylabel('Y-Axis');
zlabel('Z-Axis');
title('180 Degrees Tumor Reconstruction');
[x,y,z] = ellipsoid(center(1),center(2),center(3),1,2,3);
h = surf(x,y,z);
set(h,'FaceAlpha',0); % makes the sphere being generated transparent
[tumorRec180,vol180] = tumorReconstructor([0,180],tc0, tc180);
hold off;

% Test 3: Reconstruction With Four Images
% images taken at every 90 degrees
tc90 = tumorProjector(90,pts);
tc270 = tumorProjector(270,pts);
figure();
hold on;
xlabel('X-Axis');
ylabel('Y-Axis');
zlabel('Z-Axis');
title('90 Degrees Tumor Reconstruction');
[x,y,z] = ellipsoid(center(1),center(2),center(3),1,2,3);
h = surf(x,y,z);
set(h,'FaceAlpha',0); % makes the sphere being generated transparent
[tumorRec90,vol90] = tumorReconstructor([0,90,180,270],tc0,tc90,tc180,tc270);
hold off;

% Test 4: Reconstruction With Six Images
% images taken at every 60 degrees
tc60 = tumorProjector(60,pts);
tc120 = tumorProjector(120,pts);
tc240 = tumorProjector(240,pts);
tc300 = tumorProjector(300,pts);
angles60 = [0,60,120,180,240,300];
figure();
hold on;
xlabel('X-Axis');
ylabel('Y-Axis');
zlabel('Z-Axis');
title('60 Degrees Tumor Reconstruction');
[x,y,z] = ellipsoid(center(1),center(2),center(3),1,2,3);
h = surf(x,y,z);
set(h,'FaceAlpha',0); % makes the sphere being generated transparent
[tumorRec60,vol60] = tumorReconstructor(angles60,tc0,tc60,tc120,tc180,tc240,tc300);
hold off;

% Test 5: Reconstruction With Twelve Images
% images taken at every 30 degrees
tc30 = tumorProjector(30,pts);
tc150 = tumorProjector(150,pts);
tc210 = tumorProjector(210,pts);
tc330 = tumorProjector(330,pts);
angles30 = [0,30,60,90,120,150,180,210,240,270,300,330];
figure();
hold on;
xlabel('X-Axis');
ylabel('Y-Axis');
zlabel('Z-Axis');
title('30 Degrees Tumor Reconstruction');
[x,y,z] = ellipsoid(center(1),center(2),center(3),1,2,3);
h = surf(x,y,z);
set(h,'FaceAlpha',0); % makes the sphere being generated transparent
[tumorRec30,vol30] = tumorReconstructor(angles30,tc0,tc30,tc60,tc90,tc120,tc150,tc180,tc210,tc240,tc270,tc300,tc330);
hold off;

% Test 6: Reconstruction With 24 Images
% images taken at every 15 degrees
tc15 = tumorProjector(15,pts);
tc45 = tumorProjector(45,pts);
tc75 = tumorProjector(75,pts);
tc105 = tumorProjector(105,pts);
tc135 = tumorProjector(135,pts);
tc165 = tumorProjector(165,pts);
tc195 = tumorProjector(195,pts);
tc225 = tumorProjector(225,pts);
tc255 = tumorProjector(255,pts);
tc285 = tumorProjector(285,pts);
tc315 = tumorProjector(315,pts);
tc345 = tumorProjector(345,pts);
angles15 = [0,15,30,45,60,75,90,105,120,135,150,165,180,195,210,225,240,255,270,285,300,315,330,345,360];
figure();
hold on;
xlabel('X-Axis');
ylabel('Y-Axis');
zlabel('Z-Axis');
title('15 Degrees Tumor Reconstruction');
[x,y,z] = ellipsoid(center(1),center(2),center(3),1,2,3);
h = surf(x,y,z);
set(h,'FaceAlpha',0); % makes the sphere being generated transparent
[tumorRec15,vol15] = tumorReconstructor(angles15,tc0,tc15,tc30,tc45,tc60,tc75,tc90,tc105,tc120,tc135,tc150,tc165,tc180,tc195,tc210,tc225,tc240,tc255,tc270,tc285,tc300,tc315,tc330,tc345);
hold off;

volume = (4/3)*pi*1*2*3;
figure();
hold on;
xlabel('Number of Rotations');
ylabel('Volume Difference');
title('Volume Difference vs. Number of Images');

plot([1;2;4;6;12;24],[(vol0/volume);(vol180/volume);(vol90/volume);(vol60/volume);(vol30/volume);(vol15/volume)]);
hold off;

