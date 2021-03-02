%寮犲織璞?-2019270103014
%assignment3


N = 128 ;   %序列长度
i_R = randi([-1,2],1,N);     %生成In实部序列，-1，0，1，2四个可能
i_I = randi([-1,2],1,N);    %生成In虚部序列，-1，0，1，2四个可能
n = (1:N);  %
times = 100 ;               %每周期采样数，用于模拟连续信号   
T = 1*10^(-6) ;     %g（t）时间段
M = 16 ;    %16QAM调制
SNR = 10 ;  %信噪比SNR
t = (1:128*times) ;  %连续时间

for i = 1:N          %替换为对应星座图坐标
    if(i_R(i) == 2)
        i_R(i) = 3;   %2->3
    end
    if(i_R(i) == 0)
        i_R(i) = -3;    %0->-3
    end
    if(i_I(i) == 2)
        i_I(i) = 3;    %2->3
    end
    if(i_I(i) == 0)
        i_I(i) = -3;    %0->-3
    end
end

for i = 1:N * times

q_R(i) = i_R(ceil(i/times));    %模拟连续信号
q_I(i) = i_I(ceil(i/times));

% s_R(i) = q_R(i)*g(mod(i-1,times)+1); 
% s_I(i) = q_I(i)*g(mod(i-1,times)+1);

s_R(i) = q_R(i) ; 
s_I(i) = q_I(i) ; 
end 

r_R = awgn(s_R,SNR);    %r(t)实部加入噪声
r_I = awgn(s_I,SNR);    %r(t)虚部加入噪声

g = ones(1,times) ;    %g(t)
h = g ;             %h(t)
z_R = conv(r_R,h)/times;   %匹配滤波后z（t）实部
z_I = conv(r_I,h)/times;   %匹配滤波后z（t）虚部

h_g = conv(g,h)/times;     %h(t)经过匹配滤波后的输出

figure('name','h_g(t)');    %绘制h（t）经过匹配滤波后输出
i = (1/times:1/times:(2*times-1)/times);
plot(i,h_g,'r');
hold on ;
xlabel('t/ns');
axis([0,10,-inf,inf])

figure('name','z(t)');

subplot(2,1,1)
plot(t/times,z_R(t),'r');       %绘制z(t)实部
hold on ;

for i=times:times:N*times
    plot(i/times,z_R(i),'*b');  %绘制z(t)实部采样点
    hold on;
end;
xlabel('t/ns');
title('real part')

subplot(2,1,2)
plot(t/times,z_I(t),'b');   %绘制z(t)虚部
hold on ;


for i=times:times:N*times
    plot(i/times,z_I(i),'*r'); %绘制z(t)虚部采样点
    hold on;
end;
xlabel('t/ns');
title('imaginary part')
