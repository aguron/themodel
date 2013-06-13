function M = percent(A, index, dimension)
%PERCENT computes the percent contribution of a value in a
%   one-dimensional array to the sum of all the values or performs
%   the aforementioned computation along the rows or columns of a
%   matrix. (The default is along the columns.) All the values in
%   the array must be nonnegative and the sum of each column (row)
%   must be positive if the computation is along the columns (rows)
    if (nargin == 2)
        % DIMENSION is not specified
        % convert row vectors to column vectors
        % computation is performed along columns
        if (size(A,1)==1)
            A = A';
        end
        M = 100*A(index,:)./sum(A);
    elseif (nargin == 3)
        % DIMENSION is specified
        if (dimension == 1)
            M = 100*A(index,:)./sum(A);
        elseif (dimension == 2)
            M = 100*A(:,index)./sum(A,2);
        else
            disp('Error: dimension must be 1 or 2');
        end        
    else
      disp('Error: 2 or 3 arguments accepted');
    end
end

