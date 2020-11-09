function graphBox(lowerLeft,upperRight)

xmin = lowerLeft(1);
xmax = upperRight(1);
ymin = lowerLeft(2);
ymax = upperRight(2);
zmin = lowerLeft(3);
zmax = upperRight(3);

% add 5th point to draw a line back to the start of the box
x = [xmin, xmax, xmax, xmin, xmin];
y = [ymin, ymin, ymax, ymax, ymin];
z = [zmin, zmax, zmax, zmin, zmin];
x1 = [xmin, xmin, xmin, xmin, xmin];
x2 = [xmax, xmax, xmax, xmax, xmax];
z1 = [zmin, zmin, zmin, zmin, zmin];
z2 = [zmax, zmax, zmax, zmax, zmax];
hold on;
plot3(x, y, z1, 'k','LineWidth',2);
plot3(x, y, z2, 'k','LineWidth',2);
plot3(x1, y, z, 'k','LineWidth',2);
plot3(x2, y, z, 'k','LineWidth',2);