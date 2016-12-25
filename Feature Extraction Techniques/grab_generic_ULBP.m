%% Code By- Kedar Amrolkar and Arpita Tugave, 
%  University of Florida, Gainesville 
%  
%% GRAB feature detector

function Grab_vector = grab_generic_ULBP(varargin)

error(nargchk(1,3,nargin));

polar_array=varargin{1};
[m, n] = size(polar_array);
   
f1 = fspecial('gaussian', [3 3]);
f2 = fspecial('gaussian', [5 5]);
f3 = fspecial('gaussian', [7 7]);
polar_array1 = polar_array;
polar_array2 = polar_array;

% 3*3 smoothing and associated feature vector
polar_array = conv2(double(polar_array), f1);
polar_array = polar_array(2:end-1,2:end-1);
if nargin==1
    feature_vector1 = ULBP_Generic(polar_array);
elseif nargin==2
    feature_vector1 = ULBP_Generic(polar_array,varargin{2});
elseif nargin==3
    feature_vector1 = ULBP_Generic(polar_array,varargin{2},varargin{3});
end
feature_vector1 = feature_vector1';

% 5*5 smoothing and associated feature vector
polar_array1 = conv2(double(polar_array1), f2);
polar_array1 = polar_array1(3:end-2,3:end-2);
if nargin==1
    feature_vector2 = ULBP_Generic(polar_array1);
elseif nargin==2
    feature_vector2 = ULBP_Generic(polar_array1,varargin{2});
elseif nargin==3
    feature_vector2 = ULBP_Generic(polar_array1,varargin{2},varargin{3});
end
feature_vector2 = feature_vector2';

% 7*7 smoothing and associated feature vector
polar_array2 = conv2(double(polar_array2), f3);
polar_array2 = polar_array2(4:end-3,4:end-3);
if nargin==1
    feature_vector3 = ULBP_Generic(polar_array1);
elseif nargin==2
    feature_vector3 = ULBP_Generic(polar_array1,varargin{2});
elseif nargin==3
    feature_vector3 = ULBP_Generic(polar_array1,varargin{2},varargin{3});
end
feature_vector3 = feature_vector3';

% Global GRAB feature vector
Grab_vector = [feature_vector1; feature_vector2; feature_vector3];
Grab_vector = Grab_vector';
end
