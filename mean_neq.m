function m = mean_neq(a, num, dim)
%MEAN_NEQ computes the mean/means of the values in an array not
%   equal to the specified number or returns the specified number
%   where all the values in a row/column are equal to the number
siz = size(a);
if (nargin == 2) && (min(siz) > 1)
    dim = 1;
    num_args = 3;
else
    num_args = nargin;
end

switch num_args
    case 2 % array is a vector
        if sum(a ~= num) == 0
            m = 0;
        else
            m = mean(a(a ~= num));
        end
    case 3 % array is multidimensional
        m = zeros(siz(mod(dim,2) + 1), 1);

        if dim == 1
            m = m';
        end

        for i=1:siz(mod(dim,2) + 1)
            switch dim
                % Compute means of columns
                case 1
                    temp = a(:,i);
                % Compute means of rows
                case 2
                    temp = a(i,:);
                otherwise
                    disp('invalid array dimension');
            end
            
            if sum(temp ~= num) == 0
                m(i) = num;
            else
                m(i) = mean(temp(temp ~= num));
            end
        end
    otherwise
        error('invalid number of arguments');
end

end