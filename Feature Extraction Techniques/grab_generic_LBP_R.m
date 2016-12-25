%% Code By- Kedar Amrolkar and Arpita Tugave, 
%  University of Florida, Gainesville 
%  
%% GRAB feature detector

function Grab_vector = grab_generic_LBP_R(varargin)

error(nargchk(1,3,nargin));

polar_array=varargin{1};
[m, n] = size(polar_array);

% % Using only the top 50% of the image 
% polar_array_resized = [];
% m = m /2 ;
% for i = 1:m
%     temp = polar_array(i, :);
%     polar_array_resized = [polar_array_resized ; temp];
% end
    
f1 = fspecial('gaussian', [3 3]);
f2 = fspecial('gaussian', [5 5]);
f3 = fspecial('gaussian', [7 7]);
polar_array1 = polar_array;
polar_array2 = polar_array;


% 3*3 smoothing and associated feature vector
polar_array = conv2(double(polar_array), f1);
encoded_image1 = zeros(m, n);
for i = 1:m
    for j = 1:n
        temp_image = polar_array(i:i+2, j:j+2);
        centre = temp_image(2, 2);
        encoded_val = (temp_image(1, 1) > centre) + ((temp_image(1, 2) > centre) * 2) + ((temp_image(2, 1) > centre) * 4) + ...
                      ((temp_image(1, 3) > centre) * 8) + ((temp_image(3, 1) > centre) * 16) + ((temp_image(2, 3) > centre) * 32) + ...
                      ((temp_image(3, 3) > centre) * 64) + ((temp_image(3, 2) > centre) * 128);
        encoded_image1(i, j) = encoded_val;
    end
end

%Default Values
window_Overlap_percentage=100;
window_size = 10;

%specific values
if nargin==2
    window_size=varargin{2};
end
if nargin==3
    window_size=varargin{2};
    window_Overlap_percentage = varargin{3};
end

window_overlap=(window_Overlap_percentage*varargin{2})/100;
numBins = 20;
feature_vector1 = [];
for i = 1:window_overlap:m
    for j = 1:window_overlap:n
        if ( (i+window_size-2 < m) && (j+window_size-2 < n))
            block = encoded_image1(i:i+window_size-1, j:j+window_size-1);
            [f, ~] = hist(block(:), numBins);
            feature_vector1 = [feature_vector1  f];
        end
    end
end
feature_vector1 = feature_vector1';

% 5*5 smoothing and associated feature vector
polar_array1 = conv2(double(polar_array1), f2);
encoded_image2 = zeros(m, n);
for i = 1:m
    for j = 1:n
        temp_image = polar_array1(i:i+2, j:j+2);
        centre = temp_image(2, 2);
        encoded_val = (temp_image(1, 1) > centre) + ((temp_image(1, 2) > centre) * 2) + ((temp_image(2, 1) > centre) * 4) + ...
                      ((temp_image(1, 3) > centre) * 8) + ((temp_image(3, 1) > centre) * 16) + ((temp_image(2, 3) > centre) * 32) + ...
                      ((temp_image(3, 3) > centre) * 64) + ((temp_image(3, 2) > centre) * 128);
        encoded_image2(i, j) = encoded_val;
    end
end

%Default Values
window_Overlap_percentage=100;
window_size = 10;

%specific values
if nargin==2
    window_size=varargin{2};
end
if nargin==3
    window_size=varargin{2};
    window_Overlap_percentage = varargin{3};
end

window_overlap=(window_Overlap_percentage*varargin{2})/100;
numBins = 20;
feature_vector2 = [];
for i = 1:window_overlap:m
    for j = 1:window_overlap:n
        if ( (i+window_size-2 < m) && (j+window_size-2 < n))
            block = encoded_image2(i:i+window_size-1, j:j+window_size-1);
            [f, ~] = hist(block(:), numBins);
            feature_vector2 = [feature_vector2  f];
        end
    end
end
feature_vector2 = feature_vector2';

% 7*7 smoothing and associated feature vector
polar_array2 = conv2(double(polar_array2), f3);
encoded_image3 = zeros(m, n);
for i = 1:m
    for j = 1:n
        temp_image = polar_array2(i:i+2, j:j+2);
        centre = temp_image(2, 2);
        encoded_val = (temp_image(1, 1) > centre) + ((temp_image(1, 2) > centre) * 2) + ((temp_image(2, 1) > centre) * 4) + ...
                      ((temp_image(1, 3) > centre) * 8) + ((temp_image(3, 1) > centre) * 16) + ((temp_image(2, 3) > centre) * 32) + ...
                      ((temp_image(3, 3) > centre) * 64) + ((temp_image(3, 2) > centre) * 128);
        encoded_image3(i, j) = encoded_val;
    end
end

%Default Values
window_Overlap_percentage=100;
window_size = 10;

%specific values
if nargin==2
    window_size=varargin{2};
end
if nargin==3
    window_size=varargin{2};
    window_Overlap_percentage = varargin{3};
end

window_overlap=(window_Overlap_percentage*varargin{2})/100;
numBins = 20;
feature_vector3 = [];
for i = 1:window_overlap:m
    for j = 1:window_overlap:n
        if ( (i+window_size-2 < m) && (j+window_size-2 < n))
            block = encoded_image3(i:i+window_size-1, j:j+window_size-1);
            [f, ~] = hist(block(:), numBins);
            feature_vector3 = [feature_vector3  f];
        end
    end
end
feature_vector3 = feature_vector3';

% Global GRAB feature vector
Grab_vector = [feature_vector1; feature_vector2; feature_vector3];
Grab_vector = Grab_vector';
end
