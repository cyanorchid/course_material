function[X]=ffts(x,len_x)

    %记入输入信号的长度
    len_in = length(x);

    %将x补全到len_x
    x = [x, zeros(1, len_x-len_in)];
    
    %计算蝶形运算的级数
    nbinary = dec2bin(len_in);
    len_bin = length(nbinary(2:end)); 
    storage = zeros(len_in, len_bin+1);

    %处理输入信号
    for i = 0 : len_in-1
        nbinary = dec2bin(i, len_bin);
        nbinary = rot90(nbinary, 2);    
        storage(i+1, 1) = x(bin2dec(nbinary)+1);
    end

    %进行蝶形傅里叶变换
    for j = 0 : len_bin-1
        
    %计算相应的W组    
        for k = 1 : 2^j
            W(k) = cos((pi / 2^j) * (k - 1)) - 1j * sin((pi / 2^j) * (k - 1)); 
        end
        
        %计算蝶形部分
        for i = 1 : k
            for order = 1 : len_in/(2^(j+1))
                a = i + (order - 1) * 2^(j + 1); 
                b = a + 2^j;
                storage(a, j+2) = storage(a, j+1) + W(i) * storage(b, j+1);
                storage(b, j+2) = storage(a, j+1) - W(i) * storage(b, j+1); 
            end
        end
        
        
    end

    X = storage(:, len_bin+1);
    j = size(X);
    size_x = size(x);
    
    
    if j ~= size_x
        X = X';
    end
    
    
end