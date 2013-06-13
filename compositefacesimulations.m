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
%
%   Information on

%% Include information on composite faces labels

save gaborFilters gaborFilters

            %%
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %        PRINCIPAL COMPONENTS ANALYSIS (PCA)        %
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            scale.train = 1; % normalization factor for training set
            GFF_train = zscore(GFF_train, scale.train);

            eigenvalueSumThreshold = 0.9;
            GFF_PC =...
                principalcomponentsanalysis(GFF_train,...
                                            eigenvalueSumThreshold);

            %%
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            % PROJECTION WITH PCA MATRIX (TRAINING) %
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            % '' - Normalize ONLY after projection
            X_train = projectonPC(GFF_train, GFF_PC, scale.train, '');

            % 'b' - Normalize before and after projection, and
            % according to the number of validation data vectors
            scale.validate = size(GFF_validate,1)/size(GFF_train,1);
            X_validate =...
                projectonPC(GFF_validate, GFF_PC, scale.validate, 'b');
            
            %%
            %%%%%%%%%%%%
            % TRAINING %
            %%%%%%%%%%%%
            trainingtargets
            
            % Initialize perceptron
            % (Supports perceptrons with up to one hidden layer
            %  at present)
            % Number of hidden layer units
            perceptronInitial.nHiddenUnits = 10;
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
            perceptronFinal{i_NetInst} =...
                perceptronlearn(X_train, Y_train,... 
                                X_validate, Y_validate,...
                                perceptronInitial,...
                                trainParameters);
            fprintf(1,'%s\n', 'End of training');


    %%%%%%%%%%%
    % TESTING %
    %%%%%%%%%%%
    testingtargets

    fprintf(1,'%s\n', 'Start of testing');
    Class.Test = perceptronclassify(X_test, Y_test,...
                                    perceptronFinal,...
                                    trainParameters.noise,...
                                    1:7, 'y');
    fprintf(1,'%s\n', 'End of testing');
    disp(' ');

    testingresults
    
    %%%%%%%%%%%%%%%
    % EXPERIMENTS %
    %%%%%%%%%%%%%%%
    experiments
   e
    
    