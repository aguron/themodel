function c_i = confidenceinterval(data, alpha)
%CONFIDENCEINTERVAL computes the 100*(1-alpha)% confidence level
%   for the data. The standard error is computed by default
    switch nargin
        case 1
            c_i = std(data)/sqrt(length(data));
        case 2
            c_i = norminv(1-(alpha/2))*(std(data)/sqrt(length(data)));
        otherwise
            disp('Error: 1 or 2 arguments accepted');

    end
end