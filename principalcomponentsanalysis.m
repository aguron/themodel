function principalComponents =...
    principalcomponentsanalysis(dataSet, eigenvalueSumThreshold)
%PRINCIPALCOMPONENTSANALYSIS performs Principal Components Analysis
%
% INPUTS
%   dataSet = [dataVector1  - set from which principal components
%              dataVector2    are to be determined
%                   ...
%              dataVectorN]
%   eigenvalueSumThreshold  - minimum value of the sum of the
%                             eigenvalues of the principal 
%                             components
%
% OUTPUT
%   principalComponents     - principal components
%   = [PC1 PC2 ... PCL]

    % Use binary search to find all the eigenvalues (and 
    % eigenvectors) necessary to exceed the threshold
    %
    % Start off with 10 eigenvalues
    nEigenvalues = 10;
    [~,eigenvalues,~] = pc_evectors(dataSet',nEigenvalues);
    sumEigenvalues = cumsum(eigenvalues/sum(eigenvalues));

    startInterval = 1;
    endInterval = size(dataSet,1);

    while (startInterval ~= endInterval)
    nEigenvalues = floor((startInterval + endInterval)/2);                
        sumEv = sumEigenvalues(n.Eval);

        if (sumEv < eigenvalueSumThreshold)
            nEigenvalues = nEigenvalues + 1;
            startInterval = nEigenvalues;
        else
            endInterval = nEigenvalues;
        end
    end


    % Principal Components
    [principalComponents,~,~] = pc_evectors(dataSet', nEigenvalues);

end

