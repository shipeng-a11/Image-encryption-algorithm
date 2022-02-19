%% ���ڻ���ϵͳ��DNA����Ĳ�ɫ����ͼ�����ϵͳ
%-------------------------------------------------------------------------------------------------------%
clear;clc;
I=imread('5.png');           %��ȡͼ����Ϣ
I1=I(:,:,1);     %Rͨ��
I2=I(:,:,2);     %Gͨ��
I3=I(:,:,3);     %Bͨ��
[M,N]=size(I1);                      %��ͼ������и�ֵ��M,N
t=4;    %�ֿ��С
SUM=M*N;
u=3.9999;     %��Կ1����
xx0=0.7067;
xx1=0.3883;
ppx=zeros(1,M+1000);        %Ԥ�����ڴ�
ppy=zeros(1,N+1000); 
ppx(1)=xx0;
ppy(1)=xx1;
for i=1:M+999                 %����M+999��ѭ�������õ�M+1000�㣨������ֵ��
    ppx(i+1)=u*ppx(i)*(1-ppx(i));
end
for i=1:N+999                 %����M+999��ѭ�������õ�M+1000�㣨������ֵ��
    ppy(i+1)=u*ppy(i)*(1-ppy(i));
end
ppx=ppx(1001:length(ppx));            %ȥ��ǰ1000�㣬��ø��õ������
ppy=ppy(1001:length(ppy));

[~,Ux]=sort(ppx,'descend');
[~,Uy]=sort(ppy,'descend');

for i=N:-1:1
    temp = I1(:,i);
    I1(:,i) = I1(:,Uy(i));
    I1(:,Uy(i)) = temp;
    temp = I2(:,i);
    I2(:,i) = I2(:,Uy(i));
    I2(:,Uy(i)) = temp;
    temp = I3(:,i);
    I3(:,i) = I3(:,Uy(i));
    I3(:,Uy(i)) = temp;
end
for i=M:-1:1
    temp = I1(i,:);
    I1(i,:) = I1(Ux(i),:);
    I1(Ux(i),:) = temp;
    temp = I2(i,:);
    I2(i,:) = I2(Ux(i),:);
    I2(Ux(i),:) = temp;
    temp = I3(i,:);
    I3(i,:) = I3(Ux(i),:);
    I3(Ux(i),:) = temp;
end
%% 2.����Logistic��������
% u=3.999900000000001; %��Կ�����Բ���  10^-15
u=3.9999;%��Կ��Logistic������
 x0=0.5475000000000001; %��Կ�����Բ���  10^-16
 %x0=0.5475; %��Կ��Logistic��ֵx0
% x0=0.3462;            %homeͼƬ
p=zeros(1,SUM+1000);
p(1)=x0;
for i=1:SUM+999                        %����SUM+999��ѭ��������SUM+1000������
    p(i+1)=u*p(i)*(1-p(i));
end
p=p(1001:length(p));

%% 3.��p���б任��0~255��Χ��������ת����M*N�Ķ�ά����R
p=mod(round(p*10^4),256);
R=reshape(p,N,M)';  %ת��M��N��

%% 4.�����緽��
%��������ֵX0,Y0,Z0
r=(M/t)*(N/t);
% X0=0.4953000000000001;        %��Կ�����Բ���
X0=0.4953;
Y0=0.4265;
Z0=0.6928;
% X0=0.5056;        %homeͼƬ
% Y0=0.505;
% Z0=0.4564;
% H0=0.3062;
A=ML_output(X0,Y0,Z0,r);
X=A(:,1);
X=X(3002:length(X));
Y=A(:,2);
Y=Y(3002:length(Y));
Z=A(:,3);
Z=Z(3002:length(Z));
H1=A(:,3);
H1=H1(3002:length(H1));

%% 5.DNA����
%X,Y�ֱ����I��R��DNA���뷽ʽ����8�֣�1~8
X=mod(round(X*10^4),8)+1;
Y=mod(round(Y*10^4),8)+1;
Z=mod(round(Z*10^4),4);
Z(Z==0)=4;      %�Ӽ�������
Z(Z==1)=0;
Z(Z==4)=1;
H1=mod(round(H1*10^4),8)+1;
e=N/t;
for i=r:-1:2
    Q1_R=DNA_bian(fenkuai(t,I1,i),H1(i));
    Q1_G=DNA_bian(fenkuai(t,I2,i),H1(i));
    Q1_B=DNA_bian(fenkuai(t,I3,i),H1(i));
    
    Q1_last_R=DNA_bian(fenkuai(t,I1,i-1),H1(i-1));
    Q1_last_G=DNA_bian(fenkuai(t,I2,i-1),H1(i-1));
    Q1_last_B=DNA_bian(fenkuai(t,I3,i-1),H1(i-1));
    
    Q2_R=DNA_yunsuan(Q1_R,Q1_last_R,Z(i));        %��ɢǰ
    Q2_G=DNA_yunsuan(Q1_G,Q1_last_G,Z(i));
    Q2_B=DNA_yunsuan(Q1_B,Q1_last_B,Z(i));

    Q3=DNA_bian(fenkuai(t,R,i),Y(i));
    
    Q4_R=DNA_yunsuan(Q2_R,Q3,Z(i));
    Q4_G=DNA_yunsuan(Q2_G,Q3,Z(i));
    Q4_B=DNA_yunsuan(Q2_B,Q3,Z(i));
    
    xx=floor(i/e)+1;
    yy=mod(i,e);
    if yy==0
        xx=xx-1;
        yy=e;
    end
    I1((xx-1)*t+1:xx*t,(yy-1)*t+1:yy*t)=DNA_jie(Q4_R,X(i));
    I2((xx-1)*t+1:xx*t,(yy-1)*t+1:yy*t)=DNA_jie(Q4_G,X(i));
    I3((xx-1)*t+1:xx*t,(yy-1)*t+1:yy*t)=DNA_jie(Q4_B,X(i));
end
Q5_R=DNA_bian(fenkuai(t,I1,1),H1(1));
Q5_G=DNA_bian(fenkuai(t,I2,1),H1(1));
Q5_B=DNA_bian(fenkuai(t,I3,1),H1(1));

Q6=DNA_bian(fenkuai(t,R,1),Y(1));

Q7_R=DNA_yunsuan(Q5_R,Q6,Z(1));
Q7_G=DNA_yunsuan(Q5_G,Q6,Z(1));
Q7_B=DNA_yunsuan(Q5_B,Q6,Z(1));

I1(1:t,1:t)=DNA_jie(Q7_R,X(1));
I2(1:t,1:t)=DNA_jie(Q7_G,X(1));
I3(1:t,1:t)=DNA_jie(Q7_B,X(1));

Q_jiemi(:,:,1)=uint8(I1);
Q_jiemi(:,:,2)=uint8(I2);
Q_jiemi(:,:,3)=uint8(I3);

%% 6��ȥ������ʱ������
M1=0;   %����ʱ����Ĳ�����M1=mod(M,t);��Ϊ��Կ
N1=0;   %����ʱ����Ĳ�����N1=mod(N,t);��Ϊ��Կ
if M1~=0
    Q_jiemi=Q_jiemi(1:M-t+M1,:,:);
end
if N1~=0
    Q_jiemi=Q_jiemi(:,1:N-t+N1,:);
end

figure;imhist(Q_jiemi(:,:,1));xlabel('Pixel value');ylabel('Number of pixel occurrences');title('Decrypted image R channel histogram');
figure;imhist(Q_jiemi(:,:,2));xlabel('Pixel value');ylabel('Number of pixel occurrences');title('Decrypted image G channel histogram');
figure;imhist(Q_jiemi(:,:,3));xlabel('Pixel value');ylabel('Number of pixel occurrences');title('Decrypted image B channel histogram');

%�ȽϽ��ܺ��ͼ��ԭͼ�Ƿ���ȫ��ͬ
%II=imread('lena.png');
%cha=sum(sum(sum(Q_jiemi-II)));      %����ͼ��������ܺ�
%% ����ͼƬ

%imwrite(Q_jiemi,'../ԭʼ�����ܡ�����ͼƬ/���ܺ��lena.png','png');       
disp('������Ľ�����ԿΪ��');
disp(['��Կ1����=',num2str(u),'     ��Կ2��x0=',num2str(x0),'    ��Կ3��x(0)=',num2str(X0),'    ��Կ4��y(0)=',num2str(Y0),'   ��Կ5��z(0)=',num2str(Z0),]);
disp(['��Կ6��M1=',num2str(M1),'   ��Կ7��N1=',num2str(N1),'   ��Կ8��xx0=',num2str(xx0),'   ��Կ9��xx1=',num2str(xx1)]);
disp('�������'); 
figure;imshow(Q_jiemi);
title('Decrypted image');