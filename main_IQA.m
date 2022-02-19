%% ͼ���������ۡ���������Mean Square Error,MSE������ֵ����ȣ�Peak-Signal to Noise Ratio,PSNR��

%-------------------------------------------------------------------------------------------------------%
clear;clc;
I=imread('football.jpg');           %��ȡͼ����Ϣ
I1=I(:,:,1);     %Rͨ��
I2=I(:,:,2);     %Gͨ��
I3=I(:,:,3);     %Bͨ��
[M,N]=size(I1);                      %��ͼ������и�ֵ��M,N
t=4;    %�ֿ��С
M1=0;   %����ʱ����Ĳ�����M1=mod(M,t);��Ϊ��Կ
N1=0;   %����ʱ����Ĳ�����N1=mod(N,t);��Ϊ��Կ
u=3.9999;%Logistic������
SUM=M*N;

%% ������
xx0=0.3883;
xx1=0.4134;
ppx=zeros(1,M+1000);        %Ԥ�����ڴ�
ppy=zeros(1,N+1000); 
ppx(1)=xx0;
ppy(1)=xx1;
for i=1:M+999                 %����SUM+999��ѭ�������õ�SUM+1000�㣨������ֵ��
    ppx(i+1)=u*ppx(i)*(1-ppx(i));
end
for i=1:N+999                 %����SUM+999��ѭ�������õ�SUM+1000�㣨������ֵ��
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
I(:,:,1)=I1;     %Rͨ��
I(:,:,2)=I2;     %Gͨ��
I(:,:,3)=I3;     %Bͨ��
%% ����Logistic��������
x0=0.5475; %Logistic��ֵx0
p=zeros(1,SUM+1000);
p(1)=x0;
for i=1:SUM+999                        %����N-1��ѭ��
    p(i+1)=u*p(i)*(1-p(i));          %ѭ����������
end
p=p(1001:length(p));

%% ��p���б任��0~255��Χ��������ת����M*N�Ķ�ά����R
p=mod(round(p*10^4),256);
R=reshape(p,N,M)';  %ת��M��N��

%% �����緽��
%��������ֵX0,Y0,Z0
r=(M/t)*(N/t);
X0=0.4953;
Y0=0.4265;
Z0=0.6928;
A=ML_output(X0,Y0,Z0,r);
X=A(:,1);
X=X(3002:length(X));
Y=A(:,2);
Y=Y(3002:length(Y));
Z=A(:,3);
Z=Z(3002:length(Z));
H1=A(:,3);
H1=H1(3002:length(H1));

 %X,Y�ֱ����I��R��DNA���뷽ʽ����8�֣�1~8
X=mod(round(X*10^4),8)+1;
Y=mod(round(Y*10^4),8)+1;
Z=mod(round(Z*10^4),4);
Z(Z==0)=4;
Z(Z==1)=0;
Z(Z==4)=1;
H1=mod(round(H1*10^4),8)+1;
e=N/t;
%% ͼ����������
YY=imread('football.jpg');        %��ȡͼ����Ϣ
YY=double(YY);
Y1=YY(:,:,1);        %R
Y2=YY(:,:,2);        %G
Y3=YY(:,:,3);        %B
MSE_R=zeros(1,21);MSE_G=zeros(1,21);MSE_B=zeros(1,21);
j=0;        %�����±�
%for i=0:5:100
%     I = imnoise(I, 'gaussian', 0, i^2/255^2);  %�����˹������
for i=0:0.05:1
    I = imnoise(I,'salt & pepper',i);
    I1=I(:,:,1);     %Rͨ��
    I2=I(:,:,2);     %Gͨ��
    I3=I(:,:,3);     %Bͨ��
    j=j+1;      %�����±�

    %% DNA���루���ܣ�
    for ii=r:-1:2
        Q1_R=DNA_bian(fenkuai(t,I1,ii),H1(ii));
        Q1_G=DNA_bian(fenkuai(t,I2,ii),H1(ii));
        Q1_B=DNA_bian(fenkuai(t,I3,ii),H1(ii));

        Q1_last_R=DNA_bian(fenkuai(t,I1,ii-1),H1(ii-1));
        Q1_last_G=DNA_bian(fenkuai(t,I2,ii-1),H1(ii-1));
        Q1_last_B=DNA_bian(fenkuai(t,I3,ii-1),H1(ii-1));

        Q2_R=DNA_yunsuan(Q1_R,Q1_last_R,Z(ii));        %��ɢǰ
        Q2_G=DNA_yunsuan(Q1_G,Q1_last_G,Z(ii));
        Q2_B=DNA_yunsuan(Q1_B,Q1_last_B,Z(ii));

        Q3=DNA_bian(fenkuai(t,R,ii),Y(ii));

        Q4_R=DNA_yunsuan(Q2_R,Q3,Z(ii));
        Q4_G=DNA_yunsuan(Q2_G,Q3,Z(ii));
        Q4_B=DNA_yunsuan(Q2_B,Q3,Z(ii));

        xx=floor(ii/e)+1;
        yy=mod(ii,e);
        if yy==0
            xx=xx-1;
            yy=e;
        end
        Q_R((xx-1)*t+1:xx*t,(yy-1)*t+1:yy*t)=DNA_jie(Q4_R,X(ii));
        Q_G((xx-1)*t+1:xx*t,(yy-1)*t+1:yy*t)=DNA_jie(Q4_G,X(ii));
        Q_B((xx-1)*t+1:xx*t,(yy-1)*t+1:yy*t)=DNA_jie(Q4_B,X(ii));
    end
    Q5_R=DNA_bian(fenkuai(t,I1,1),H1(1));
    Q5_G=DNA_bian(fenkuai(t,I2,1),H1(1));
    Q5_B=DNA_bian(fenkuai(t,I3,1),H1(1));

    Q6=DNA_bian(fenkuai(t,R,1),Y(1));

    Q7_R=DNA_yunsuan(Q5_R,Q6,Z(1));
    Q7_G=DNA_yunsuan(Q5_G,Q6,Z(1));
    Q7_B=DNA_yunsuan(Q5_B,Q6,Z(1));

    Q_R(1:t,1:t)=DNA_jie(Q7_R,X(1));
    Q_G(1:t,1:t)=DNA_jie(Q7_G,X(1));
    Q_B(1:t,1:t)=DNA_jie(Q7_B,X(1));
    
    Q1=Q_R;
    Q2=Q_G;
    Q3=Q_B;
    
    %ȥ������ʱ������
    if M1~=0
        Q1=Q1(1:M-t+M1,:);
        Q2=Q2(1:M-t+M1,:);
        Q3=Q3(1:M-t+M1,:);
    end
    if N1~=0
        Q1=Q1(:,1:N-t+N1);
        Q2=Q2(:,1:N-t+N1);
        Q3=Q3(:,1:N-t+N1);
    end
    [MM,NN]=size(Q1);     %���»�ý��ܺ��ͼƬ��С
    for m=1:MM
        for n=1:NN
            MSE_R(j)=MSE_R(j)+(Y1(m,n)-Q1(m,n))^2;       %Rͨ��MSE
            MSE_G(j)=MSE_G(j)+(Y2(m,n)-Q2(m,n))^2;       %Gͨ��MSE
            MSE_B(j)=MSE_B(j)+(Y3(m,n)-Q3(m,n))^2;       %Bͨ��MSE
        end
    end
    RESULT(:,:,1)=uint8(Q_R);
    RESULT(:,:,2)=uint8(Q_G);
    RESULT(:,:,3)=uint8(Q_B);
    figure;imshow(RESULT);title(['���������ܶ�Ϊ',num2str(i),'ʱ�Ľ���ͼ��']);
end
%��������-MSE
MSE_R=MSE_R./SUM;
MSE_G=MSE_G./SUM;
MSE_B=MSE_B./SUM;
%��ֵ�����-PSNR
PSNR_R=10*log10((255^2)./MSE_R);
PSNR_G=10*log10((255^2)./MSE_G);
PSNR_B=10*log10((255^2)./MSE_B);
%% ��ͼ����������-MSE����ֵ�����-PSNR
% set(gca,'xtick', X);
X=0:0.05:1;
figure;plot(X,MSE_R);xlabel('���������ܶ�');ylabel('�������MSE');title('Rͨ�������������ܶ�-�������MSE����ͼ');
figure;plot(X,MSE_G);xlabel('���������ܶ�');ylabel('�������MSE');title('Gͨ�������������ܶ�-�������MSE����ͼ');
figure;plot(X,MSE_B);xlabel('���������ܶ�');ylabel('�������MSE');title('Bͨ�������������ܶ�-�������MSE����ͼ');
figure;plot(X,PSNR_R);xlabel('���������ܶ�');ylabel('��ֵ�����PSNR��dB��');title('Rͨ�������������ܶ�-��ֵ�����PSNR����ͼ');
figure;plot(X,PSNR_G);xlabel('���������ܶ�');ylabel('��ֵ�����PSNR��dB��');title('Gͨ�������������ܶ�-��ֵ�����PSNR����ͼ');
figure;plot(X,PSNR_B);xlabel('���������ܶ�');ylabel('��ֵ�����PSNR��dB��');title('Bͨ�������������ܶ�-��ֵ�����PSNR����ͼ');