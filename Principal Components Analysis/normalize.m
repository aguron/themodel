function [M_z] = normalize(M, scale)
%NORMALIZE normalizes each column of the matrix M such that the
%   standard deviation is set to scale. The function assumes
%   that each column has a mean of 0.

std_M = zeros(1,size(M,2));
M_z = M;

for i = 1:size(M,2)
    std_M(:,i) = sqrt((M(:,i)'*M(:,i))/(size(M,1) - 1));
    if (std_M(:,i) ~= 0)
        M_z(:,i) = M(:,i)/std_M(i);
    end
end

M_z = sqrt(scale)*M_z;

end

