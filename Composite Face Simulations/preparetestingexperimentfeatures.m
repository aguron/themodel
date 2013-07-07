% Script
%
% PREPARETESTINGEXPERIMENTFEATURES
%   Notes:
%   06/24/2013
%     - generates Gabor filter feature vectors that correspond to
%       to full, half, and misaligned face stimuli for testing
%       and the experiments
%
%   Functions called:
%       generatepartitions
%       selectpartition
%       attention4stimulus
%
% Full face images for testing:
temp.testing.NC_LS_A =...
    abs(NC_LS_A(n.expressions*(i_t-1)+1:n.expressions*i_t,:));
temp.testing.NC_RS_A =...
    abs(NC_RS_A(n.expressions*(i_t-1)+1:n.expressions*i_t,:));

% Half-face Stimuli for Experiment 1
temp.TH_LS =...
    abs(TH_LS(n.expressions*(i_t-1)+1:n.expressions*i_t,:));
temp.TH_RS =...
    abs(TH_RS(n.expressions*(i_t-1)+1:n.expressions*i_t,:));
temp.BH_LS =...
    abs(BH_LS(n.expressions*(i_t-1)+1:n.expressions*i_t,:));
temp.BH_RS =...
    abs(BH_RS(n.expressions*(i_t-1)+1:n.expressions*i_t,:));

% Misaligned Noncomposite Stimuli for Experiment 3
temp.NC_TLBR_MA =...
    abs(NC_TLBR_MA(n.expressions*(i_t-1)+1:n.expressions*i_t,:));
temp.NC_TRBL_MA =...
    abs(NC_TRBL_MA(n.expressions*(i_t-1)+1:n.expressions*i_t,:));

% Stimuli for Complete Composite Paradigm
%
% The composite face stimuli are generated from the image data of
% the facial actor used for testing
%
% left-shifted aligned
temp.C_LS_A =...
    abs(C_LS_A((1+(n.compositeFaces*(i_t-1))):n.compositeFaces*i_t,:));

% right-shifted aligned
temp.C_RS_A =...
    abs(C_RS_A((1+(n.compositeFaces*(i_t-1))):n.compositeFaces*i_t,:));

% top-left bottom-right misaligned
temp.C_TLBR_MA =...
    abs(C_TLBR_MA((1+(n.compositeFaces*(i_t-1))):n.compositeFaces*i_t,:));

% top-right bottom-left misaligned
temp.C_TRBL_MA =...
    abs(C_TRBL_MA((1+(n.compositeFaces*(i_t-1))):n.compositeFaces*i_t,:));


% Use attention masks to compute means along each feature
% dimension
partition.NC_LS_A = generatepartitions(temp.testing.NC_LS_A, mask);
partition.NC_RS_A = generatepartitions(temp.testing.NC_RS_A, mask);

partition.TH.LS = generatepartitions(temp.TH_LS, mask);
partition.TH.RS = generatepartitions(temp.TH_RS, mask);
partition.BH.LS = generatepartitions(temp.BH_LS, mask);
partition.BH.RS = generatepartitions(temp.BH_RS, mask);

partition.NC_TLBR_MA = generatepartitions(temp.NC_TLBR_MA, mask);
partition.NC_TRBL_MA = generatepartitions(temp.NC_TRBL_MA, mask);

partition.C_LS_A = generatepartitions(temp.C_LS_A, mask);
partition.C_RS_A = generatepartitions(temp.C_RS_A, mask);
partition.C_TLBR_MA = generatepartitions(temp.C_TLBR_MA, mask);
partition.C_TRBL_MA = generatepartitions(temp.C_TRBL_MA, mask);


% Compute means along each dimension
means.testingExperiments =...
    mean([selectpartition(partition.NC_LS_A, [1 2], [1 2]);
          selectpartition(partition.NC_RS_A, [1 2], [2 3]);
          selectpartition(partition.NC_LS_A, [1 1], [1 2]);
          selectpartition(partition.NC_RS_A, [1 1], [2 3]);
          selectpartition(partition.NC_LS_A, [2 2], [1 2]);
          selectpartition(partition.NC_RS_A, [2 2], [2 3]);
          selectpartition(partition.TH.LS, [1 1], [1 2]);
          selectpartition(partition.TH.RS, [1 1], [2 3]);
          selectpartition(partition.BH.LS, [2 2], [1 2]);
          selectpartition(partition.BH.RS, [2 2], [2 3]);
          selectpartition(partition.NC_TLBR_MA, [1 1], [1 2]);
          selectpartition(partition.NC_TRBL_MA, [1 1], [2 3]);
          selectpartition(partition.NC_TRBL_MA, [2 2], [1 2]);
          selectpartition(partition.NC_TLBR_MA, [2 2], [2 3]);
          selectpartition(partition.C_LS_A, [1 1], [1 2]);
          selectpartition(partition.C_LS_A, [2 2], [1 2]);
          selectpartition(partition.C_RS_A, [1 1], [2 3]);
          selectpartition(partition.C_RS_A, [2 2], [2 3]);
          selectpartition(partition.C_TLBR_MA, [1 1], [1 2]);
          selectpartition(partition.C_TLBR_MA, [2 2], [2 3]);
          selectpartition(partition.C_TRBL_MA, [1 1], [2 3]);
          selectpartition(partition.C_TRBL_MA, [2 2], [1 2])]);


% Degrees of attention
% Maximum: 1
% Minimum: 0

attention.inFocus = 1;
attention.nearFocus = 0.50;
attention.outFocus = 0.10;

attention.background = 0.01;

%%%%%%%%%%%%%%%%
% 1 % 1 % 0.01 %
%%%%%%%%%%%%%%%%
% 1 % 1 % 0.01 %
%%%%%%%%%%%%%%%%
attention.NC.A.full.LS =...
    [attention.inFocus attention.inFocus attention.background;
     attention.inFocus attention.inFocus attention.background];

%%%%%%%%%%%%%%%%
% 0.01 % 1 % 1 %
%%%%%%%%%%%%%%%%
% 0.01 % 1 % 1 %
%%%%%%%%%%%%%%%%
attention.NC.A.full.RS =...
    [attention.background attention.inFocus attention.inFocus;
     attention.background attention.inFocus attention.inFocus];

%%%%%%%%%%%%%%%%%%%%%%
% 1    % 1    % 0.01 %
%%%%%%%%%%%%%%%%%%%%%%
% 0.50 % 0.50 % 0.01 %
%%%%%%%%%%%%%%%%%%%%%%
attention.NC.A.top.LS =...
    [attention.inFocus   attention.inFocus   attention.background;
     attention.nearFocus attention.nearFocus attention.background];

%%%%%%%%%%%%%%%%%%%%%%
% 0.01 % 1    % 1    %
%%%%%%%%%%%%%%%%%%%%%%
% 0.01 % 0.50 % 0.50 %
%%%%%%%%%%%%%%%%%%%%%%
attention.NC.A.top.RS =...
    [attention.background attention.inFocus   attention.inFocus;
     attention.background attention.nearFocus attention.nearFocus];

%%%%%%%%%%%%%%%%%%%%%%
% 0.50 % 0.50 % 0.01 %
%%%%%%%%%%%%%%%%%%%%%%
% 1    % 1    % 0.01 %
%%%%%%%%%%%%%%%%%%%%%%
attention.NC.A.bottom.LS =...
    [attention.nearFocus attention.nearFocus attention.background;
     attention.inFocus   attention.inFocus   attention.background];

%%%%%%%%%%%%%%%%%%%%%%
% 0.01 % 0.50 % 0.50 %
%%%%%%%%%%%%%%%%%%%%%%
% 0.01 % 1    % 1    %
%%%%%%%%%%%%%%%%%%%%%%
attention.NC.A.bottom.RS =...
    [attention.background attention.nearFocus attention.nearFocus;
     attention.background attention.inFocus   attention.inFocus];


temp.testing.NC_A =...
[attention4stimulus(partition.NC_LS_A,...
                    attention.NC.A.full.LS,...
                    means.testingExperiments);
 attention4stimulus(partition.NC_RS_A,...
                    attention.NC.A.full.RS,...
                    means.testingExperiments);
 attention4stimulus(partition.NC_LS_A,...
                    attention.NC.A.top.LS,...
                    means.testingExperiments);
 attention4stimulus(partition.NC_RS_A,...
                    attention.NC.A.top.RS,...
                    means.testingExperiments);
 attention4stimulus(partition.NC_LS_A,...
                    attention.NC.A.bottom.LS,...
                    means.testingExperiments);
 attention4stimulus(partition.NC_RS_A,...
                    attention.NC.A.bottom.RS,...
                    means.testingExperiments)];


%%%%%%%%%%%%%%%%%%%%%%
% 1    % 1    % 0.01 %
%%%%%%%%%%%%%%%%%%%%%%
% 0.01 % 0.01 % 0.01 %
%%%%%%%%%%%%%%%%%%%%%%
attention.TH.LS =...
    [attention.inFocus    attention.inFocus    attention.background;
     attention.background attention.background attention.background];

%%%%%%%%%%%%%%%%%%%%%%
% 0.01 % 1    % 1    %
%%%%%%%%%%%%%%%%%%%%%%
% 0.01 % 0.01 % 0.01 %
%%%%%%%%%%%%%%%%%%%%%%
attention.TH.RS =...
    [attention.background attention.inFocus    attention.inFocus;
     attention.background attention.background attention.background];

%%%%%%%%%%%%%%%%%%%%%%
% 0.01 % 0.01 % 0.01 %
%%%%%%%%%%%%%%%%%%%%%%
% 1    % 1    % 0.01 %
%%%%%%%%%%%%%%%%%%%%%%
attention.BH.LS =...
    [attention.background attention.background attention.background;
     attention.inFocus    attention.inFocus    attention.background];

%%%%%%%%%%%%%%%%%%%%%%
% 0.01 % 0.01 % 0.01 %
%%%%%%%%%%%%%%%%%%%%%%
% 0.01 % 1    % 1    %
%%%%%%%%%%%%%%%%%%%%%%
attention.BH.RS =...
    [attention.background attention.background attention.background;
     attention.background attention.inFocus    attention.inFocus];

temp.experiment1 =...
   [attention4stimulus(partition.TH.LS,...
                       attention.TH.LS,...
                       means.testingExperiments);
    attention4stimulus(partition.TH.RS,...
                       attention.TH.RS,...
                       means.testingExperiments);
    attention4stimulus(partition.BH.LS,...
                       attention.BH.LS,...
                       means.testingExperiments);
    attention4stimulus(partition.BH.RS,...
                       attention.BH.RS,...
                       means.testingExperiments)];


%%%%%%%%%%%%%%%%%%%%%%%
% 1    % 1     % 0.01 %
%%%%%%%%%%%%%%%%%%%%%%%
% 0.01 % 0.50  % 0.10 %
%%%%%%%%%%%%%%%%%%%%%%%
attention.NC.TLBR.MA.top =...
    [attention.inFocus    attention.inFocus   attention.background;
     attention.background attention.nearFocus attention.outFocus];

%%%%%%%%%%%%%%%%%%%%%%
% 0.01 % 1    % 1    %
%%%%%%%%%%%%%%%%%%%%%%
% 0.10 % 0.50 % 0.01 %
%%%%%%%%%%%%%%%%%%%%%%
attention.NC.TRBL.MA.top =...
    [attention.background attention.inFocus   attention.inFocus;
     attention.outFocus   attention.nearFocus attention.background];

%%%%%%%%%%%%%%%%%%%%%%
% 0.01 % 0.50 % 0.10 %
%%%%%%%%%%%%%%%%%%%%%%
% 1    % 1   % 0.01  %
%%%%%%%%%%%%%%%%%%%%%%
attention.NC.TRBL.MA.bottom =...
    [attention.background attention.nearFocus attention.outFocus;
     attention.inFocus    attention.inFocus   attention.background];

%%%%%%%%%%%%%%%%%%%%%%
% 0.10 % 0.50 % 0.01 %
%%%%%%%%%%%%%%%%%%%%%%
% 0.01 % 1    % 1    %
%%%%%%%%%%%%%%%%%%%%%%
attention.NC.TLBR.MA.bottom =...
    [attention.outFocus   attention.nearFocus attention.background;
     attention.background attention.inFocus   attention.inFocus];

temp.experiment3 =...
   [attention4stimulus(partition.NC_TLBR_MA,...
                       attention.NC.TLBR.MA.top,...
                       means.testingExperiments);
    attention4stimulus(partition.NC_TRBL_MA,...
                       attention.NC.TRBL.MA.top,...
                       means.testingExperiments);
    attention4stimulus(partition.NC_TRBL_MA,...
                       attention.NC.TRBL.MA.bottom,...
                       means.testingExperiments);
    attention4stimulus(partition.NC_TLBR_MA,...
                       attention.NC.TLBR.MA.bottom,...
                       means.testingExperiments)];


%%%%%%%%%%%%%%%%%%%%%%
% 1    % 1    % 0.01 %
%%%%%%%%%%%%%%%%%%%%%%
% 0.50 % 0.50 % 0.01 %
%%%%%%%%%%%%%%%%%%%%%%
attention.C.A.LS.top =...
    [attention.inFocus   attention.inFocus   attention.background;
     attention.nearFocus attention.nearFocus attention.background];

%%%%%%%%%%%%%%%%%%%%%%
% 0.50 % 0.50 % 0.01 %
%%%%%%%%%%%%%%%%%%%%%%
% 1    % 1    % 0.01 %
%%%%%%%%%%%%%%%%%%%%%%
attention.C.A.LS.bottom =...
    [attention.nearFocus attention.nearFocus attention.background;
     attention.inFocus   attention.inFocus   attention.background];

%%%%%%%%%%%%%%%%%%%%%%
% 0.01 % 1    % 1    %
%%%%%%%%%%%%%%%%%%%%%%
% 0.01 % 0.50 % 0.50 %
%%%%%%%%%%%%%%%%%%%%%%
attention.C.A.RS.top =...
    [attention.background attention.inFocus   attention.inFocus;
     attention.background attention.nearFocus attention.nearFocus];

%%%%%%%%%%%%%%%%%%%%%%
% 0.01 % 0.50 % 0.50 %
%%%%%%%%%%%%%%%%%%%%%%
% 0.01 % 1    % 1    %
%%%%%%%%%%%%%%%%%%%%%%
attention.C.A.RS.bottom =...
    [attention.background attention.nearFocus attention.nearFocus;
     attention.background attention.inFocus   attention.inFocus];

%%%%%%%%%%%%%%%%%%%%%%
% 1    % 1    % 0.01 %
%%%%%%%%%%%%%%%%%%%%%%
% 0.01 % 0.50 % 0.10 %
%%%%%%%%%%%%%%%%%%%%%%
attention.C.MA.TLBR.top =...
    [attention.inFocus    attention.inFocus   attention.background;
     attention.background attention.nearFocus attention.outFocus];

%%%%%%%%%%%%%%%%%%%%%%
% 0.10 % 0.50 % 0.01 %
%%%%%%%%%%%%%%%%%%%%%%
% 0.01 % 1    % 1    %
%%%%%%%%%%%%%%%%%%%%%%
attention.C.MA.TLBR.bottom =...
    [attention.outFocus   attention.nearFocus attention.background;
     attention.background attention.inFocus   attention.inFocus];

%%%%%%%%%%%%%%%%%%%%%%
% 0.01 % 1    % 1    %
%%%%%%%%%%%%%%%%%%%%%%
% 0.10 % 0.50 % 0.01 %
%%%%%%%%%%%%%%%%%%%%%%
attention.C.MA.TRBL.top =...
    [attention.background attention.inFocus   attention.inFocus;
     attention.outFocus   attention.nearFocus attention.background];

%%%%%%%%%%%%%%%%%%%%%%
% 0.01 % 0.50 % 0.10 %
%%%%%%%%%%%%%%%%%%%%%%
% 1    % 1    % 0.01 %
%%%%%%%%%%%%%%%%%%%%%%
attention.C.MA.TRBL.bottom =...
    [attention.background attention.nearFocus attention.outFocus;
     attention.inFocus    attention.inFocus   attention.background];


temp.top_LS_A = attention4stimulus(partition.C_LS_A,...
                                   attention.C.A.LS.top,...
                                   means.testingExperiments);
temp.bottom_LS_A = attention4stimulus(partition.C_LS_A,...
                                      attention.C.A.LS.bottom,...
                                      means.testingExperiments);
temp.top_RS_A = attention4stimulus(partition.C_RS_A,...
                                   attention.C.A.RS.top,...
                                   means.testingExperiments);
temp.bottom_RS_A = attention4stimulus(partition.C_RS_A,...
                                      attention.C.A.RS.bottom,...
                                      means.testingExperiments);
temp.top_TLBR_MA = attention4stimulus(partition.C_TLBR_MA,...
                                      attention.C.MA.TLBR.top,...
                                      means.testingExperiments);
temp.bottom_TLBR_MA = attention4stimulus(partition.C_TLBR_MA,...
                                         attention.C.MA.TLBR.bottom,...
                                         means.testingExperiments);
temp.top_TRBL_MA = attention4stimulus(partition.C_TRBL_MA,...
                                      attention.C.MA.TRBL.top,...
                                      means.testingExperiments);
temp.bottom_TRBL_MA = attention4stimulus(partition.C_TRBL_MA,...
                                         attention.C.MA.TRBL.bottom,...
                                         means.testingExperiments);
% Tidy up                     
clear partition means attention