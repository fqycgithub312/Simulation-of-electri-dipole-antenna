function Electri_Dipole_Radiation()
%E_mail:xtang225@foxmail.com       Date:2022.10.14
%��ż���ӵķ���
%����������棬�����˶Գ����ӵĶ�ά����ά����ͼ��ͬʱ�Զ�������ʽչʾ�˵�Ų��ķ������
clear;clc;close;


theta0=linspace(0,2*pi,100);
phi0=linspace(0,2*pi,200);
[theta,phi]=meshgrid(theta0,phi0);
lambda=5;%����
k=2*pi/lambda;%����k
w=pi/24;%��Ƶ��w

Pattern_2D=sin(theta0);%�������ƶ�ά������
Pattern_3D=sin(theta);%����������ά����ͼ

figure(1);% 1.����3ά���巽��ͼ
[x,y,z]=sph2cart(phi,0.5*pi-theta,Pattern_3D);%��������ʽ3ά����ͼ
mesh(x,y,z);
title('��ż����3ά����ͼ����');
xlabel('x');ylabel('y');zlabel('z');

figure(2)%2.���ƶ�ά�����귽��ͼ
polarplot(theta0,abs(Pattern_2D));%��������ʽ��ά����ͼ
title('��ż����2ά����ͼ����');
pax=gca;
pax.ThetaDir='clockwise';
pax.ThetaZeroLocation='top';
hold on;



rmax=10;
X=rmax*sin(theta0)'*cos(phi0);
Y=rmax*sin(theta0)'*sin(phi0);
t=0;%ʱ��
R=sqrt(X.^2+Y.^2);
fmat=moviein(48);

figure(3)%3.��̬��ʾ��Ų��ķ��䶯̬����
title('��ż���ӷ��䶯̬����ͼ');
for t=1:1:48
T=(X./R).^2.*(cos(w*t-k*R)-k*R.*sin(w*t-k.*R))./(k*R);
a=-1:0.4:1;
h= polar([0 2*pi], [0 10]); %�����ڼ������µ�һ��ֱ��  
delete(h);   %ɾ������ֱ�ߣ�������������   
hold on
contour(X,Y,T,a,'b'); 
hold on
yy=cos(w*t);
plot(0,yy,'or','markerfacecolor','r','markersize',10);
text(-0.2,yy,'+','color','w');
plot(0,-yy,'ob','markerfacecolor','b','markersize',10);%���չʾ������
text(-0.1,-yy,'-','color','w');
hold off
fmat(t)=getframe(gcf);
end
movie(gcf,fmat,10,24);

end %��������end���
