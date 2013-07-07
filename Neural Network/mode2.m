function M = mode2(A, dimension)
%MODE2 finds the most frequent value in a one-dimensional array
%   or the most frequent values along the rows or columns of a
%   matrix. (The default is along the columns.) If multiple  most
%   frequent values occur, one is selected at random.
    switch nargin
        case 1
            [~, ~, C] = mode(double(A));        
        case 2
            [~, ~, C] = mode(double(A), dimension);
        otherwise
            disp('Error: 1 or 2 arguments accepted');

    end

    % Number of modes
    nModes = length(C);
    % Modes
    M = zeros(nModes, 1);

    for i=1:nModes
        M(i) = C{i}(randi(length(C{i})));
    end
end