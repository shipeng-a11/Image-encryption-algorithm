%%%%----�������ظı���-���ڼ���ͼ�͸ı���ԭͼ�ļ���ͼ----%%%%
clc;
clear;
%��ȡ����ԭͼһ�����ص��ļ���ͼ
image1=imread('4.png');
%��ȡû�и���ԭͼ�ļ���ͼ
image2=imread('3.png');
%��ʾͼƬ
subplot(1,2,1),imshow(image2),title('ԭͼ��')
subplot(1,2,2),imshow(image1),title('�ı��ͼ��')
%������ͬλ�ûҶ�ֵ��ȵĸ���
[M,N]=size(image1);
m=0;
u1=0;
for i=1:M
    for j=1:N
        u1=u1+abs(double(image1(i,j))-double(image2(i,j)))/255;
        if image1(i,j)~=image2(i,j)
            m=m+1;
        end
    end
end
ua=sum(abs(double(image1(:))-double(image2(:)))/255);%�򵥵�ʽ�ӣ�һ���͸㶨
%����NPCR
NPCR1=(m*100)/(M*N);
NPCR=sum(double(image1(:))~=double(image2(:)))*100/(M*N);%�򵥵ķ���
UACI1=(u1*100)/(M*N);
UACI=(ua*100)/(M*N);
disp(['NPCRֵΪ��',num2str(NPCR)]);
disp(['NPCRֵΪ��',num2str(NPCR1)]);
disp(['UACIֵΪ��',num2str(UACI)]);%����һ
disp(['UACIֵΪ��',num2str(UACI1)]);%������