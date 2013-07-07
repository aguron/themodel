function B = scalecolumns(A, v)
%SCALECOLUMNS scales each column of a matrix by scale factors
%   specified in a vector
%
% INPUT
%   A   - matrix with columns to be scaled
%   v   - vector with scale factors

% OUTPUT
%   B   - matrix after scaling columns

    if size(A,2) ~= length(v)
        error('Number of columns in A and length of v should be equal');
    end
    
    B = A;
    for i=1:size(A,2)
        B(:,i) = A(:,i)*v(i);
    end
end