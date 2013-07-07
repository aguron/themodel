function pattern = unravel(mask, nGabor)
%UNRAVEL converts a mask corresponding to one Gabor filter
%   to an unraveled mask corresponding to a bank of filters.
%
% INPUT
%   mask            - corresponding to one Gabor filter
%   nGabor          - number of filters in bank

% OUTPUT
%   pattern         - unraveled mask corrsponding to bank of
%                     filters

   % Unravel the attention mask
   mask = mask';
   mask = reshape(mask,1,[]);
   
   pattern = [];
   for i=1:nGabor
       pattern = [pattern, mask];
   end   
end