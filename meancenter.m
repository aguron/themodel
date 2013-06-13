function [M_c] = meancenter(M)
%MEAN_CENTER calculates the mean of each column in the matrix M and
% subtracts each mean from each element in the column corresponding
% to that mean value.

% mean(M) returns a row vector containing the mean of each column of M
mean_M = mean(M);

% Center each column of M
M_c = M;
for i = 1:size(M,2)
    M_c(:,i) = M(:,i) - mean_M(i);
end

end

