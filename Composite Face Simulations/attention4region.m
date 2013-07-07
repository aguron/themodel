function attendedregion =...
    attention4region(region, attention, means)
%ATTENTION4REGION shifts feature values closer to the mean
%   (along each feature dimension) according to how much a
%   feature of a stimulus is NOT attended to. Thereby the
%   contribution of stimulus features to the variance along each
%   dimension is reduced. Since Principal Component Analysis
%   selects the directions of maximal variance in data, features
%   are attenuated accordingly.
%
% INPUT
%   region      - region to be attended to
%   attention   - attention factor
%   means       - row vector of means along each feature dimension

% OUTPUT
%   attendedregion

    attendedregion =...
        attention*region +...
        (1 - attention)*scalecolumns(region > 0, means);
end