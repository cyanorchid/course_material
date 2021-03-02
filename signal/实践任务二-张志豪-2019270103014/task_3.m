%读取音频
[x_in,fs] = audioread('gekihaku.wav');

%处理数据
x = x_in(:, 1);
len_x = length(x); 
time = (0 : len_x-1) / fs; 

plot(x);

%fft
sim_dots = 204800;
num = 819200;  
window = hanning(sim_dots); 
freq = (0 : num/2) * fs /num;
y = x(9001 : 9000+sim_dots);
y = y - mean(y);
Y = fft(y .* window, num);

%画图
subplot 211;
plot(y);
xlim([0 sim_dots]);
title('time—domain');
xlabel('simples');
ylabel('magnitude/linear');

subplot 212;
semilogx(freq,20*log10(abs(Y(1:num/2+1))));
axis([20 20000 -60 inf]);
title('frequency—domain');
xlabel('f/Hz');
ylabel('magnitude/dB')
