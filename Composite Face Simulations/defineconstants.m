% Number of facial expression types
n.expressions = 7;
% Number of facial expression subsets
n.subsets = 10;
% Number of composite faces from one subset
n.compositeFaces = n.expressions*(n.expressions-1);


% Number of Gabor filter orientations and frequencies
n.gaborOrientations = 8;
n.gaborFrequencies = 5;

% Number of Gabor filters
n.gaborFilters = n.gaborOrientations*n.gaborFrequencies;

% horizontal and vertical dimensions of grid of Gabor filter
% samples for each image
n.dimensionHorizontal = 36;
n.dimensionVertical = 30;

% Number of Gabor filter features
n.gaborFeatures = n.gaborFilters*n.dimensionHorizontal*n.dimensionVertical;

% Number of network instances for each model decision
n.perceptrons = n.subsets - 1;

% Number of experimental runs
n.repeats = 10;
n.runs = n.subsets*n.repeats;

% Principal Components Analysis
eigenvalueSumThreshold = 0.9;

% Values assigned to facial expressions
expression.happy = 1;
expression.sad = 2;
expression.surprised = 3;
expression.angry = 4;
expression.disgusted = 5;
expression.fearful = 6;
expression.neutral = 7;

% Indices for sorting facial expressions for the experiments
%
% Composite face stimuli (Please see APPLYGABORFILTERS2IMAGES)
expression.neutralHappy =...
    (expression.neutral-1)*(n.expressions-1) + expression.happy;
expression.angryHappy =...
    (expression.angry-1)*(n.expressions-1) + expression.happy;
expression.angryNeutral =...
    (expression.angry-1)*(n.expressions-1) + (expression.neutral-1);

% Ordering of stimuli for testing (Please see 
% PREPARETESTINGEXPERIMENTFEATURES):
%   attention on full noncomposite left-shifted (1 to 7)
%   attention on full noncomposite right-shifted (1 to 7)
%   attention on top noncomposite left-shifted (1 to 7)
%   attention on top noncomposite right-shifted (1 to 7)
%   attention on bottom noncomposite left-shifted (1 to 7)
%   attention on bottom noncomposite right-shifted (1 to 7)
order.testing.NC.LS = 0;
order.testing.NC.RS = 1;
order.testing.TH.LS = 2;
order.testing.TH.RS = 3;
order.testing.BH.LS = 4;
order.testing.BH.RS = 5;

% Ordering of half face stimuli for experiment 1 simulations
% (Please see PREPARETESTINGEXPERIMENTFEATURES)
%    top half left-shifted (1 to 7)
%    top half right-shifted (1 to 7)
%    bottom half left-shifted (1 to 7)
%    bottom half right-shifted (1 to 7)
order.experiment1.TH.LS = 0;
order.experiment1.TH.RS = 1; 
order.experiment1.BH.LS = 2;
order.experiment1.BH.RS = 3;

% Ordering of misaligned face stimuli for experiment 3 simulations
% (Please see PREPARETESTINGEXPERIMENTFEATURES)
%    attention on top top-left bottom-right (1 to 7)
%    attention on top top-right bottom-left (1 to 7)
%    attention on bottom top-right bottom-left (1 to 7)
%    attention on bottom top-left bottom-right (1 to 7)
order.experiment3.NC.TLBR_MA.top = 0;
order.experiment3.NC.TRBL_MA.top = 1;
order.experiment3.NC.TRBL_MA.bottom = 2;
order.experiment3.NC.TLBR_MA.bottom = 3;


% Stimuli categories for testing and stimulations
category.testing = expression.happy:expression.neutral;
category.CCP = expression.happy:expression.neutral;
category.experiment1 = [expression.happy expression.angry];
category.experiment3 = [expression.happy expression.angry];

% Number of stimuli in simulations
n.stimuliExperiment1 = 16;
n.stimuliExperiment3 = 16;


% Number of each Complete Composite Paradigm simulation trial
% type (top/bottom, aligned/misaligned)
%
% Total
n.T.all = n.compositeFaces*((n.compositeFaces-1)/2 + 1);
% Incongruent Same
% (cued half same between study and test stimuli)
n.IS.all = n.compositeFaces*(n.expressions-2)/2;
% Incongruent Different
% (cued half different between study and test stimuli)
n.ID.all = n.IS.all;
% Congruent Same
n.CS.all = n.compositeFaces;
% Congruent Different
n.CD.all = n.T.all - (n.CS.all + n.IS.all + n.ID.all);

% Number of selected trials
n.selectedTrials.all = n.compositeFaces;

% In simulations 2-3 (experiments by Tanaka et al.), a reaction
% time of 1 corresponds to an incorrect decision
wrong = 1;