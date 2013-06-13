% Taking advantage of the repeated ordering of the 
% Gabor filter feature vector correspondences
%   1 - Happy
%   2 - Sad
%   3 - Surprised
%   4 - Angry
%   5 - Disgusted
%   6 - Fearful
%   7 - Neutral
% in the arrays of vectors

% For training:
Y_train = zeros(size(X_train,1),1);
for i=1:size(X_train,1)
    Y_train(i) = mod(i-1,7) + 1;
end

% For cross-validation:
Y_validate = zeros(size(X_validate,1),1);
for i=1:size(X_validate,1)
    Y_validate(i) = mod(i-1,7) + 1;
end