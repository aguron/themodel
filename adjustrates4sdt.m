function adjustedRates = adjustrates4sdt(rates, nTrials)
%ADJUSTRATES4SDT adjusts rate values for signal detection theory
%   computations. (Please see 
%   http://kangleelab.com/signal%20detection%20theory.html)
%   
% INPUTS
%   rates       - array or matrix of rates
%   nTrials     - number of trials in an experiment run
%
% OUTPUTS
%   adjustedRates

    adjustedRates = rates - (rates == 1)*(1/(2*nTrials))...
                          + (rates == 0)*(1/(2*nTrials));
end