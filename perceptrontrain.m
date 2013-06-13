function perceptronFinal =...
    perceptrontrain(trainData, trainTargets,...
                    perceptronInitial,...
                    mu, eta, iter, noise)
%PERCEPTRONTRAIN performs training of a perceptron
% N.B. Implementation can be generalized to handle perceptrons
%      with more than one hidden layer
%
% INPUTS
%   trainData = [dataVector1        - training data
%                dataVector2
%                   ...
%                dataVectorN]
%   trainTargets                    - training data target values
%   perceptronInitial               - perceptron initialization
%       fields:
%           nHiddenUnits            - number of Hidden units
%           weightsInput            - weights of connections
%                                     leaving the input layer
%           weightsHidden           - weights of connections
%                                     leaving the hidden layer
%           Weights matrix format:
%               Number of rows    - Number of units in succeeding
%                                   layer
%               Number of columns - Number of units in preceding
%                                   layer (+1 for a bias unit)
%   mu                              - momentum
%   eta                             - learning rate
%   iter                            - number of passes over the 
%                                     training set at a particular
%                                     learning rate
%   noise                           - factor multiplied by inputs
%                                     to units in layers after the
%                                     input layer to compute the 
%                                     standard deviation of zero
%                                     mean Gaussian noise that is
%                                     added
%
% OUTPUT
%   perceptronFinal                 - perceptron at training
%                                     completion

    % Number of output classes
    nClass = length(unique(trainTargets));
    % Number of data vectors
    nData = size(trainData, 1);
    % Number of feature dimensions (excluding the bias unit)
    nFeatures = size(trainData, 2);

    % If there are no hidden layers, the single-layer perceptron
    % implementation is executed.
    if ~(perceptronInitial.nHiddenUnits > 0)
        % Unless a matrix of connection weights from the input layer
        % is passed as an argument to this function, initialize
        % perceptronInitial.WeightsInput using a spherically
        % symmetric Gaussian with mean 0 and sigma^2 = (1/(nFeature+1))
        if size(perceptronInitial.weightsInput, 1) == 0
            perceptronInitial.weightsInput =...
                mvnrnd(zeros(nClass,(nFeatures+1)),...
                       (1/(nFeatures+1))*eye(nFeatures+1));
        end

        % Initialize matrix to store the previous weight changes
        % for use in the momentum term in the gradient descent
        % algorithm
        delta.weightsInput = zeros(size(perceptronInitial.weightsInput));
        
        % Stochastic Gradient Descent with Momentum
        for tau=1:iter
            % Scan the training patterns in a random order.
            % (p. 243 Introduction to Machine Learning. 
            % Second Edition. Ethem Alpaydin)
            r = randperm(nData);
            for n=r
                % Prepare the target vector for the class of the
                % current input vector using a 1-of-nClass coding 
                % scheme
                t_n = zeros(nClass, 1);
                t_n(trainTargets(n)) = 1;

                % Calculate the sum of the inputs to each of the
                % output units
                a_n = perceptronInitial.weightsInput(:,1);
                a_n = a_n +...
                    perceptronInitial.weightsInput(:,2:(nFeatures+1))*...
                    trainData(n,:)';

                % Add noise to the inputs to the output units
                if (noise > 0)
                    a_n = a_n +...
                        mvnrnd(zeros(1,nClass),...
                               diag((noise*a_n).^2))';
                end

                % Calculate the outputs from each of the output 
                % units using softmax activation functions
                y_n = exp(a_n)/sum(exp(a_n));

                % Calculate the weight changes
                delta.weightsInput =...
                    -(eta/tau)*(y_n - t_n)*[1 trainData(n,:)] +...
                             mu*delta.weightsInput;

                % Update the matrix of weights
                perceptronInitial.weightsInput =...
                    perceptronInitial.weightsInput + delta.weightsInput;
            end
        end

        perceptronFinal.nHiddenUnits = perceptronInitial.nHiddenUnits;
        perceptronFinal.weightsInput = perceptronInitial.weightsInput;

    % If there is a single layer of hidden units, the double-layer
    % perceptron implementation is executed.
    elseif (perceptronInitial.nHiddenUnits > 0)
        % Number of hidden units (excluding the bias unit)
        nHiddenUnits = perceptronInitial.nHiddenUnits;

        % Unless a matrix of connection weights from the input layer
        % is passed as an argument to this function, initialize
        % perceptronInitial.weightsInput using a spherically
        % symmetric Gaussian with mean 0 and sigma^2 = (1/(nFeature+1))
        if size(perceptronInitial.weightsInput, 1) == 0
            perceptronInitial.weightsInput =...
                mvnrnd(zeros(nHiddenUnits,(nFeatures+1)),...
                       (1/(nFeatures+1))*eye(nFeatures+1));
        end

        % Unless a matrix of connection weights from the hidden layer
        % is passed as an argument to this function, initialize
        % perceptronInitial.weightsHidden using a spherically
        % symmetric Gaussian with mean 0 and sigma^2 = (1/(nHiddenUnits+1))
        if size(perceptronInitial.weightsHidden, 1) == 0
            perceptronInitial.weightsHidden =...
                mvnrnd(zeros(nClass,(nHiddenUnits+1)),...
                       (1/(nHiddenUnits+1))*eye(nHiddenUnits+1));
        end
        
        % Initialize matrices to store the previous weight changes
        % for use in the momentum term in gradient descent
        delta.weightsInput =...
            zeros(size(perceptronInitial.weightsInput));
        delta.weightsHidden =...
            zeros(size(perceptronInitial.weightsHidden));
        
        % Stochastic Gradient Descent with Momentum
        for tau=1:iter
            % Scan the training patterns in a random order.
            % (p. 251 Introduction to Machine Learning. Second Edition.
            %  Ethem Alpaydin.)
            r = randperm(nData);
            for n=r
               % Prepare the target vector for the class of the current
               % input vector using a 1-of-nClass coding scheme
               t_n = zeros(nClass, 1);
               t_n(Y_train(n)) = 1;

               % From the Algorithm on p. 255 Introduction to
               % Machine Learning. Second Edition. Ethem Alpaydin.

               % Calculate the sum of the inputs to each of the
               % hidden units
               a_n = perceptronInitial.weightsInput(:,1);
               a_n = a_n +...
                   perceptronInitial.weightsInput(:,2:(nFeatures+1))*...
                   trainData(n,:)';

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
               b_n = perceptronInitial.weightsHidden(:,1);
               b_n = b_n +...
                 perceptronInitial.weightsHidden(:,2:(nHiddenUnits+1))*y_n;

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

               % Calculate the weight changes
               % Change for the first layer of the perceptron:
               delta.weightsInput = -(eta/tau)*...
                             ((z_n-t_n)'*...
                              perceptronInitial.weightsHidden(:,...
                                                 2:(nHiddenUnits+1)))'.*...
                             y_n.*(1-y_n)*[1 trainData(n,:)] +...
                             mu*delta.weightsInput;
               
               % Change for the second layer of the perceptron:
               delta.weightsHidden = -(eta/tau)*(z_n - t_n)*[1 y_n'] +...
                                     mu*delta.weightsHidden;

               % Update the weights
               perceptronInitial.weightsInput =...
                   perceptronInitial.weightsInput + delta.weightsInput;
               perceptronInitial.weightsHidden =...
                   perceptronInitial.weightsHidden + delta.weightsHidden;
            end
        end

        perceptronFinal = perceptronInitial;
    end
end