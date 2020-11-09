function[] = graphSphere(center, radius)
[x,y,z] = sphere();
surf(radius*(x+center(1)),radius*(y+center(2)),radius*(z+center(3)));