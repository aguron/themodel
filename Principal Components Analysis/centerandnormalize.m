function zscoredDataSet = centerandnormalize(dataSet, scale)
%CENTERANDNORMALIZE shifts each feature dimension such that the
%   mean is zero and the sample standard deviation is set
%   according to SCALE
%
% INPUTS
%   dataSet = [dataVector1          - data before operations
%              dataVector2
%                   ...
%              dataVectorM]
%   scale                           - sample standard deviation 
%                                     of feature dimensions after
%                                     normalizing
%
% OUTPUT
%   zscoredDataSet = [dataVector1   - data after operations
%                     dataVector2
%                       ...
%                     dataVectorM]

    % Shift each feature dimension such that the mean is zero
    dataSet = meancenter(dataSet);

    % Normalize values for each feature dimension
    zscoredDataSet = normalize(dataSet, scale);
end