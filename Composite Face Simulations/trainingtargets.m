% Both training and validation stimuli sets have sizes that are
% multiples of 7, and have the following motif of values (which 
% have been assigned to expressions in DEFINECONSTANTS):
%   1 (Happy)
%   2 (Sad)
%   3 (Surprised)
%   4 (Angry)
%   5 (Disgusted)
%   6 (Fearful)
%   7 (Neutral)

% For training:
perceptronTarget.training =...
    zeros(size(perceptronInput.training,1),1);
for i=1:size(perceptronInput.training,1)
    perceptronTarget.training(i) = mod(i-1, n.expressions) + 1;
end

% For cross-validation:
perceptronTarget.validation =...
    zeros(size(perceptronInput.validation,1),1);
for i=1:size(perceptronInput.validation,1)
    perceptronTarget.validation(i) = mod(i-1, n.expressions) + 1;
end