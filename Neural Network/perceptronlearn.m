function perceptronFinal =...
    perceptronlearn(trainData, trainTargets,... 
                    validateData, validateTargets,...
                    perceptronInitial, trainParameters)
%PERCEPTRONLEARN performs training and cross-validation of a
%   perceptron
%
% INPUTS
%   trainData = [dataVector1        - training data
%                dataVector2
%                   ...
%                dataVectorN]
%   trainTargets                    - training data target values
%   validateData = [dataVector1     - cross-validation data
%                   dataVector2
%                       ...
%                   dataVectorM]
%   validateTargets                 - cross-validation data 
%                                     target values
%   perceptronInitial               - perceptron initialization
%       fields:
%           nHiddenUnits            - number of Hidden units
%           weightsInput            - weights of connections
%                                     leaving the input layer
%           weightsHidden           - weights of connections
%                                     leaving the hidden layer
%           weights matrix format:
%               Number of rows    - Number of units in succeeding
%                                   layer
%               Number of columns - Number of units in preceding
%                                   layer (+1 for a bias unit)
%   trainParameters                 - parameters for training
%       fields:
%           mu                      - momentum
%           eta                     - initial learning rate
%           iter                    - number of passes over the
%                                     training set at a particular
%                                     learning rate
%           noise                   - factor multiplied by inputs
%                                     to units in layers after
%                                     the input layer to compute
%                                     the standard deviation of
%                                     zero mean Gaussian noise
%                                     that is added
%
% OUTPUT
%   perceptronFinal                 - perceptron at training
%                                     completion

    % Initialize a variable hold the number of elapsed 
    % training epochs (with a changing learning rate)
    nEpochs = 0;
    
    % Variables for cross-validation
    % Error initialization
    errorInitial = [];

    % Initialize indicator for when training should end
    % Stop is set to 1 when the error from validation
    % increases
    stop = 0;

    while (stop == 0)
        nEpochs = nEpochs + 1;

        % Training
        perceptronFinal =...
            perceptrontrain(trainData, trainTargets,...
                            perceptronInitial,...
                            trainParameters.mu,...
                            (trainParameters.eta/nEpochs),...
                            trainParameters.iter,...
                            trainParameters.noise);

        % Update perceptron
        perceptronInitial = perceptronFinal;
        
        % Cross-validation
        [errorFinal, stop] =...
            perceptronvalidate(validateData, validateTargets,...
                               perceptronFinal,...
                               errorInitial,...
                               trainParameters.noise);

        % Update Error
        errorInitial = errorFinal;
    end
end