function fy=ML_output(x0,y0,z0,num)
Vl = -0.5;
gl = 0.5;
gk = 2;
Vk = -1.1;
gca = 1.2;
v1 = -0.01;
v2 = 0.15;
v3 = 0.1;
v4 = 0.05;
Vca =0.83;
mu = 0.005;
% 微分方程求解
opt = odeset('Mass',@mass);
y0=[x0;y0;z0];
[~,y] = ode45(@ode,0:500/(num+3000):500,y0,opt);
fy=y;
    function f = ode(~,y)
        y1=y(1);
        y2=y(2);
        y3=y(3);
        f = [(-y3-gl*(y1-Vl)-gk*y2*(y1-Vk)-gca*(0.5*(1+tanh((y1-v1)/v2)))*(y1-Vca));((1/3)*cosh((y1-v3)/(2*v4)))*(0.5*(1+tanh((y1-v3)/v4))-y2);mu*(0.2+y1)];
    end
    function M = mass(~,~)
        M = [1,0,0;0,1,0;0,0,1];
    end
end