function partition = generatepartitions(features, mask)
%GENERATEPARTITIONS applies a set of 6 masks to the input stimulus
%
% INPUT
%   features    - features that the masks are applied to
%   mask        - set of masks to be applied to features

% OUTPUT
%   partition   - set of partitions of features

    partition.r11 = applymask(features, mask.Top.Left);
    partition.r12 = applymask(features, mask.Top.Center);
    partition.r13 = applymask(features, mask.Top.Right);
    
    partition.r21 = applymask(features, mask.Bottom.Left);
    partition.r22 = applymask(features, mask.Bottom.Center);
    partition.r23 = applymask(features, mask.Bottom.Right);
end