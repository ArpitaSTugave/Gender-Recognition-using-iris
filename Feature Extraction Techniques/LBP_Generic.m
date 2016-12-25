%% Implementaion of function LBP

% version 0.1
% Authors: Arpita Tugave and Kedar Amrolkar
% Usage: 
% window_size of type int takes size of window
% percentage_overlap takes percentage portion of window overlapping

%% Sample example:

% for non-windowed and non-overlapping
%[LBP] = LBP(image_name);
% for non-windowed and non-overlapping
%[LBP] = LBP(image_name,10); %for window size of 10x10
% for non-windowed and non-overlapping
%[LBP] = LBP(image_name , 10 , 50); %for window size of 10x10
%and window overlap of 50%

%% Code:

function [ LBPhist ] = LBP_Generic( varargin) 
% I2 ,  window_size ,  percentage_overlap

LBPhist = [];

% Check number of input arguments.
error(nargchk(1,3,nargin));

%I2 is the image for which LBP has to be found
I2=varargin{1};
m=size(I2,1);
n=size(I2,2);

%This case is for non-windowed and non-overlapping
if nargin==1
    
for i=2:m-1
    for j=2:n-1
        J0=I2(i,j);
        I3(i-1,j-1)=I2(i-1,j-1)>J0;
        I3(i-1,j)=I2(i-1,j)>J0;
        I3(i-1,j+1)=I2(i-1,j+1)>J0; 
        I3(i,j+1)=I2(i,j+1)>J0;
        I3(i+1,j+1)=I2(i+1,j+1)>J0; 
        I3(i+1,j)=I2(i+1,j)>J0; 
        I3(i+1,j-1)=I2(i+1,j-1)>J0; 
        I3(i,j-1)=I2(i,j-1)>J0;
        LBP(i,j)=I3(i-1,j-1)*2^7+I3(i-1,j)*2^6+I3(i-1,j+1)*2^5+...
            I3(i,j+1)*2^4+I3(i+1,j+1)*2^3+I3(i+1,j)*2^2+I3(i+1,j-1)...
            *2^1+I3(i,j-1)*2^0;
    end
end

    [h,w]= size(LBP);
    mid_LBP = reshape(LBP',1, h*w);
    mid_LBP = [0 mid_LBP 255];
    LBPh = hist(mid_LBP,256);
    LBPhist = [LBPhist LBPh];

end

%This case is for windowed and non-overlapping
if nargin==2
    
window_size=varargin{2};

for a = 1:window_size:m
    count1 = 0;
    for b = 1:window_size:n
        LBP = [];
        for i=a+1:a+window_size-2
            for j=b+1:b+window_size-2
                J0=I2(i,j);
                I3(i-1,j-1)=I2(i-1,j-1)>J0;
                I3(i-1,j)=I2(i-1,j)>J0;
                I3(i-1,j+1)=I2(i-1,j+1)>J0; 
                I3(i,j+1)=I2(i,j+1)>J0;
                I3(i+1,j+1)=I2(i+1,j+1)>J0; 
                I3(i+1,j)=I2(i+1,j)>J0; 
                I3(i+1,j-1)=I2(i+1,j-1)>J0; 
                I3(i,j-1)=I2(i,j-1)>J0;
                LBP(i-a,j-b)=I3(i-1,j-1)*2^7+I3(i-1,j)*2^6+I3(i-1,j+1)*2^5+...
                    I3(i,j+1)*2^4+I3(i+1,j+1)*2^3+I3(i+1,j)*2^2+I3(i+1,j-1)...
                    *2^1+I3(i,j-1)*2^0;         
            end
        end
                [h,w]= size(LBP);
                mid_LBP1 = reshape(LBP',1, h*w);
                mid_LBP2 = [0 mid_LBP1 255];
                LBPh = hist(mid_LBP2,256);
                LBPhist = [LBPhist LBPh];
    
    end
end

end

%This case is for windowed and overlapping
if nargin==3

window_size=varargin{2};
window_overlap=(varargin{3}*window_size)/100;
    
for a = 1:window_overlap:m
    count1 = 0;
    for b = 1:window_overlap:n
        LBP = [];
        if ( (a+window_size-2 < m) && (b+window_size-2 < n))
            for i=a+1:a+window_size-2
                for j=b+1:b+window_size-2
                    J0=I2(i,j);
                    I3(i-1,j-1)=I2(i-1,j-1)>J0;
                    I3(i-1,j)=I2(i-1,j)>J0;
                    I3(i-1,j+1)=I2(i-1,j+1)>J0;
                    I3(i,j+1)=I2(i,j+1)>J0;
                    I3(i+1,j+1)=I2(i+1,j+1)>J0;
                    I3(i+1,j)=I2(i+1,j)>J0;
                    I3(i+1,j-1)=I2(i+1,j-1)>J0;
                    I3(i,j-1)=I2(i,j-1)>J0;
                    LBP(i-a,j-b)=I3(i-1,j-1)*2^7+I3(i-1,j)*2^6+I3(i-1,j+1)*2^5+...
                        I3(i,j+1)*2^4+I3(i+1,j+1)*2^3+I3(i+1,j)*2^2+I3(i+1,j-1)...
                        *2^1+I3(i,j-1)*2^0;
                end
            end
            [h,w]= size(LBP);
            mid_LBP1 = reshape(LBP',1, h*w);
            mid_LBP2 = [0 mid_LBP1 255];
            LBPh = hist(mid_LBP2,256);
            LBPhist = [LBPhist LBPh];
        end    
    end
end

end

end
