function result =...
    reliabledifference(condition1, condition2, showResultsTable)
%RELIABLEDIFFERENCE tests for a reliable difference between
%   results for two conditions

    varnames = {'Stimulus'};
    data = [condition1; condition2];

    % Stimulus
    % 0 - condition1
    % 1 - condition2
    stimulus =  [zeros(length(condition1),1);
                 ones(length(condition2),1)];

    result = anovan(data,{stimulus},1,1,varnames);

    % Close table if the user specifies such
    if showResultsTable == 0
        close hidden
    end

end