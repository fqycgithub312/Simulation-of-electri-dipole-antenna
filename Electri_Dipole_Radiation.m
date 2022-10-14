function Electri_Dipole_Radiation()
%E_mail:xtang225@foxmail.com       Date:2022.10.14
%电偶极子的仿真
%程序仿真里面，绘制了对称振子的二维和三维方向图，同时以动画的形式展示了电磁波的辐射过程
clear;clc;close;


theta0=linspace(0,2*pi,100);
phi0=linspace(0,2*pi,200);
[theta,phi]=meshgrid(theta0,phi0);
lambda=5;%波长
k=2*pi/lambda;%波数k
w=pi/24;%角频率w

Pattern_2D=sin(theta0);%用来绘制二维极坐标
Pattern_3D=sin(theta);%用来绘制三维方向图

figure(1);% 1.绘制3维立体方向图
[x,y,z]=sph2cart(phi,0.5*pi-theta,Pattern_3D);%球坐标形式3维方向图
mesh(x,y,z);
title('电偶极子3维方向图仿真');
xlabel('x');ylabel('y');zlabel('z');

figure(2)%2.绘制二维极坐标方向图
polarplot(theta0,abs(Pattern_2D));%极坐标形式二维方向图
title('电偶极子2维方向图仿真');
pax=gca;
pax.ThetaDir='clockwise';
pax.ThetaZeroLocation='top';
hold on;



rmax=10;
X=rmax*sin(theta0)'*cos(phi0);
Y=rmax*sin(theta0)'*sin(phi0);
t=0;%时间
R=sqrt(X.^2+Y.^2);
fmat=moviein(48);

figure(3)%3.动态演示电磁波的辐射动态过程
title('电偶极子辐射动态仿真图');
for t=1:1:48
T=(X./R).^2.*(cos(w*t-k*R)-k*R.*sin(w*t-k.*R))./(k*R);
a=-1:0.4:1;
h= polar([0 2*pi], [0 10]); %产生在极坐标下的一条直线  
delete(h);   %删除上述直线，但留下坐标轴   
hold on
contour(X,Y,T,a,'b'); 
hold on
yy=cos(w*t);
plot(0,yy,'or','markerfacecolor','r','markersize',10);
text(-0.2,yy,'+','color','w');
plot(0,-yy,'ob','markerfacecolor','b','markersize',10);%电荷展示的设置
text(-0.1,-yy,'-','color','w');
hold off
fmat(t)=getframe(gcf);
end
movie(gcf,fmat,10,24);

end %函数结束end语句
