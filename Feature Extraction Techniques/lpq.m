function LPQ_vector = lpq(polar_array, r)
% Local Phase Quantization (LPQ)
% [h, B] = lpq(T, r)
% where 
%   T = input image
%   r = radius of the operator (default = 3)
%   h = resulting lpq histogram
%   B = labeled image

% Reference: 
% Ojansivu V & Heikkil?J (2008) Blur insensitive texture classification 
% using local phase quantization. Proc. Image and Signal Processing 
% (ICISP 2008), Cherbourg-Octeville, France, 5099:236-243.
%
% Copyright 2008 by Heikkil?& Ojansivu

if nargin == 1
    r = 3; %default radius
end

LPQ_vector = [];
polar_array = single(polar_array);
Wx = 10;
Wy = 10;
for i = 1:Wx:size(polar_array, 1)
    for j = 1:Wy:size(polar_array, 2) 

    image_patch = polar_array(i:i+Wx-1, j:j+Wy-1);
    f = 1;
    x = -r:r; % Block definition
    n = length(x); %Block size
    rho = 0.95;

    % Computing the Covariance matrix
    [xp, yp] = meshgrid(1:n, 1:n);
    pp = [xp(:) yp(:)];
    dd = dist(pp , pp'); %L2 norm between corresponding points
    C = rho.^dd;

    % Short Term Fourier Transform for each block
    w0 = ((x * 0) + 1);
    w1 = exp(-2 * pi * 1i * x * (f / n));
    w2 = conj(w1);

    q1 = w0.'*w1;
    q2 = w1.'*w0;
    q3 = w1.'*w1;
    q4 = w1.'*w2;

    u1 = real(q1); u2 = imag(q1);
    u3 = real(q2); u4 = imag(q2);
    u5 = real(q3); u6 = imag(q3);
    u7 = real(q4); u8 = imag(q4);
    M = [u1(:)'; u2(:)'; u3(:)'; u4(:)'; u5(:)'; u6(:)'; u7(:)'; u8(:)'];

    % Decorrelation by computing SVD of combination of C and transformation
    % matrix M(this is done to ensure that 
    D = M * C * M';
    [~,~,V] = svd(D);

    % Quantization of terms
    Qa = conv2(conv2(image_patch, w0.', 'same'), w1, 'same');
    Qb = conv2(conv2(image_patch, w1.', 'same'), w0, 'same');
    Qc = conv2(conv2(image_patch, w1.', 'same'), w1, 'same');
    Qd = conv2(conv2(image_patch, w1.', 'same'), w2, 'same');

    Fa = real(Qa); Ga = imag(Qa);
    Fb = real(Qb); Gb = imag(Qb);
    Fc = real(Qc); Gc = imag(Qc);
    Fd = real(Qd); Gd = imag(Qd);
    F = [Fa(:) Ga(:) Fb(:) Gb(:) Fc(:) Gc(:) Fd(:) Gd(:)];

    % Applying whitening transform to F using V obtained by the SVD of D
    G = (V' * F');

    % Applying Binary Coding to convert each value to an 8 bit integer
    t = 0;
    B = (G(1,:) >= t) + ((G(2,:) >= t) * 2) + ((G(3,:) >= t) * 4) + ((G(4,:) >= t) * 8) + ((G(5,:) >= t) * 16) + ((G(6,:) >=t) * 32) + ((G(7,:) >=t) * 64) + ((G(8,:) >= t) * 128);
    B = reshape(B, size(Fa, 1), size(Fa, 2));

    % Computing the LQP histogram
    numBins = 50;
    [frequencies, ~] = hist(B(:), numBins);
    frequencies = frequencies / sum(frequencies);
    % frequencies = reshape(frequencies, [1 size(frequencies, 1) * size(frequencies, 2)]);
    LPQ_vector = [LPQ_vector frequencies];
    end
end
end
