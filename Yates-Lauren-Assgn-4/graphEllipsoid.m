function graphEllipsoid(center, a, b, c, color)
hold on;
[x,y,z] = ellipsoid(center(1),center(2),center(3),a,b,c);
h = surf(x,y,z);
set(h,'FaceAlpha',0.1,'FaceColor',color); % makes the sphere being generated transparent
end