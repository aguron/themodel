function gaborFeatureVector =...
    applygaborfilters2image(I, gaborFilters,...
                            dimensionHorizontal,...
                            dimensionVertical)
%APPLYGABORFILTERS2IMAGE applies 40 Gabor filters to an image.
%
% INPUTS
%   I                   - image
%   gaborFilters        - Gabor filters
%   dimensionHorizontal - horizontal dimension of grid of Gabor
%                         filter samples
%   dimensionVertical   - vertical dimension of grid of Gabor
%                         filter samples
%
% OUTPUT
%   gaborFeatureVector  - Gabor filter features from the image


    nFrequencies = length(gaborFilters.frequency);
    nOrientations = length(gaborFilters.orientation);

    gridDimension = [dimensionVertical dimensionHorizontal];
    
    gaborFeatureVector =...
        zeros(1, gridDimension(1)*gridDimension(2)*...
                 nOrientations*nFrequencies);

    % image dimensions
    imageSize = size(I);
    
    % spatial frequency period of (4, 8, 16, 32, 64) pixels
    for j=0:(nFrequencies - 1)
        % dimensions of the Gabor filters (each Gabor filter is
        % square-shaped)
        filterSize =...
            size(eval(['gaborFilters.f', num2str(2^(j+2))]),1);

        % Horizontal dimension of the Gabor filter grid:
        % Total Gabor filter overlap necessary
        t_h = (gridDimension(2)*filterSize) - imageSize(2);

        % Single Gabor filter overlap that is necessary without 
        % accounting for the remainder
        s_h = ceil(t_h/(gridDimension(2) - 1));

        % Number of smaller Gabor filter overlaps that is necessary
        % to account for the remainder
        r_h = mod(t_h, (gridDimension(2) - 1));

        if (r_h == 0)
            n_h = 0;
        else
            n_h = (gridDimension(2) - 1) - r_h;
        end

        % Vertical dimension of the Gabor filter grid:
        % Total Gabor filter overlap necessary
        t_v = (gridDimension(1)*filterSize) - imageSize(1);

        % Single Gabor filter overlap that is necessary without 
        % accounting for the remainder
        s_v = ceil(t_v/(gridDimension(1) - 1));

        % Number of smaller Gabor filter overlaps that is necessary
        % to account for the remainder
        r_v = mod(t_v, (gridDimension(1) - 1));
        
        if (r_v == 0)
            n_v = 0;
        else
            n_v = (gridDimension(1) - 1) - r_v;
        end

        % There are 8 orientations for each spatial frequency
        for k=0:(nOrientations - 1)
            % select a Gabor filter
            gaborFilter = eval(['gaborFilters.f',...
                                num2str(2^(j+2)),...
                                ':,((filterSize*k)+1):',...
                                '(filterSize*(k+1)))']);

            % Portion of the Image that a Gabor filter is
            % applied to:
            %   Upper - Upper Boundary
            %   Lower - Lower Boundary
            Upper = 1;
            Lower = filterSize;
            % vertical direction along the grid
            for l=1:gridDimension(1)
                % The filter is already correctly placed during
                % the first iteration
                if (l > 1)
                    % If n_v equals 0, then no smaller Gabor
                    % filter overlaps need to be introduced
                    if (n_v == 0)
                        Upper = Upper + filterSize - s_v;
                        Lower = Lower + filterSize - s_v;
                    % If gridDimension(1) is even and n_v is odd 
                    % or gridDimension(1) is odd and n_v is even                    
                    % then no adjustments need to be made in the
                    % condition for introducing smaller Gabor
                    % filter overlaps near the halfway line of
                    % the image
                    elseif (mod(gridDimension(1),2) ~= mod(n_v,2))
                        if ((l <= n_v/2) ||...
                                (l >= (gridDimension(1) - n_v/2)))
                            % smaller overlaps towards the edges
                            Upper = Upper + filterSize - (s_v - 1);
                            Lower = Lower + filterSize - (s_v - 1);
                        else
                            % larger overlaps towards the middle
                            Upper = Upper + filterSize - s_v;
                            Lower = Lower + filterSize - s_v;
                        end
                    % If gridDimension(1) is even and n_v is even
                    % or gridDimension(1) is odd and n_v is odd                    
                    % then adjustments need to be made in the
                    % condition for introducing smaller Gabor
                    % filter overlaps near the halfway line of
                    % the image                        
                    else % (mod(gridDimension(1),2) == mod(n_v,2))
                        if ((l <= n_v/2) ||...
                                (l >= ((gridDimension(1) + 1) - n_v/2)))
                            % smaller overlaps towards the edges
                            Upper = Upper + filterSize - (s_v - 1);
                            Lower = Lower + filterSize - (s_v - 1);
                        else
                            % larger overlaps towards the middle
                            Upper = Upper + filterSize - s_v;
                            Lower = Lower + filterSize - s_v;
                        end
                    end
                end
                
                % Portion of the Image that a Gabor filter is
                % applied to:
                %   Left - Left Boundary
                %   Right - Right Boundary
                Left = 1;
                Right = filterSize;
                for m=1:gridDimension(2)
                % The filter is already correctly placed during
                % the first iteration
                    if (m > 1)
                        % If n_h equals 0, then no smaller Gabor
                        % filter overlaps need to be introduced
                        if (n_h == 0)
                            Left = Left + filterSize - s_h;
                            Right = Right + filterSize - s_h;
                        % If gridDimension(2) is even and n_h is odd
                        % or gridDimension(2) is odd and n_h is even                    
                        % then no adjustments need to be made in the
                        % condition for introducing smaller Gabor
                        % filter overlaps near the halfway line of
                        % the image
                        elseif (mod(gridDimension(2),2) ~= mod(n_h,2))
                            if ((m <= n_h/2) ||...
                                (m >= (gridDimension(2) - n_h/2)))
                            % smaller overlaps towards the edges
                                Left =...
                                    Left + filterSize - (s_h - 1);
                                Right =...
                                    Right + filterSize - (s_h - 1);
                            else
                            % larger overlaps towards the middle
                                Left = Left + filterSize - s_h;
                                Right = Right + filterSize - s_h;                            
                            end
                        % If gridDimension(2) is even and n_h is even
                        % or gridDimension(2) is odd and n_h is odd                    
                        % then adjustments need to be made in the
                        % condition for introducing smaller Gabor
                        % filter overlaps near the halfway line of
                        % the image                        
                        else % (mod(gridDimension(2),2) == mod(n_h,2))
                            if ((m <= n_h/2) ||...
                                (m >= ((gridDimension(2) + 1) - n_h/2)))
                            % smaller overlaps towards the edges
                                Left =...
                                    Left + filterSize - (s_h - 1);
                                Right =...
                                    Right + filterSize - (s_h - 1);
                            else
                            % larger overlaps towards the middle
                                Left = Left + filterSize - s_h;
                                Right = Right + filterSize - s_h;
                            end
                        end
                    end
                    gaborFeatureVector(dimensionHorizontal*...
                                       (dimensionHorizontal*(8*j + k)...
                                        + (l-1))...
                                        + m) =...
                        sum(sum(gaborFilter.*I(Upper:Lower,Left:Right)));
                end
            end
        end
    end
end