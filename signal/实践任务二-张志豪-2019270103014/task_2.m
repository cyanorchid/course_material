%数据点
num = 256; 
%采样频率
f = 100;


%time
n = 0 : num - 1;
t = n / f;

%输入函数
x = cos(10*pi *t)+cos(20*pi*t)+cos(40*pi *t)+cos(80*pi *t);

%分别使用自带fft和自己编写ffts进变换
mag1 = abs(fft(x, num)); 
mag2 = abs(ffts(x,num)); 

f1 = n * f / num;

subplot(2,1,1);
semilogx(f1,mag1); 
xlim([20,100])
xlabel('f/Hz');
ylabel('magitude/linear');
title('fft');

subplot(2,1,2);
semilogx(f1,mag2); 
xlim([20,100])
xlabel('f/Hz');
ylabel('magitude/linear');
title('ffts');

