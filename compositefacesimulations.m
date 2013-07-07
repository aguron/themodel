% Script
%
% COMPOSITEFACESIMULATIONS
%   Terminology for face images:
%       -composite
%           images with faces composed of top and bottom halves
%           from DIFFERENT facial expressions (e.g. happy, sad, 
%           etc.) or belonging to different identities
%
%       -noncomposite
%           images with faces composed of top and bottom halves
%           from the SAME individual with the SAME facial
%           expression (e.g. happy, sad, etc.)
%
%       -left-shifted aligned
%           facial images of width 1.5 times the width of the
%           faces with the faces against the left edge
%
%       -right-shifted aligned
%           facial images of width 1.5 times the width of the
%           faces with the faces against the right edge
%
%       -top-left bottom-right misaligned
%           facial images of width 1.5 times the width of the
%           faces with the top half of the face against the left
%           and the lower half of the face against the right
%
%       -top-right bottom-left misaligned
%           facial images of width 1.5 times the width of the
%           faces with the top half of the face against the right
%           and the lower half of the face against the left
%
%       
%   Function of Script:
%       Performs the Complete Composite Paradigm experiment that
%       is well-described in:
%
%       Gauthier, I., & Bukach, C. (2007). Should we reject the 
%       expertise hypothesis? Cognition, 103, 322–330.
%
%       More specifically, performs simulations in which the
%       EMPATH neurocomputational model is used to make judgments
%       of similarity and disimilarity between face halves of
%       composite as well as noncomposite faces and then analyzes
%       the statistic interaction between these judgments for
%       aligned and misaligned faces.
%
%       The Gabor filter feature vectors of the following kinds
%       of images are used in the simulation:
%           1. noncomposite left-shifted aligned
%           2. noncomposite right-shifted aligned
%           3. composite left-shifted aligned
%           4. composite right-shifted aligned
%           5. noncomposite top-left bottom-right misaligned
%           6. noncomposite top-right bottom-left misaligned
%           7. composite top-left bottom-right misaligned
%           8. composite top-right bottom-left misaligned
%
%       Also performs Experiment 1 in:
%
%       Tanaka, J.W., Kaiser, M.D., Butler, S., & Le Grand, R.
%       (2011) Mixed emotions: Holistic and analytic perception
%       of facial expressions. Cognition & Emotion
%
%       Simulations in which the EMPATH neurocomputational model
%       is used to make judgments about whether bottom half faces
%       belong to the happy category in:
%           -happy top + happy bottom
%           -happy bottom
%           -neutral top + happy bottom
%           -angry top + happy bottom
%       faces, and whether top half faces belong to the sad
%       category in:
%           -angry top + angry bottom
%           -angry top
%           -angry top + neutral bottom
%           -angry top + happy bottom
%
%       The Gabor filter feature vectors of the following kinds
%       of images are used in the simulation:
%           1. noncomposite left-shifted aligned
%           2. noncomposite right-shifted aligned
%           3. composite left-shifted aligned
%           4. composite right-shifted aligned
%           5. noncomposite top-left bottom-right misaligned
%           6. noncomposite top-right bottom-left misaligned
%           7. composite top-left bottom-right misaligned
%           8. composite top-right bottom-left misaligned
%       as well as:
%           9.  top-half left-shifted
%           10. bottom-half left-shifted
%           11. top-half right-shifted
%           12. bottom-half right-shifted
%
%       And Experiment 3 in:
%
%       Tanaka, J.W., Kaiser, M.D., Butler, S., & Le Grand, R.
%       (2011) Mixed emotions: Holistic and analytic perception
%       of facial expressions. Cognition & Emotion


%%
%%%%%%%%%%%%%%%%%%%
% CLEAR WORKSPACE %
%%%%%%%%%%%%%%%%%%%
clear;

%%%%%%%%%%%%%%%%%%%%%%
% PROFILING COMMANDS %
%%%%%%%%%%%%%%%%%%%%%%
monitorTime = 0;
if (monitorTime == 1)
    profile clear
    profile on
end

%%
%%%%%%%%%%%%%%%%%%%%%%%%
% CONSTANTS AND ARRAYS %
%%%%%%%%%%%%%%%%%%%%%%%%
cd([pwd, '/Composite Face Simulations'])
defineconstants
initializearrays

%%
%%%%%%%%%%%%%%%%%
% GABOR FILTERS %
%%%%%%%%%%%%%%%%%
cd ..
cd([pwd, '/Gabor Filtering'])
% create
gaborFilters = gaborfilterset();
% save
save gaborFilters gaborFilters

%%%%%%%%%%%%%%%%%%
% GABOR FEATURES %
%%%%%%%%%%%%%%%%%%
% load set of Gabor filters if necessary
if (any(strcmp(who,'gaborFilters')) == 0)
    load('gaborFilters.mat', 'gaborFilters');
end
applygaborfilters2images % User needs to procure image dataset
loadgaborfeatures

% display Gabor filters
% gaborfiltersimage % imshow() does not work on server
% save imageGabors imageGabors

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PREPARE MASKS FOR SIMULATING ATTENTION %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cd ..
cd([pwd, '/Composite Face Simulations'])
attentionmasks

%%
%%%%%%%%%%%%%%%
% SIMULATIONS %
%%%%%%%%%%%%%%%
% Indexes
%   i_r - index of experimental run
%   i_t - index of image subset used for testing/experiments
%   i_c - index of image subset used for cross-validation
for i_r = 1:n.runs
    % Each image subset is used for testing N.REPEATS times
    i_s = kron((1:n.subsets),ones(1,n.repeats));
    i_t = i_s(i_r);

    % Current iteration on a particular subset
    i_i = mod(i_r - 1, n.repeats) + 1;
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % DISPLAY EXPERIMENT RUN NUMBER %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    disp(['Experiment Run ', num2str(i_r), ':']);

    %%%%%%%%%%%%%%%%%%%%%%%%
    % TRAINING PERCEPTRONS %
    %%%%%%%%%%%%%%%%%%%%%%%%
    % index for perceptrons
    i_p = 0;
    % array of perceptrons
    perceptronFinal = cell(n.perceptrons, 1);
    for i_c = 1:n.subsets
        % image subsets for testing/experiments and
        % cross-validation must differ
        if i_c ~= i_t
            %%
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            % DISPLAY PERCEPTRON NUMBER %
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            i_p = i_p + 1;  % next perceptron in the ensemble
            disp(['Perception ', num2str(i_p)]);
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            % GABOR FILTER FEATURES FOR TRAINING %
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            preparetrainingfeatures
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            % PRINCIPAL COMPONENTS ANALYSIS (PCA) %
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            cd ..
            cd([pwd, '/Principal Components Analysis'])
            % normalization factor for training set
            scale.training = 1;
            gaborFeatures.training =...
                centerandnormalize(gaborFeatures.training,...
                                   scale.training);
            principalComponents =...
                principalcomponentsanalysis(gaborFeatures.training,...
                                            eigenvalueSumThreshold);
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            % GABOR FILTER FEATURES FOR CROSS-VALIDATION %
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            cd ..
            cd([pwd, '/Composite Face Simulations'])
            preparevalidationfeatures
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            % PROJECTION ON PRINCIPAL COMPONENTS (TRAINING) %
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            cd ..
            cd([pwd, '/Principal Components Analysis'])
            % 'a' - Normalize ONLY after projection
            perceptronInput.training =...
                projectonbasis(gaborFeatures.training,...
                               principalComponents,...
                               scale.training,...
                               'a');

            % Adjust for the difference in size between the data
            % sets for training and cross-validation
            scale.validation =...
                size(gaborFeatures.validation,1)/...
                size(gaborFeatures.training,1);
            % 'b' - Normalize before and after projection, and
            % according to the number of validation data vectors            
            perceptronInput.validation =...
                projectonbasis(gaborFeatures.validation,...
                               principalComponents,...
                               scale.validation,...
                               'b');

            %%
            %%%%%%%%%%%%
            % TRAINING %
            %%%%%%%%%%%%
            cd ..
            cd([pwd, '/Composite Face Simulations'])
            trainingtargets
            
            cd ..
            cd([pwd, '/Neural Network'])
            % Initialize perceptron
            % (Supports perceptrons with up to one hidden layer
            %  at present)
            % Number of hidden layer units
            perceptronInitial.nHiddenUnits = 0;
            % Weights:
            %   These can be initialized (please see
            %   PERCEPTRONLEARN for details) or left
            %   uninitialized (as they have been here)
            % Weights of connections leaving input layer
            perceptronInitial.weightsInput = [];
            % Weights of connections leaving hidden layer
            perceptronInitial.weightsHidden = [];
            
            % Specify training parameters
            % Momentum
            trainParameters.mu = 0.5;
            % Initial learning rate
            trainParameters.eta = 0.15;
            % Number of passes over the training dataset (at a
            % particular learning rate)
            trainParameters.iter = 1;
            % Noise
            trainParameters.noise = sqrt(0);
            % (Please see PERCEPTRONLEARN for more details.)
            
            % Training proper
            fprintf(1,'%s\n', 'Start of training');
            perceptronFinal{i_p} =...
                perceptronlearn(perceptronInput.training,...
                                perceptronTarget.training,... 
                                perceptronInput.validation,...
                                perceptronTarget.validation,...
                                perceptronInitial,...
                                trainParameters);
            fprintf(1,'%s\n', 'End of training');
            disp(' ');
            
            %%
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            % GABOR FILTER FEATURES FOR TESTING AND SIMULATIONS %
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            cd ..
            cd([pwd, '/Composite Face Simulations'])
            preparetestingexperimentfeatures

            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            % PROJECTION ON PRINCIPAL COMPONENTS AND SORTING OF STIMULI %
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            projectandsortstimuli

        end
    end

    %%%%%%%%%%%
    % TESTING %
    %%%%%%%%%%%
    testingtargets

    cd ..
    cd([pwd, '/Neural Network'])

    fprintf(1,'%s\n', 'Start of testing');
    perceptronOutput.testing =...
        perceptronclassify(perceptronInput.testing,...
                           perceptronTarget.testing,...
                           perceptronFinal,...
                           trainParameters.noise,...
                           category.testing,...
                           'y');
    fprintf(1,'%s\n', 'End of testing');
    disp(' ');

    cd ..
    cd([pwd, '/Composite Face Simulations'])

    testingresults

    %%%%%%%%%%%%%%%
    % EXPERIMENTS %
    %%%%%%%%%%%%%%%
    
    cd ..
    cd([pwd, '/Composite Face Simulations'])

    experiments
    experimentsresults
end
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DATA ANALYSIS AND VISUALIZATION %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cd ..
cd([pwd, '/Data Analysis and Visualization'])

dataanalysis
% datavisualization % imshow() does not work on server

%%
%%%%%%%%%%%%%%%%%%%%%%
% PROFILING COMMANDS %
%%%%%%%%%%%%%%%%%%%%%%
if (monitorTime == 1)
    performance = profile('info');

    for i = 1:size({performance.FunctionTable.TotalTime},2)
        FunctionName = {performance.FunctionTable.FunctionName};
        TotalTime = {performance.FunctionTable.TotalTime};
        disp([FunctionName{i}, '   ', num2str(TotalTime{i})]);
    end
    clear i

    profile off
end

%%%%%%%%%%%%%%%%%%%%%%%%%
% SAVE DATA AND TIDY UP %
%%%%%%%%%%%%%%%%%%%%%%%%%
savedata

close all hidden
clear all
cd ..