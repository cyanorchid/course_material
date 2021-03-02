%张志豪-2019270103014
%assignement6
%格雷映射


N = 128000 ;
b0 = randi([0,1],1,N*4);     
for i=1:1:N    %按照格雷映射规则转换为对应的坐标
    if b0(4*(i-1)+1)==0 && b0(4*(i-1)+2)==0 &&b0(4*(i-1)+3)==0&& b0(4*(i-1)+4)==0
       i_R(i) = 3 ; 
       i_I(i) = 3 ; 
    end
    if b0(4*(i-1)+1)==0 && b0(4*(i-1)+2)==0 &&b0(4*(i-1)+3)==0&& b0(4*(i-1)+4)==1
       i_R(i) = 1 ; 
       i_I(i) = 3 ; 
    end
    if b0(4*(i-1)+1)==0 && b0(4*(i-1)+2)==0 &&b0(4*(i-1)+3)==1&& b0(4*(i-1)+4)==0
       i_R(i) = 1 ; 
       i_I(i) = -3 ; 
    end
    if b0(4*(i-1)+1)==0 && b0(4*(i-1)+2)==0 &&b0(4*(i-1)+3)==1&& b0(4*(i-1)+4)==1
       i_R(i) = 3 ; 
       i_I(i) = -3 ; 
    end
    if b0(4*(i-1)+1)==0 && b0(4*(i-1)+2)==1 &&b0(4*(i-1)+3)==0&& b0(4*(i-1)+4)==0
       i_R(i) = 3 ; 
       i_I(i) = 1 ; 
    end
    if b0(4*(i-1)+1)==0 && b0(4*(i-1)+2)==1 &&b0(4*(i-1)+3)==0&& b0(4*(i-1)+4)==1
       i_R(i) = 1 ; 
       i_I(i) = 1 ; 
    end
    if b0(4*(i-1)+1)==0 && b0(4*(i-1)+2)==1 &&b0(4*(i-1)+3)==1&& b0(4*(i-1)+4)==0
       i_R(i) = 1 ; 
       i_I(i) = -1 ; 
    end
    if b0(4*(i-1)+1)==0 && b0(4*(i-1)+2)==1 &&b0(4*(i-1)+3)==1&& b0(4*(i-1)+4)==1
       i_R(i) = 3 ; 
       i_I(i) = -1 ; 
    end
    if b0(4*(i-1)+1)==1 && b0(4*(i-1)+2)==0 &&b0(4*(i-1)+3)==0&& b0(4*(i-1)+4)==0
       i_R(i) = -3 ; 
       i_I(i) = 1 ; 
    end
    if b0(4*(i-1)+1)==1 && b0(4*(i-1)+2)==0 &&b0(4*(i-1)+3)==0&& b0(4*(i-1)+4)==1
       i_R(i) = -1 ; 
       i_I(i) = 1 ; 
    end
    if b0(4*(i-1)+1)==1 && b0(4*(i-1)+2)==0 &&b0(4*(i-1)+3)==1&& b0(4*(i-1)+4)==0
       i_R(i) = -1 ; 
       i_I(i) = -1 ; 
    end
    if b0(4*(i-1)+1)==1 && b0(4*(i-1)+2)==0 &&b0(4*(i-1)+3)==1&& b0(4*(i-1)+4)==1
       i_R(i) = -3 ; 
       i_I(i) = -1 ; 
    end
    if b0(4*(i-1)+1)==1 && b0(4*(i-1)+2)==1 &&b0(4*(i-1)+3)==0&& b0(4*(i-1)+4)==0
       i_R(i) = -3 ; 
       i_I(i) = 3 ; 
    end
    if b0(4*(i-1)+1)==1 && b0(4*(i-1)+2)==1 &&b0(4*(i-1)+3)==0&& b0(4*(i-1)+4)==1
       i_R(i) = -1 ; 
       i_I(i) = 3 ; 
    end
    if b0(4*(i-1)+1)==1 && b0(4*(i-1)+2)==1 &&b0(4*(i-1)+3)==1&& b0(4*(i-1)+4)==0
       i_R(i) = -1 ; 
       i_I(i) = -3 ; 
    end
    if b0(4*(i-1)+1)==1 && b0(4*(i-1)+2)==1 &&b0(4*(i-1)+3)==1&& b0(4*(i-1)+4)==1
       i_R(i) = -3 ; 
       i_I(i) = -3 ; 
    end
end

n = (1:N);  %与序列等长向量
T = 1*10^(-9) ;     %g（t）时间
M = 16 ;            %16QAM
es = 0 ;    %平均符号能量
eb = 0 ;    %平均比特能量
e_total=0;  %总能量
e_expectation = 0;    %|In|^2的期望
times = 100 ;    %每1ns取样点个数
b = 10^9;  %带宽
SNR = 0;


g = ones(1,times) ;   
h = g ;
eg = T; 


% g = 1/times:1/times:1 ;
% h = 1:-1/times:1/times;
% eg = T/3;
% 

for i = 1:N

    if(i_R(i) == 2)
        i_R(i) = 3;   %转换生成的序列，2->3
    end
    if(i_R(i) == 0)
        i_R(i) = -3;    %0->3
    end
    if(i_I(i) == 2)
        i_I(i) = 3;    %2->3
    end
    if(i_I(i) == 0)
        i_I(i) = -3;    %0->3
    end
     e_total = e_total + i_R(i)^2 + i_I(i)^2;    %计算总能量
end
e_expectation = e_total/N;  %计算相关数据
es = eg * e_expectation;
eb = es / (log2(M));


  for SNR = 0:1:12
k = eb/(10^(SNR/10))/2;
% t_R = i_R +  wgn(1,N,k*b,'linear');   %加入噪声
% t_I = i_I +  wgn(1,N,k*b,'linear');

% 
% t_R =  awgn(i_R,SNR,'measured');     %加入噪声
% t_I =  awgn(i_I,SNR,'measured');   



for i = 1:N * times

q_R(i) = i_R(ceil(i/times));    %离散化
q_I(i) = i_I(ceil(i/times));

p_R(i) = q_R(i)*g(mod(i-1,times)+1);  %与g（t）相乘
p_I(i) = q_I(i)*g(mod(i-1,times)+1);

% r_R(i) = p_R(i);
% r_I(i) = p_I(i);

end


r_R = p_R +  wgn(1,N*times,k*b*times,'linear');      %加入噪声
r_I = p_I +  wgn(1,N*times,k*b*times,'linear');  

% r_R = awgn(p_R,SNR,'measured');      %加入噪声
% r_I = awgn(p_I,SNR,'measured');  

z_R = conv(r_R,h)/times;   %匹配滤波后z（t）实部
z_I = conv(r_I,h)/times;   %匹配滤波后z（t）虚部

i1_R = zeros(1,N)/times;
i1_I = zeros(1,N)/times;

for m = times :times :N*times
    x_min = 1000000 ;
    i1_R(m/times)  = -3  ;
    for i = -3 : 2 :3       %寻找最近x坐标，并记入i1
        if( abs( z_R(m) - eg*i/T) < x_min)
            i1_R(m/times)  = i ;
            x_min = abs( z_R(m)- eg*i/T) ;
        end
    end
    y_min = 1000000 ;
    i1_I(m/times) = -3  ;
    for i = -3 : 2 :3       %寻找最近y坐标，并记入i1
        if( abs( z_I(m) - eg*i/T) < y_min)
             i1_I(m/times)  = i ;
             y_min = abs( z_I(m) - eg*i/T) ; 
        end
    end
end



for i=1:1:N    %将对应坐标转换为原比特序列
    if i1_R(i) == 3 && i1_I(i) == 3 ; 
        b1(4*(i-1)+1)=0;
        b1(4*(i-1)+2)=0;
        b1(4*(i-1)+3)=0;
        b1(4*(i-1)+4)=0;
    end
    if i1_R(i) == 1 &&i1_I(i) == 3
        b1(4*(i-1)+1)=0;
        b1(4*(i-1)+2)=0;
        b1(4*(i-1)+3)=0;
        b1(4*(i-1)+4)=1;
    end
    if i1_R(i) == 1 &&i1_I(i) == -3 
        b1(4*(i-1)+1)=0;
        b1(4*(i-1)+2)=0;
        b1(4*(i-1)+3)=1;
        b1(4*(i-1)+4)=0;
    end
    if i1_R(i) == 3 &&i1_I(i) == -3 
        b1(4*(i-1)+1)=0;
        b1(4*(i-1)+2)=0;
        b1(4*(i-1)+3)=1;
        b1(4*(i-1)+4)=1;
    end
    if i1_R(i) == 3 &&i1_I(i) == 1 
        b1(4*(i-1)+1)=0;
        b1(4*(i-1)+2)=1;
        b1(4*(i-1)+3)=0; 
        b1(4*(i-1)+4)=0;
    end
    if i1_R(i) == 1 &&i1_I(i) == 1 
        b1(4*(i-1)+1)=0; 
        b1(4*(i-1)+2)=1;
        b1(4*(i-1)+3)=0; 
        b1(4*(i-1)+4)=1;
    end
    if i1_R(i) == 1 &&i1_I(i) == -1 
        b1(4*(i-1)+1)=0;
        b1(4*(i-1)+2)=1;
        b1(4*(i-1)+3)=1;
        b1(4*(i-1)+4)=0;
    end
    if i1_R(i) == 3 &&i1_I(i) == -1 
        b1(4*(i-1)+1)=0;
        b1(4*(i-1)+2)=1;
        b1(4*(i-1)+3)=1; 
        b1(4*(i-1)+4)=1;
    end
    if i1_R(i) == -3 &&i1_I(i) == 1 
        b1(4*(i-1)+1)=1; 
        b1(4*(i-1)+2)=0;
        b1(4*(i-1)+3)=0;
        b1(4*(i-1)+4)=0;
    end
    if i1_R(i) == -1 &&i1_I(i) == 1 
        b1(4*(i-1)+1)=1;
        b1(4*(i-1)+2)=0;
        b1(4*(i-1)+3)=0; 
        b1(4*(i-1)+4)=1;
    end
    if i1_R(i) == -1 &&i1_I(i) == -1 
        b1(4*(i-1)+1)=1;
        b1(4*(i-1)+2)=0;
        b1(4*(i-1)+3)=1; 
        b1(4*(i-1)+4)=0;
    end
    if i1_R(i) == -3 &&i1_I(i) == -1
        b1(4*(i-1)+1)=1; 
        b1(4*(i-1)+2)=0;
        b1(4*(i-1)+3)=1; 
        b1(4*(i-1)+4)=1;
    end
    if i1_R(i) == -3 &&i1_I(i) == 3 
        b1(4*(i-1)+1)=1;
        b1(4*(i-1)+2)=1;
        b1(4*(i-1)+3)=0;
        b1(4*(i-1)+4)=0;
    end
    if i1_R(i) == -1 &&i1_I(i) == 3
        b1(4*(i-1)+1)=1;
        b1(4*(i-1)+2)=1;
        b1(4*(i-1)+3)=0;
        b1(4*(i-1)+4)=1;
    end
    if i1_R(i) == -1 &&i1_I(i) == -3 
        b1(4*(i-1)+1)=1;
        b1(4*(i-1)+2)=1;
        b1(4*(i-1)+3)=1; 
        b1(4*(i-1)+4)=0;
    end
    if i1_R(i) == -3 && i1_I(i) == -3
       b1(4*(i-1)+1)=1; 
       b1(4*(i-1)+2)=1;
       b1(4*(i-1)+3)=1;
       b1(4*(i-1)+4)=1;
    end
end


num_err = 0 ;%错误数
num_err1 = 0 ;%格雷映射比特错误数
for i = 1:N*4
    if(b0(i) ~= b1(i)) %计算错误数
        num_err1 = num_err1 + 1 ;
    end
end

for i = 1:N
    if(i1_R(i) ~= i_R(i)||i1_I(i) ~= i_I(i)) %计算错误数
        num_err = num_err + 1 ;
    end
end
p_16(SNR+1)=3*qfunc(sqrt(4*10^(SNR/10)/5))*(1-3/4*qfunc(sqrt(4*10^(SNR/10)/5)));
% p_16(SNR+1)=4*qfunc(sqrt(3*10^(SNR/10)/(M-1)))*(1-1/sqrt(M)) ; %理论值
p_e(SNR+1)= num_err/N ;%实际误码率值
% p_16(SNR+1) = 4*(1-1/sqrt(M)) * qfunc(sqrt(3*10^(SNR/10)/(M-1)));%理论误码率
p_e2(SNR+1)= num_err1/N/4; %格雷映射比特错误率实际值
 end

snr_num =0:1:12 ;
semilogy(snr_num,p_16,'r',snr_num,p_e,'b',snr_num,p_e2,'k')
xlabel('SNR');
title('格雷映射下的比特错误概率 ')
figure
semilogy(snr_num,p_e1,'r',snr_num,p_e2,'b')
xlabel('SNR');
title('格雷映射与自然映射的比特错误概率 ')

