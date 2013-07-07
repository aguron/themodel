% The size of the testing stimuli set is a multiple of 7, and it
% has the following motif of values (which have been assigned to
% expressions in DEFINECONSTANTS):
%   1 (Happy)
%   2 (Sad)
%   3 (Surprised)
%   4 (Angry)
%   5 (Disgusted)
%   6 (Fearful)
%   7 (Neutral)

% For testing:
perceptronTarget.testing =...
    zeros(size(perceptronInput.testing{i_p},1),1);
for i=1:size(perceptronInput.testing{i_p},1)
perceptronTarget.testing(i) = mod(i-1, n.expressions) + 1;
end