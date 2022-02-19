clc
clear

[T,Y]=ode45(@ML_SimpleLorenz,[0:0.001:1600],[0; 0.5; 0]);
maxX = ceil(max(Y(:,1)));
minX = floor(min(Y(:,1)));
maxY = ceil(max(Y(:,2)));
minY = floor(min(Y(:,2)));
maxZ = ceil(max(Y(:,3)));
minZ = floor(min(Y(:,3)));

figure
plot(Y(:,1),Y(:,2))
xlabel('\itx')
ylabel('\ity')
figure
plot(Y(:,1),Y(:,3))
xlabel('\itx')
ylabel('\itz')
figure
plot(Y(:,2),Y(:,3))
xlabel('\ity')
ylabel('\itz')

figure
plot3(Y(:,1),Y(:,2),Y(:,3))
xlabel('\itx')
ylabel('\ity')
zlabel('\itz')



