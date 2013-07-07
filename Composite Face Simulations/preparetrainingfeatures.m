% Script
%
% PREPARETRAININGFEATURES
%   Notes:
%   06/22/2013
%     - generates Gabor filter feature vectors that correspond to
%       to full and half- face stimuli for training
%
%   Functions called:
%       generatepartitions
%       selectpartition
%       attention4stimulus
%
% Gabor features
temp.training.NC_LS_A =...
    zeros((n.subsets-2)*n.expressions, n.gaborFeatures);
temp.training.NC_RS_A =...
    zeros((n.subsets-2)*n.expressions, n.gaborFeatures);
j = 1;
for i=1:n.subsets
    if (i ~= i_t) && (i ~= i_c)
        % Compute the magnitude of Gabor filter features (model
        % of complex cell responses in primary visual cortex)
        %
        % left-shifted
        temp.training.NC_LS_A(n.expressions*(j-1)+1:...
                              n.expressions*j,:) = ...
         abs(NC_LS_A(n.expressions*(i-1)+1:n.expressions*i,:));
        % right-shifted
        temp.training.NC_RS_A(n.expressions*(j-1)+1:...
                              n.expressions*j,:) = ...
         abs(NC_RS_A(n.expressions*(i-1)+1:n.expressions*i,:));
        % next subset
        j = j + 1;
    end
end

% Use attention masks to compute means along each feature
% dimension
partition.NC_LS_A = generatepartitions(temp.training.NC_LS_A, mask);
partition.NC_RS_A = generatepartitions(temp.training.NC_RS_A, mask);
means.training =...
    mean([selectpartition(partition.NC_LS_A, [1 2], [1 2]);
          selectpartition(partition.NC_RS_A, [1 2], [2 3]);
          selectpartition(partition.NC_LS_A, [1 1], [1 2]);
          selectpartition(partition.NC_RS_A, [1 1], [2 3]);
          selectpartition(partition.NC_LS_A, [2 2], [1 2]);
          selectpartition(partition.NC_RS_A, [2 2], [2 3])]);


% Degrees of attention
% Maximum: 1
% Minimum: 0

attention.background = 0.01;

attention.learned = 1;
attention.notLearned = 0.10;

%%%%%%%%%%%%%%%%
% 1 % 1 % 0.01 %
%%%%%%%%%%%%%%%%
% 1 % 1 % 0.01 %
%%%%%%%%%%%%%%%%
attention.NC.A.full.LS =...
    [attention.learned attention.learned attention.background;
     attention.learned attention.learned attention.background];
 
%%%%%%%%%%%%%%%%
% 0.01 % 1 % 1 %
%%%%%%%%%%%%%%%%
% 0.01 % 1 % 1 %
%%%%%%%%%%%%%%%%
attention.NC.A.full.RS =...
    [attention.background attention.learned attention.learned;
     attention.background attention.learned attention.learned];

%%%%%%%%%%%%%%%%%%%%%%
% 1    % 1    % 0.01 %
%%%%%%%%%%%%%%%%%%%%%%
% 0.10 % 0.10 % 0.01 %
%%%%%%%%%%%%%%%%%%%%%%
attention.NC.A.top.LS =...
    [attention.learned    attention.learned    attention.background;
     attention.notLearned attention.notLearned attention.background];

%%%%%%%%%%%%%%%%%%%%%%
% 0.01 % 1    % 1    %
%%%%%%%%%%%%%%%%%%%%%%
% 0.01 % 0.10 % 0.10 %
%%%%%%%%%%%%%%%%%%%%%%
attention.NC.A.top.RS =...
    [attention.background attention.learned    attention.learned;
     attention.background attention.notLearned attention.notLearned];

%%%%%%%%%%%%%%%%%%%%%%
% 0.10 % 0.10 % 0.01 %
%%%%%%%%%%%%%%%%%%%%%%
% 1    % 1    % 0.01 %
%%%%%%%%%%%%%%%%%%%%%%
attention.NC.A.bottom.LS =...
    [attention.notLearned attention.notLearned attention.background;
     attention.learned    attention.learned    attention.background];

%%%%%%%%%%%%%%%%%%%%%%
% 0.01 % 0.10 % 0.10 %
%%%%%%%%%%%%%%%%%%%%%%
% 0.01 % 1    % 1    %
%%%%%%%%%%%%%%%%%%%%%%
attention.NC.A.bottom.RS =...
    [attention.background attention.notLearned attention.notLearned;
     attention.background attention.learned    attention.learned];

gaborFeatures.training =...
[attention4stimulus(partition.NC_LS_A,...
                    attention.NC.A.full.LS,...
                    means.training);
 attention4stimulus(partition.NC_RS_A,...
                    attention.NC.A.full.RS,...
                    means.training);
 attention4stimulus(partition.NC_LS_A,...
                    attention.NC.A.top.LS,...
                    means.training);
 attention4stimulus(partition.NC_RS_A,...
                    attention.NC.A.top.RS,...
                    means.training);
 attention4stimulus(partition.NC_LS_A,...
                    attention.NC.A.bottom.LS,...
                    means.training);
 attention4stimulus(partition.NC_RS_A,...
                    attention.NC.A.bottom.RS,...
                    means.training)];

% Tidy up
clear temp i j partition means