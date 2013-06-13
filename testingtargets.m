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

% For testing:
Y_test = zeros(size(X_test{1},1),1);
for i=1:size(X_test{1},1)
Y_test(i) = mod(i-1,7) + 1;
end