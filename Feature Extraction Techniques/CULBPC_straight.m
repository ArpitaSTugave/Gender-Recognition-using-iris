function [ ULBPhist ] = CULBPC_straight(I2)


% form table array to choose uniform LBP values
table = zeros(1, 256);
nextLabel = 0;
    for k = 0:255
        bits = bitand(k, 2.^(7:-1:0))>0;
        if nnz(diff(bits([1:end, 1]))) <= 2
            table(k+1) = nextLabel;
            nextLabel = nextLabel + 1;
        else
            table(k+1) = 58;
        end
    end 

ULBPhist = [];


window_size = 10;
window_overlap = (50*window_size)/100;
m=size(I2,1);
n=size(I2,2);


for a = 1:window_overlap:m
    for b = 1:window_overlap:n
         if ( (a+window_size-2 < m) && (b+window_size-2 < n))
        for i=a+1:a+window_size-2
            for j=b+1:b+window_size-2
            J0=double(I2(i,j));
            c =(abs(double(I2(i-1,j-1))-J0) +  abs(double(I2(i-1,j))-J0) + ...
                abs(double(I2(i-1,j+1))-J0) + abs(double(I2(i,j+1))-J0) + ...
                abs(double(I2(i+1,j+1))-J0) + abs(double(I2(i+1,j))-J0) + ...
                abs(double(I2(i+1,j-1))-J0) + abs(double(I2(i,j-1))-J0) )/8;
            I3(i-1,j-1)=I2(i-1,j)>J0;
            I3(i-1,j)=abs(double(I2(i-1,j))-J0)>c;
            I3(i-1,j+1)=I2(i,j+1)>J0; 
            I3(i,j+1)=abs(double(I2(i,j+1))-J0)>c;
            I3(i+1,j+1)=I2(i+1,j)>J0;
            I3(i+1,j)=abs(double(I2(i+1,j))-J0)>c; 
            I3(i+1,j-1)=I2(i,j-1)>J0; 
            I3(i,j-1)=abs(double(I2(i,j-1))-J0)>c;
            LBP(i-a,j-b)=I3(i-1,j-1)*2^7+I3(i-1,j)*2^6+I3(i-1,j+1)*2^5....
            +I3(i,j+1)*2^4+I3(i+1,j+1)*2^3+I3(i+1,j)*2^2+I3(i+1,j-1)...
                *2^1+I3(i,j-1)*2^0;  
                ULBP(i-a,j-b)=table(LBP(i-a,j-b)+ 1);
            end
        end
            [h,w]= size(ULBP);
            mid_ULBP = reshape(ULBP',1, h*w);
            ULBPh = hist(mid_ULBP,59);
            ULBPhist = [ULBPhist ULBPh];
         end
    
    end
end

end