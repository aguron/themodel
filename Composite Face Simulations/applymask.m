function featuresMasked = applymask(features, mask)
%APPLYMASK applies a mask to a set of Gabor features
%
% INPUT
%   features        - features that the mask is applied to
%   mask            - mask to be applied to features

% OUTPUT
%   featuresMasked  - resulting features

    featuresMasked = zeros(size(features));
    for i=1:size(features,1)
       featuresMasked(i,:) =...
           mask.*features(i,:);
    end
end