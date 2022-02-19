function f=ML_SimpleLorenz(t,y)
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

f=zeros(3,1);
f(1)=(-y(3)-gl*(y(1)-Vl)-gk*y(2)*(y(1)-Vk)-gca*(0.5*(1+tanh((y(1)-v1)/v2)))*(y(1)-Vca));
f(2)=((1/3)*cosh((y(1)-v3)/(2*v4)))*(0.5*(1+tanh((y(1)-v3)/v4))-y(2));
f(3)=mu*(0.2+y(1));
end