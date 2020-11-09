function[] = graphSphere(center, radius, color)
hold on;
[x,y,z] = sphere();
h = surf(radius*x+center(1),radius*y+center(2),radius*z+center(3));
set(h,'FaceAlpha',0.1,'FaceColor',color); % makes the sphere being generated transparent
end