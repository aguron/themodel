function [errorFinal, stop] =...
            perceptronvalidate(validateData, validateTargets,...
                               perceptron, errorInitial, noise)
%PERCEPTRONTRAIN performs cross-validation of a perceptron
% N.B. Implementation can be generalized to handle perceptrons
%      with more than one hidden layer
%
% INPUTS
%   validateData = [dataVector1     - cross-validation data
%                   dataVector2
%                       ...
%                   dataVectorM]
%   validateTargets                 - cross-validation data 
%                                     target values
%   perceptron                      - perceptron initialization
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

%   errorInitial                    - initial total error
%   noise                           - factor multiplied by inputs
%                                     to units in layers after the
%                                     input layer to compute the 
%                                     standard deviation of zero
%                                     mean Gaussian noise that is
%                                     added
%
% OUTPUTS
%   errorFinal                      - final total error
%   stop                            - indicator for increase in
%                                     total error

    % Number of output classes
    nClass = length(unique(validateTargets));
    % Number of data vectors
    nData = size(validateData, 1);
    % Number of feature dimensions (excluding the bias unit)
    nFeatures = size(validateData, 2);


    % Variables for cross-validation
    % error
    errorFinal = 0;
    % STOP is set to 1 if the error increases
    stop = 0;

    % If there are no hidden layers, the single-layer perceptron
    % implementation is executed.
    if ~(perceptron.nHiddenUnits > 0)
        for n=1:nData
            % Calculate the sum of the inputs to each of the
            % output units
            a_n = perceptron.weightsInput(:,1);
            a_n = a_n + perceptron.weightsInput(:,2:(nFeatures+1))*...
                        validateData(n,:)';

            % Add noise to the inputs to the output units
            if (noise > 0)
                a_n = a_n +...
                    mvnrnd(zeros(1,nClass),...
                           diag((noise*a_n).^2))';
            end

            % Calculate the outputs from each of the output 
            % units using softmax activation functions
            y_n = exp(a_n)/sum(exp(a_n));

            % Prepare the target vector for the class of the
            % current input vector using a 1-of-C coding scheme
            t_n = zeros(nClass, 1);
            t_n(validateTargets(n)) = 1;

            % Calculate the contribution to the total error
            errorFinal = errorFinal - t_n'*log(y_n);
        end
    elseif (perceptron.nHiddenUnits > 0)
        for n=1:nData
            % Number of hidden units (excluding the bias unit)
            nHiddenUnits = perceptron.nHiddenUnits;

            % Calculate the sum of the inputs to each of the
            % hidden units
            a_n = perceptron.weightsInput(:,1);
            a_n = a_n + perceptron.weightsInput(:,2:(nFeatures+1))*...
                        validateData(n,:)';

            % Add noise to the inputs to the hidden units
            if (noise > 0)
               a_n = a_n +...
                   mvnrnd(zeros(1,nHiddenUnits),...
                          diag((noise*a_n).^2))';
            end

            % Calculate the outputs from each of the hidden 
            % units using sigmoid activation functions
            % y_n = sigmoid(a_n)
            y_n = 1./(1 + exp(-a_n));

            % Calculate the sum of the inputs from the hidden
            % layer to each of the output units
            b_n = perceptron.weightsHidden(:,1);
            b_n = b_n +...
                perceptron.weightsHidden(:,2:(nHiddenUnits+1))*y_n;

            % Add noise to the inputs to the output units
            if (noise > 0)
               b_n = b_n +...
                   mvnrnd(zeros(1,nClass),...
                          diag((noise*b_n).^2))';
            end
            
            % Calculate the outputs from each of the output
            % units using softmax activation functions.
            % z_n = softmax(b_n)
            z_n = exp(b_n)/sum(exp(b_n));

            % Prepare the target vector for the class of the
            % current input vector using a 1-of-C coding scheme
            t_n = zeros(nClass, 1);
            t_n(validateTargets(n)) = 1;

            % Calculate the contribution to the total error
            errorFinal = errorFinal - t_n'*log(z_n);
        end
    end

    % stopping criterion hack
    if ~isempty(errorInitial)
        if errorFinal >= (errorInitial - 10^-4)
            stop = 1;
        end
    end
end