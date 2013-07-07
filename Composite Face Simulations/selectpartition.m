function partitionUnion =...
    selectpartition(partition, rangeVertical, rangeHorizontal)
%SELECTPARTITION returns a specified partition
%
% INPUT
%   partition       - set of partitions
%   rangeVertical   - vertical range of subregions
%   rangeHorizontal - horizontal range of regions

% OUTPUT
%   partitionUnion  - union of the input partitions

    partitionUnion = 0;

    for i=rangeVertical(1):rangeVertical(2)
        for j=rangeHorizontal(1):rangeHorizontal(2)
            partitionUnion =...
                partitionUnion +...
                eval(['partition.r', num2str(i), num2str(j)]);
        end
    end
end