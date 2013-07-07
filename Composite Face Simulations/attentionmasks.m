% Script
%
% ATTENTIONMASKS
% This script generates masks which have a value of 1 in
% in the indicated regions and a value of 0 elsewhere.
%
%   Functions called:
%       unravel
%
% INPUTS
%   n.gaborFilters          - number of Gabor filters
%   n.dimensionHorizontal   - horizontal dimensions of grid of
%                             Gabor filter samples for each image
%   n.dimensionVertical     - vertical dimensions of grid of
%                             Gabor filter samples for each image
%
% OUTPUT
%   mask                    - struct with the masks which have a
%                             value of 1 in the indicated regions
%                             and a value of 0 elsewhere.
%
% Gabor filter feature vector, GFF
%  = [GFF_1 .... GFF_40]
% GFF_i - Gabor filter features for a filter in the
%         filter bank
% GFF_i = [GFF_i_Top GFF_i_Bottom]
%
% Each grid of Gabor filter samples can be partitioned into six
% regions:
%
%     0                  1/3                   2/3                   1
%  0  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     %  TOP LEFT (r11)   %  TOP CENTER (r12)   %  TOP RIGHT (r13)   %
% 1/2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     % BOTTOM LEFT (r21) % BOTTOM CENTER (r22) % BOTTOM RIGHT (r23) %
%  1  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Create the masks
temp = ones(n.dimensionVertical, n.dimensionHorizontal);
[col, row] = meshgrid(1:n.dimensionHorizontal, 1:n.dimensionVertical);

% region boundaries
boundaryRight = ceil(2*n.dimensionHorizontal/3);
boundaryLeft = ceil(n.dimensionHorizontal/3);
boundaryMiddle = ceil(n.dimensionVertical/2);

% Regions
r11 = ((col < boundaryLeft) & (row < boundaryMiddle)).*temp;
r12 = ((col >= boundaryLeft) & (col < boundaryRight) &...
       (row < boundaryMiddle)).*temp;
r13 = ((col >= boundaryRight) & (row < boundaryMiddle)).*temp;

r21 = ((col < boundaryLeft) & (row >= boundaryMiddle)).*temp;
r22 = ((col >= boundaryLeft) & (col < boundaryRight) &...
       (row >= boundaryMiddle)).*temp;
r23 = ((col >= boundaryRight) & (row >= boundaryMiddle)).*temp;

% Masks
mask.Top.Left = unravel(r11, n.gaborFilters);
mask.Top.Center = unravel(r12, n.gaborFilters);
mask.Top.Right = unravel(r13, n.gaborFilters);
mask.Bottom.Left = unravel(r21, n.gaborFilters);
mask.Bottom.Center = unravel(r22, n.gaborFilters);
mask.Bottom.Right = unravel(r23, n.gaborFilters);

% Tidy up
clear temp col row boundaryRight boundaryLeft boundaryMiddle
clear r11 r12 r13 r21 r22 r23