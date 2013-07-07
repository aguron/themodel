% Script
%
% LOADDATA
%   Notes:
%   07/04/2013
%     - retrieve results

monitorTime = 0;

file = 'compositefacesimulations.mat';

load(file, 'confusionMatrix')
load(file, 'confusionVectors')
load(file, 'percentAccuracy')
load(file, 'SDT')
load(file, 'rates')
load(file, 'confidenceInterval')
load(file, 'reactionTime')
load(file, 'confidence')
if (monitorTime == 1)
    load(file, 'performance')
end