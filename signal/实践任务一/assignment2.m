%张志豪-2019270103014
%assignement2



N = 128 ;   %In长度
i_R = randi([-1,2],1,N);     %生成In实部序列，-1，0，1，2四个可能
i_I = randi([-1,2],1,N);    %生成In虚部序列，-1，0，1，2四个可能
times = 100 ;               %每周期采样数，用于模拟连续信号   
n = (1/times:1/times:N);    
T = 1*10^(-6) ;     %g（t）时间范围
eg = T ;    %g(t)能量
es = 0 ;    %平均符号能量
eb = 0 ;    %平均比特能量
e_total=0;  %序列总能量
e_expectation=0; %|In|^2的期望
M = 16 ;    %16QAM调制
SNR = 10 ;  %信噪比SNR

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
    e_total = e_total + i_R(i)^2 + i_I(i)^2    %计算总能量
end



for i = 1:N * times

q_R(i) = i_R(ceil(i/times));    %模拟连续信号
q_I(i) = i_I(ceil(i/times));

% s_R(i) = q_R(i)*g(mod(i-1,times)+1); 
% s_I(i) = q_I(i)*g(mod(i-1,times)+1);

s_R(i) = q_R(i) ; 
s_I(i) = q_I(i) ; 
end 

figure('name','r(t)')

r_R = awgn(s_R,SNR);    %r(t)实部加入噪声
r_I = awgn(s_I,SNR);    %r(t)虚部加入噪声
 
n_R = r_R - s_R;    %n(t)实部
n_I = r_I - s_I;    %n(t)虚部

subplot(2,1,1)
plot(n,r_R,'r');
xlabel('t/ns');
title('real part')

hold on;

subplot(2,1,2)
plot(n,r_I,'b');
xlabel('t/ns');
title('imaginary part')


figure('name','n(t)')

subplot(2,1,1)
plot(n,n_R,'r');
xlabel('t/ns');  
title('real part')

hold on;

subplot(2,1,2)
plot(n,n_I,'b');
xlabel('t/ns');  
title('imaginary part')


