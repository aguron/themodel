% Script
%
% SAVEDATA
%   Notes:
%   07/03/2013
%     - save results


file = 'compositefacesimulations.mat';
save(file, 'confusionMatrix')
save(file, 'confusionVectors', '-append')
save(file, 'percentAccuracy', '-append')
save(file, 'SDT', '-append')
save(file, 'rates', '-append')
save(file, 'confidenceInterval', '-append')
save(file, 'reactionTime', '-append')
save(file, 'confidence', '-append')

if (monitorTime == 1)
    save('compositefacesimulations.mat', 'performance', '-append')
end