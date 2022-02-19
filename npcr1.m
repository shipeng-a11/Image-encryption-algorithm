%%%%----计算像素改变率-基于加密图和改变了原图的加密图----%%%%
clc;
clear;
%读取更改原图一个像素点后的加密图
image1=imread('4.png');
%读取没有更改原图的加密图
image2=imread('3.png');
%显示图片
subplot(1,2,1),imshow(image2),title('原图像')
subplot(1,2,2),imshow(image1),title('改变后图像')
%计算相同位置灰度值相等的个数
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
ua=sum(abs(double(image1(:))-double(image2(:)))/255);%简单的式子，一个就搞定
%计算NPCR
NPCR1=(m*100)/(M*N);
NPCR=sum(double(image1(:))~=double(image2(:)))*100/(M*N);%简单的方法
UACI1=(u1*100)/(M*N);
UACI=(ua*100)/(M*N);
disp(['NPCR值为：',num2str(NPCR)]);
disp(['NPCR值为：',num2str(NPCR1)]);
disp(['UACI值为：',num2str(UACI)]);%方法一
disp(['UACI值为：',num2str(UACI1)]);%方法二