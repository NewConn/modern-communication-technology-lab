clear all
clc
clf
[y, Fs] = audioread('E:\2017Course\xiandaitongxin\lab1-wav\CLR.wav'); %读入WAV文件
sigLength = length(y); %获取声音长度
%sound(y, Fs); %可以使用sound函数来播放声音
subplot(2,2,1);
plot(y)
title('44000样本')

y8800 = y(1:5:end);
Fs8800 = 8800;
sigLength8800 = length(y8800);
audiowrite('E:\2017Course\xiandaitongxin\lab1-wav\CLR8800.wav',y8800,Fs8800);
subplot(2,2,2);
plot(y8800)
title('8.8kbps样本')

x = mapminmax(y8800, 0, 1);
FlattenedData = y8800(:)'; % 展开矩阵为一列，然后转置为一行。
MappedFlattened = mapminmax(FlattenedData, 0, 1); % 归一化。
x = reshape(MappedFlattened, size(y8800));
n=length(x);
M=max(x);
A=(x/M)*2048;
%code=y8800eros(i,8); 
for i=1:n
    %code=y8800eros(i,8);
    code(i*8)=floor(((A(i)-1)/8));
    if(code(i*8)>128)
        code(i*8)=code(i*8)-128;
        code(i*8-7)=1;
    end
    if(code(i*8)>64)
        code(i*8)=code(i*8)-64;
        code(i*8-6)=1;
    end
    if(code(i*8)>32)
        code(i*8)=code(i*8)-32;
        code(i*8-5)=1;
    end
    if(code(i*8)>16)
        code(i*8)=code(i*8)-16;
        code(i*8-4)=1;
    end
    if(code(i*8)>8)
        code(i*8)=code(i*8)-8;
        code(i*8-3)=1;
    end
    if(code(i*8)>4)
        code(i*8)=code(i*8)-4;
        code(i*8-2)=1;
    end
    if(code(i*8)>2)
        code(i*8)=code(i*8)-2;
        code(i*8-1)=1;
    end
    if(code(i*8)>1)
        code(i*8)=1;
    end    
end
%编码
code=reshape(code',1,8*n);
code;
subplot(2,2,3);
csvwrite('E:\2017Course\xiandaitongxin\lab1-wav\CLR.csv',code)
stem(code,'.');
%axis([10583990 10584008 0 1]);
gs=awgn(code,15);%加入噪声
stem(gs,'.')
gsjg=1*(gs>0.5);%判决
title('编码信号');
grid on
bit_errors=0;
bit_errors_count=0;
for j=1:8*n
    if(code(j)~=gsjg(j))
        bit_errors_count=bit_errors_count+1;
    end
end
%bit_errors_count = size(bit_errors, 2)
b=bit_errors_count/2116800;
% subplot(223);
% plot(gsjg)
for ix=1:n
   decode(ix)=1024*gsjg(8*ix-7)+512*gsjg(8*ix-6)+256*gsjg(8*ix-5)+128*gsjg(8*ix-4)+64*gsjg(8*ix-3)+32*gsjg(8*ix-2)+16*gsjg(8*ix-1)+8*gsjg(8*ix);
    %解码    
        
end
decode=decode/2048;
q = mapminmax(decode, -1, 1);
FlattenedData = decode(:)'; % 展开矩阵为一列，然后转置为一行。
MappedFlattened = mapminmax(FlattenedData, -1, 1); % 去归一化。
q = reshape(MappedFlattened, size(decode));
subplot(2,2,4);
audiowrite('E:\2017Course\xiandaitongxin\lab1-wav\CLR滤波.wav',q,8820)
plot(q)
title('滤波还原数据');

Z=fft(y8800);
Z1=abs(Z);
f=(0:sigLength8800-1)*Fs8800/sigLength8800; %频率化
re=(f(1:sigLength8800)<5000); %滤波条件
zx=Z.*re';
figure
plot(f(1:sigLength8800/2),Z1(1:sigLength8800/2)*2/sigLength8800)
xlabel('频率/赫兹'),ylabel('幅值'),title('频域');
z1=ifft(zx);
z2=20*real(z1);
audiowrite('E:\2017Course\xiandaitongxin\lab1-wav\CLR傅里叶.wav',z2,8800);

