%张志豪-2019270103014
%assignement1


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

for i = 1:N           %替换为对应星座图坐标
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

e_expectation = e_total/N; %计算相关数据
es = eg * e_expectation ;
eb = es / (log2(M))

for i = 1:N * times

q_R(i) = i_R(ceil(i/times));    %模拟连续信号
q_I(i) = i_I(ceil(i/times));

% s_R(i) = q_R(i)*g(mod(i-1,times)+1); 
% s_I(i) = q_I(i)*g(mod(i-1,times)+1);
s_R(i) = q_R(i) ; 
s_I(i) = q_I(i) ; 
end 
subplot(2,1,1);
stem(n,s_R,'r','.');    %绘制s（t）实部
xlabel('t/ns');                                     
title('real part')

hold on;
subplot(2,1,2);
stem(n,s_I,'b','.');  %绘制s（t）实部
xlabel('t/ns');                                     
title('imaginary part');





