% Script
%
% GABORFILTERSIMAGE
%   Notes:
%   06/21/2013
%       Creates images showing the Gabor filters

cd ..
cd([pwd, '/Data Analysis and Visualization'])

% Face to be displayed with Gabor filters
imageGabors{1} = double(image2);
clear image2
imageGabors{1} = imageGabors{1}/max(max(imageGabors{1}));

% Entire Gabor filter set
imageGabors{2} = [];

indexGabors = 0;
boundary = 3;

% Size of images
imageSize = [292 240];

for j=gaborFilters.frequency
    gaborFilters2 = eval(['gaborFilters.f', num2str(2^j)]);

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

    temp = [];  % For displaying the entire set of Gabor filters
    for i=gaborFilters.orientation
        gaborFilter =...
            real(gaborFilters2(:,filterSize*i+1:filterSize*(i+1)));
        gaborFilter =...
            step(himpad, (gaborFilter/max(max(abs(gaborFilter))))+0.5);
        
        % For displaying image with subset of Gabor filters
        if i == indexGabors
            imageGabors{1} = [imageGabors{1},...
                              zeros(imageSize(1), boundary),...
                              gaborFilter];
        end
        
        % For displaying the entire set of Gabor filters
        if i == gaborFilters.orientation(1)
            temp = [temp, gaborFilter];
        else
            temp = [temp, zeros(imageSize(1), boundary), gaborFilter];
        end
    end
    
    % For displaying the entire set of Gabor filters
    if j == gaborFilters.frequency(1)
        imageGabors{2} = [imageGabors{2};
                          temp];
    else
        imageGabors{2} = [imageGabors{2};...
                          zeros(boundary, size(temp,2));...
                          temp];
    end
    
    indexGabors = indexGabors + 1;
end

show(imageGabors{1});
show(imageGabors{2});


% Tidy up
cd ..
cd([pwd, '/Gabor Filtering'])

clear imageSize indexGabors boundary gaborFilters2
clear filterSize verticalPadding horizontalPadding
clear nPaddingColumns nPaddingRows himpad gaborFilter temp