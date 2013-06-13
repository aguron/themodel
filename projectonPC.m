function [varargout] = projectonPC(varargin)
%PROJECTONPC takes in an arbitrary number of blocks of data
%   vectors, projects them on to specified principal components,
%   and separates them back into the respective blocks
%
% INPUTS
%   varargin{1}         = [dataVector11 - first block of data
%                          dataVector12   vectors
%                           ...
%                          dataVector1M]
%       ...
%   varargin{nargin-3}  = [dataVectorL1 - last block of data
%                          dataVectorL2   vectors
%                           ...
%                          dataVectorLN]
%   (BEFORE shifting - so that they have mean zero - and scaling
%    feature dimensions)
%
%   varargin{nargin-2}  - principal components
%   varargin{nargin-1}  - scale (sample standard deviation of 
%                         feature dimensions after normalizing)
%   varargin{nargin}    - parameter to indicate if shifting and
%                         scaling should be done before the
%                         projection; 'b', if so
%
% OUTPUTS
%   varargout{1}        = [dataVector11 - first block of data
%                          dataVector12   vectors
%                           ...
%                          dataVector1M]
%       ...
%   varargout{nargout}  = [dataVectorL1 - nargout-th block of data
%                          dataVectorL2   vectors
%                           ...
%                          dataVectorLN]
%   (AFTER shifting - so that they have mean zero - and scaling
%    feature dimensions)
%
% N.B. nargin = nargout + 3

    % Combine the blocks of data vectors
    data = [];
    for i=1:nargin-3
        data = [data; varargin{i}];
    end

    % Z-scoring before projection on to the principal components
    if varargin{nargin} == 'b'
        zscoredData1 = zscore(data, varargin{nargin-1});
    else
        zscoredData1 = data;
    end

    % Projection on to the principal components
    %
    % The rows of projFeatures correspond to the projected
    % data vectors
    projData = zscoredData1*varargin{nargin-2};
    
    % Z-scoring after PCA
    zscoredData2 = zscore(projData, varargin{nargin-1});

    % Separate the blocks of data vectors
    blockStart = 1;
    for i=1:nargout
        numData_i = size(varargin{i}, 1);
        blockEnd = (blockStart + numData_i) - 1;
        varargout{i} = zscoredData2(blockStart:blockEnd,:);
        blockStart = blockStart + numData_i;
    end
end