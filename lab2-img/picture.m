%LAB1 读取图片
clc
clf
clear
pic=imread('img.jpg');%读取图像

%LAB2信源作业
subplot(2,2,1);
imshow(pic);%显示图像　　　
title('(a)原图');

subplot(2,2,2);
I1=rgb2gray(pic);
imshow(I1);
title('(b)灰度图-rgb2gray');

subplot(2,2,3);
R=pic(:,:,1);G=pic(:,:,2);B=pic(:,:,3);
gray1=uint8((double(R)+double(G)+double(B))/3);
imshow(gray1);%显示图像　　　
title('(c)灰度图-平均值法');

subplot(2,2,4);
gray2=uint8((0.3*double(R)+0.59*double(G)+0.11*double(B)));
imshow(gray2);%显示图像　　　
title('(d)灰度图-加权平均值法');



%LAB3采样率作业 
[n m k]=size(pic);
img200=zeros(200,200);
img100=zeros(100,100);
for i=1:n/2
    for j=1:n/2
        for k=1:3
            img200(i,j,k) = pic(i*2,j*2,k);
        end
    end
end
imwrite(uint8(img200),'img200.jpg');
for i=1:n/4
    for j=1:n/4
        for k=1:3
           img100(i,j,k) = pic(i*4,j*4,k); 
        end
    end
end
imwrite(uint8(img100),'img100.jpg');
figure,subplot(1,3,1);
imshow(uint8(img200));%显示图像　　　
title('200*200');

subplot(1,3,2);
imshow(uint8(img100));%显示图像　　　
title('100*100');

subplot(1,3,3);
imshow(pic);%显示图像　　　
title('原图');



%LAB4信道作业
%加入噪声
img=im2double(pic);
g = 'gaussian';
s = 'salt & pepper';
sp = 'speckle';

img7 = imnoise(pic,g,0,0.1);
img8 = imnoise(pic,s,0.1);
img9 = imnoise(pic,sp,0.1);
figure,subplot(1,3,1);
imshow(img7);title('gaussian 0.1');
subplot(1,3,2);
imshow(img8);title('salt & pepper 0.1');
subplot(1,3,3);
imshow(img9);title('speckle 0.1');

imgx = pic;
img10 = imnoise(pic,s,0.02);
img11 = imnoise(pic,s,0.01);
img12 = imnoise(pic,s,0.001);


figure,subplot(1,3,1);
imshow(img10);title('salt & pepper 0.02');
subplot(1,3,2);
imshow(img11);title('salt & pepper 0.01');
subplot(1,3,3);
imshow(img12);title('salt & pepper 0.001');

imgbox = [img10 img11 img12];


%计算误码率
ber = [0 0 0];
for i=1:3
    for j=1:400
        for k=1:400
            for m=1:3
                if imgbox(j,k+(i-1)*400,m)~=imgx(j,k,m)
                    ber(i)=ber(i)+1;
                end
            end
        end
    end
end

for i=1:3
    ber(i)=ber(i)/(400*400*3);
end

%计算信噪比
snr = [0 0 0];
for i=1:n
    for j=1:n
        for k=1:3
            oriimg(i,j,k) = imgx(i,j,k)^2;
        end
    end
end
oriimgsum = sum(sum(sum(double(oriimg))));
for i=1:3
    for j=1:400
        for k=1:400
            for m=1:3
                zaoimg(i,j,k,m) = imgbox(j,k+(i-1)*400,m)^2;
            end
        end
    end
end
for i=1:3
    zaoimgsum(i) =  sum(sum(sum(double(zaoimg(i,:,:,:)))));
end
for i=1:3
    snr(i) = 10*log10(oriimgsum/(oriimgsum-zaoimgsum(i)));
end



%修复图片
h = fspecial('average',3);

%均值滤波
for i=1:3
    img13(:,:,i) = filter2(h,img10(:,:,i));
    img14(:,:,i) = filter2(h,img11(:,:,i));
    img15(:,:,i) = filter2(h,img12(:,:,i));
end
figure,subplot(3,4,1);
imshow(pic);title('原图');
subplot(3,4,2);
imshow(uint8(img13));title('salt & pepper 0.02 均值滤波');
subplot(3,4,3);
imshow(uint8(img14));title('salt & pepper 0.01 均值滤波');
subplot(3,4,4);
imshow(uint8(img15));title('salt & pepper 0.001 均值滤波');

%中值滤波
for i=1:3
    img13(:,:,i) = medfilt2(img10(:,:,i),[3,3]);
    img14(:,:,i) = medfilt2(img11(:,:,i),[3,3]);
    img15(:,:,i) = medfilt2(img12(:,:,i),[3,3]);
end
subplot(3,4,5);
imshow(pic);title('原图');
subplot(3,4,6);
imshow(uint8(img13));title('salt & pepper 0.02 中值滤波');
subplot(3,4,7);
imshow(uint8(img14));title('salt & pepper 0.01 中值滤波');
subplot(3,4,8);
imshow(uint8(img15));title('salt & pepper 0.001 中值滤波');

%维纳滤波
for i=1:3
    img13(:,:,i) = wiener2(img10(:,:,i),[3,3]);
    img14(:,:,i) = wiener2(img11(:,:,i),[3,3]);
    img15(:,:,i) = wiener2(img12(:,:,i),[3,3]);
end
subplot(3,4,9);
imshow(pic);title('原图');
subplot(3,4,10);
imshow(uint8(img13));title('salt & pepper 0.02 维纳滤波');
subplot(3,4,11)
imshow(uint8(img14));title('salt & pepper 0.01 维纳滤波');
subplot(3,4,12)
imshow(uint8(img15));title('salt & pepper 0.001 维纳滤波');