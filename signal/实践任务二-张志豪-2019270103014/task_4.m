%读取文件
[x_in,fs] = audioread('tuningfork_2.wav');

%处理数据
x = x_in(:, 1);
N = length(x);  
time = (0 : N-1) / fs;  

plot(x);

%fft
M = 2048;
num = 8192;
win = hanning(M);
freq = (0 : num/2) * fs / num;
y = x(9001 : 9000+M);
y = y - mean(y);
Y = fft(y.*win,num);


subplot(2,1,1);
plot(y);
xlim([0 M]);
title('time—domain');
xlabel('simples');
ylabel('magnitude/linear');


subplot(2,1,2);
semilogx(freq,20*log10(abs(Y(1:num/2+1))));
axis([20 20000 -60 55]);
title('frequency—domain');
xlabel('f/Hz');
ylabel('magnitude/dB')
