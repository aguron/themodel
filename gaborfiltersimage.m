% Script
%
% GABORFILTERSIMAGE
%   Notes:
%   6/12/2013
%       Creates an image showing the Gabor filters

% Face to be displayed with Gabor filters
imageGabors{1} = double(image1);
imageGabors{1} = imageGabors{1}/max(max(imageGabors{1}));

% Entire Gabor filter set
imageGabors{2} = [];

indexGabors = 0;
boundary = 1;

for j=gaborFilters.frequency
    gaborFilters2 = eval(['gaborFilters.f', num2str(j)]);

    % Gabor filter size
    filterSize = size(gaborFilters2,1);

    % Padding computation
    verticalPadding = imageSize(1)/2 - filterSize/2;
    horizontalPadding = imageSize(2)/2 - filterSize/2;

    nPaddingColumns =...
        (horizontalPadding > 0)*...
        [ceil(horizontalPadding) floor(horizontalPadding)];
    nPaddingRows =...
        (verticalPadding > 0)*...
        [ceil(verticalPadding) floor(verticalPadding)];

    himpad = vision.ImagePadder('Method', 'Constant', ...
           'PaddingValue', 0.5, ...
           'RowPaddingLocation', 'Both top and bottom', ...
          'NumPaddingRows', nPaddingRows, ...
          'ColumnPaddingLocation', 'Both left and right', ...
          'NumPaddingColumns', nPaddingColumns);

    for i=gaborFilters.orientation
        gaborFilter =...
            real(gaborFilters2(:,filterSize*i+1:filterSize*(i+1)));
        gaborFilter =...
            step(himpad, (gaborFilter/max(max(abs(gaborFilter))))+0.5);
        
        % Image for display
        if i == indexGabors
            imageGabors{1} = [imageGabors{1},...
                              ones(imageSize(1), boundary),...
                              gaborFilter];
        end
        
        if i == gaborFilters.orientation(1)
            temp = [temp, gaborFilter];
        else
            temp = [temp, ones(imageSize(1), boundary), gaborFilter];
        end
    end
    imageGabors{2} = [imageGabors{2};...
                      ones(boundary, size(temp,2));...
                      temp]; 
    
    indexGabors = indexGabors + 1;
end

figure;
imshow(imageGabors{1});

figure;
imshow(imageGabors{2});

clear imageSize indexGabors boundary gaborFilters2
clear filterSize verticalPadding horizontalPadding
clear nPaddingColumns nPaddingRows himpad gaborFilter temp