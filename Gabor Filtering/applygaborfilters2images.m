% Script
%
% APPLYGABORFILTERS2IMAGES
%   Notes:
%   06/27/2013
%     -This script assumes that the images are grouped into
%      subdirectories by facial actor.
%     -Includes half face stimuli used in the experiments by
%      Tanaka et al. (2012)
%     -Introduces a white background
%
%   Functions called:
%       applygaborfilters2image
%
%   Terminology for face images:
%       -composite
%           images with faces composed of top and bottom halves
%           from DIFFERENT facial expressions (e.g. happy, sad, 
%           etc.) or belonging to different identities
%
%       -noncomposite
%           images with faces composed of top and bottom halves
%           from the SAME individual with the SAME facial
%           expression (e.g. happy, sad, etc.)
%
%       -left-shifted aligned
%           facial images of width 1.5 times the width of the
%           faces with the faces against the left edge
%
%       -right-shifted aligned
%           facial images of width 1.5 times the width of the
%           faces with the faces against the right edge
%
%       -top-left bottom-right misaligned
%           facial images of width 1.5 times the width of the
%           faces with the top half of the face against the left
%           and the lower half of the face against the right
%
%       -top-right bottom-left misaligned
%           facial images of width 1.5 times the width of the
%           faces with the top half of the face against the right
%           and the lower half of the face against the left
%
%
%   Function of Script:
%       Given images that are the smallest bounding boxes for
%       faces (both cropped and uncropped), this function produces
%       Gabor filter feature vectors of the following:
%           1. noncomposite left-shifted aligned
%           2. noncomposite right-shifted aligned
%           3. composite left-shifted aligned
%           4. composite right-shifted aligned
%           5. noncomposite top-left bottom-right misaligned
%           6. noncomposite top-right bottom-left misaligned
%           7. composite top-left bottom-right misaligned
%           8. composite top-right bottom-left misaligned
%           9. top-half left-shifted
%           10. bottom-half left-shifted
%           11. top-half right-shifted
%           12. bottom-half right-shifted

% location of selected images from POFA dataset
locationImages = [pwd, '/POFA images for simulations/'];

% image file type
fileType = 'pgm';

% subfolders of selected images
folder = {'em' 'gs' 'jj' 'mf' 'mo' 'nr' 'pe' 'pf' 'sw' 'wf'};
% for saving Gabor features
files = folder;

% variables which indicate if stimuli are filtered with Gabors
% and/or displayed
% filterStimuli = 1;
filterStimuli = 0;

displayStimuli = 0;

if (filterStimuli == 1)
    locationFeatures = [pwd, '/Gabor Features/'];
    mkdir(locationFeatures);
end

% For each subfolder (7 distinct facial expressions of an
% actor/actress)
for i=1:length(folder)
    % Locate a folder with images
    path = [locationImages, folder{i}];

    % dirListing is a struct array with the names of all the
    % files
    dirListing = dir(path);

    for fp1 = 1:length(dirListing)
        if ~dirListing(fp1).isdir
            break;
        end
    end

    % Determine the size of an image
    %
    % Use the full path to a file because the folder may not be the
    % active path
    fileName1 = fullfile(path,dirListing(fp1).name);
    % Open or load file e.g. fopen(fileName)
    % imread(fileName, fileType') is used here.
    % File format needs to be specified correctly
    image1 = imread(fileName1, fileType);
    imageSize = [size(image1, 1) size(image1, 2)];

    if (filterStimuli == 1)        
        % 12 two-dimensional arrays to store Gabor filter feature
        % vectors (in rows)

        % 1: noncomposite left-shifted aligned face images
        NC_LS_A_faces = zeros(n.expressions, n.gaborFeatures);

        % 2: noncomposite right-shifted aligned face images
        NC_RS_A_faces = zeros(n.expressions, n.gaborFeatures);

        % 3: composite left-shifted aligned face images
        C_LS_A_faces = zeros(n.compositeFaces, n.gaborFeatures);    

        % 4: composite right-shifted aligned face images
        C_RS_A_faces = zeros(n.compositeFaces, n.gaborFeatures);

        % 5: noncomposite top-left bottom-right misaligned face images
        NC_TLBR_MA_faces = zeros(n.expressions, n.gaborFeatures);

        % 6: noncomposite top-right bottom-left misaligned face images
        NC_TRBL_MA_faces = zeros(n.expressions, n.gaborFeatures);

        % 7: composite top-left bottom-right misaligned face images
        C_TLBR_MA_faces = zeros(n.compositeFaces, n.gaborFeatures);

        % 8: composite top-right bottom-left misaligned face images
        C_TRBL_MA_faces = zeros(n.compositeFaces, n.gaborFeatures);

        % 9: top-half left-shifted
        TH_LS_faces = zeros(n.expressions, n.gaborFeatures);

        % 10: bottom-half left-shifted
        BH_LS_faces = zeros(n.expressions, n.gaborFeatures);

        % 11: top-half right-shifted
        TH_RS_faces = zeros(n.expressions, n.gaborFeatures);

        % 12. bottom-half right-shifted
        BH_RS_faces = zeros(n.expressions, n.gaborFeatures);
        
        % First to last stimulus feature vector (ordered from
        % LEFT TO RIGHT and TOP TO BOTTOM)
        %
        % noncomposite/half face image information
        %   1 - Happy
        %   2 - Sad
        %   3 - Surprised
        %   4 - Angry
        %   5 - Disgusted
        %   6 - Fearful
        %   7 - Neutral
        %
        % composite face image information
        % Top:      1 1 1 1 1 1
        % Bottom:   2 3 4 5 6 7
        % Top:      2 2 2 2 2 2
        % Bottom:   1 3 4 5 6 7
        % Top:      3 3 3 3 3 3
        % Bottom:   1 2 4 5 6 7
        % Top:      4 4 4 4 4 4
        % Bottom:   1 2 3 5 6 7
        % Top:      5 5 5 5 5 5
        % Bottom:   1 2 3 4 6 7
        % Top:      6 6 6 6 6 6
        % Bottom:   1 2 3 4 5 7
        % Top:      7 7 7 7 7 7
        % Bottom:   1 2 3 4 5 6
    end
    
    % Acquiring images from the subfolders for processing
    %
    % Loop through files and open. Please note that subdirectories
    % within a directory are also listed; one has to check for
    % them and skip over

    % Indices for each type of stimulus
    index = ones(12,1);
    
    % Background used in generating stimului
    background = uint8(255*ones(imageSize(1)/2,imageSize(2)/2));

    for fp1 = 1:length(dirListing)
      if ~dirListing(fp1).isdir
        for fp2 = 1:length(dirListing)
          if ~dirListing(fp2).isdir
            % Full path is used because the subfolder may
            % not be the active path
            fileName1 =...
                fullfile(path,dirListing(fp1).name);
            fileName2 =...
                fullfile(path,dirListing(fp2).name);

            % Open or load file e.g. fopen(fileName)
            % imread(fileName, fileType) is used here.
            % File format needs to be specified correctly
            image1 = imread(fileName1, fileType);
            image2 = imread(fileName2, fileType);

            % Portions from image1 and image2
            image1Region{1,1} =...
                image1(1:imageSize(1)/2,...
                       1:imageSize(2)/2);
            image1Region{1,2} =...
                image1(1:imageSize(1)/2,...
                       (imageSize(2)/2)+1:end);
            image1Region{2,1} =...
                image1((imageSize(1)/2)+1:end,...
                       1:imageSize(2)/2);
            image1Region{2,2} =...
              image1((imageSize(1)/2)+1:end,...
                     (imageSize(2)/2)+1:end);
            image2Region{2,1} =...
                image2((imageSize(1)/2)+1:end,...
                       1:imageSize(2)/2);
            image2Region{2,2} =...
              image2((imageSize(1)/2)+1:end,...
                     (imageSize(2)/2)+1:end);

            % Generate stimuli
            if (fp1 == fp2)
                % 1. Noncomposite left-shifted
                %    aligned face stimuli
                stimuli =...
                    [image1Region{1,1} image1Region{1,2} background;
                     image2Region{2,1} image2Region{2,2} background];
                if (displayStimuli == 1)
                    cd ..
                    cd([pwd, '/Data Analysis and Visualization'])
                    
                    show(stimuli);
                    
                    cd ..
                    cd([pwd, '/Gabor Filtering'])
                end
                if (filterStimuli == 1)
                    NC_LS_A_faces(index(1),:) =...
                        applygaborfilters2image(stimuli,...
                                                gaborFilters,...
                                                n.dimensionHorizontal,...
                                                n.dimensionVertical);
                end
                index(1) = index(1) + 1;

                % 2. Noncomposite right-shifted
                %    aligned face stimuli
                stimuli =...
                    [background image1Region{1,1} image1Region{1,2};
                     background image2Region{2,1} image2Region{2,2}];
                if (displayStimuli == 1)
                    cd ..
                    cd([pwd, '/Data Analysis and Visualization'])
                    
                    show(stimuli);
                    
                    cd ..
                    cd([pwd, '/Gabor Filtering'])
                end
                if (filterStimuli == 1)
                    NC_RS_A_faces(index(2),:) =...
                        applygaborfilters2image(stimuli,...
                                                gaborFilters,...
                                                n.dimensionHorizontal,...
                                                n.dimensionVertical);
                end
                index(2) = index(2) + 1;

                % 5. Noncomposite top-left bottom-right
                %    misaligned face stimuli
                stimuli =...
                    [image1Region{1,1} image1Region{1,2} background;
                     background image2Region{2,1} image2Region{2,2}];
                if (displayStimuli == 1)
                    cd ..
                    cd([pwd, '/Data Analysis and Visualization'])
                    
                    show(stimuli);
                    
                    cd ..
                    cd([pwd, '/Gabor Filtering'])
                end
                if (filterStimuli == 1)
                    NC_TLBR_MA_faces(index(5),:) =...
                        applygaborfilters2image(stimuli,...
                                                gaborFilters,...
                                                n.dimensionHorizontal,...
                                                n.dimensionVertical);
                end
                index(5) = index(5) + 1;

                % 6. Noncomposite top-right bottom-left
                %    misaligned face stimuli
                stimuli =...
                    [background image1Region{1,1} image1Region{1,2};
                     image2Region{2,1} image2Region{2,2} background];
                if (displayStimuli == 1)
                    cd ..
                    cd([pwd, '/Data Analysis and Visualization'])
                    
                    show(stimuli);
                    
                    cd ..
                    cd([pwd, '/Gabor Filtering'])
                end
                if (filterStimuli == 1)
                    NC_TRBL_MA_faces(index(6),:) =...
                        applygaborfilters2image(stimuli,...
                                                gaborFilters,...
                                                n.dimensionHorizontal,...
                                                n.dimensionVertical);
                end
                index(6) = index(6) + 1;
            end

            if (fp1 ~= fp2)
                % 3. Composite left-shifted
                %    aligned face stimuli
                stimuli =...
                    [image1Region{1,1} image1Region{1,2} background;
                     image2Region{2,1} image2Region{2,2} background];
                if (displayStimuli == 1)
                    cd ..
                    cd([pwd, '/Data Analysis and Visualization'])
                    
                    show(stimuli);
                    
                    cd ..
                    cd([pwd, '/Gabor Filtering'])
                end
                if (filterStimuli == 1)
                    C_LS_A_faces(index(3),:) =...
                        applygaborfilters2image(stimuli,...
                                                gaborFilters,...
                                                n.dimensionHorizontal,...
                                                n.dimensionVertical);
                end
                index(3) = index(3) + 1;

                % 4. Composite right-shifted
                %    aligned face stimuli
                stimuli =...
                    [background image1Region{1,1} image1Region{1,2};
                     background image2Region{2,1} image2Region{2,2}];
                if (displayStimuli == 1)
                    cd ..
                    cd([pwd, '/Data Analysis and Visualization'])
                    
                    show(stimuli);
                    
                    cd ..
                    cd([pwd, '/Gabor Filtering'])
                end
                if (filterStimuli == 1)
                    C_RS_A_faces(index(4),:) =...
                        applygaborfilters2image(stimuli,...
                                                gaborFilters,...
                                                n.dimensionHorizontal,...
                                                n.dimensionVertical);
                end
                index(4) = index(4) + 1;

                % 7. noncomposite top-left bottom-right 
                %    misaligned face stimuli
                stimuli =...
                    [image1Region{1,1} image1Region{1,2} background;
                     background image2Region{2,1} image2Region{2,2}];
                if (displayStimuli == 1)
                    cd ..
                    cd([pwd, '/Data Analysis and Visualization'])
                    
                    show(stimuli);
                    
                    cd ..
                    cd([pwd, '/Gabor Filtering'])
                end
                if (filterStimuli == 1)
                    C_TLBR_MA_faces(index(7),:) =...
                        applygaborfilters2image(stimuli,...
                                                gaborFilters,...
                                                n.dimensionHorizontal,...
                                                n.dimensionVertical);
                end
                index(7) = index(7) + 1;

                % 8. Noncomposite top-right bottom-left
                %    misaligned face stimuli
                stimuli =...
                    [background image1Region{1,1} image1Region{1,2};
                     image2Region{2,1} image2Region{2,2} background];
                if (displayStimuli == 1)
                    cd ..
                    cd([pwd, '/Data Analysis and Visualization'])
                    
                    show(stimuli);
                    
                    cd ..
                    cd([pwd, '/Gabor Filtering'])
                end
                if (filterStimuli == 1)
                    C_TRBL_MA_faces(index(8),:) =...
                        applygaborfilters2image(stimuli,...
                                                gaborFilters,...
                                                n.dimensionHorizontal,...
                                                n.dimensionVertical);
                end
                index(8) = index(8) + 1;
            end
          end
        end

        % 9. top-half left-shifted face images
        stimuli =...
            [image1Region{1,1} image1Region{1,2} background;
             background background background];
        if (displayStimuli == 1)
            cd ..
            cd([pwd, '/Data Analysis and Visualization'])

            show(stimuli);

            cd ..
            cd([pwd, '/Gabor Filtering'])
        end
        if (filterStimuli == 1)
            TH_LS_faces(index(9),:) =...
                applygaborfilters2image(stimuli,...
                                        gaborFilters,...
                                        n.dimensionHorizontal,...
                                        n.dimensionVertical);
        end
        index(9) = index(9) + 1;

        % 10. bottom-half left-shifted face images
        stimuli =...
            [background background background;
             image1Region{2,1} image1Region{2,2} background];
        if (displayStimuli == 1)
            cd ..
            cd([pwd, '/Data Analysis and Visualization'])

            show(stimuli);

            cd ..
            cd([pwd, '/Gabor Filtering'])
        end
        if (filterStimuli == 1)
            BH_LS_faces(index(10),:) =...
                applygaborfilters2image(stimuli,...
                                        gaborFilters,...
                                        n.dimensionHorizontal,...
                                        n.dimensionVertical);
        end
        index(10) = index(10) + 1;

        % 11. top-half right-shifted face images
        stimuli =...
            [background image1Region{1,1} image1Region{1,2};
             background background background];
        if (displayStimuli == 1)
            cd ..
            cd([pwd, '/Data Analysis and Visualization'])

            show(stimuli);

            cd ..
            cd([pwd, '/Gabor Filtering'])
        end
        if (filterStimuli == 1)
            TH_RS_faces(index(11),:) =...
                applygaborfilters2image(stimuli,...
                                        gaborFilters,...
                                        n.dimensionHorizontal,...
                                        n.dimensionVertical);
        end
        index(11) = index(11) + 1;

        % 12. bottom-half right-shifted face images
        stimuli =...
            [background background background;
             background image1Region{2,1} image1Region{2,2}];
        if (displayStimuli == 1)
            cd ..
            cd([pwd, '/Data Analysis and Visualization'])

            show(stimuli);

            cd ..
            cd([pwd, '/Gabor Filtering'])
        end
        if (filterStimuli == 1)
            BH_RS_faces(index(12),:) =...
                applygaborfilters2image(stimuli,...
                                        gaborFilters,...
                                        n.dimensionHorizontal,...
                                        n.dimensionVertical);
        end
        index(12) = index(12) + 1;
      end
    end
    
    % Saving Gabor features
    if (filterStimuli == 1)
        save([locationFeatures, files{i}],...
             'NC_LS_A_faces', 'NC_RS_A_faces',...
             'C_LS_A_faces', 'C_RS_A_faces',...
             'NC_TLBR_MA_faces', 'NC_TRBL_MA_faces',...
             'C_TLBR_MA_faces', 'C_TRBL_MA_faces',...
             'TH_LS_faces', 'BH_LS_faces',...
             'TH_RS_faces', 'BH_RS_faces');
    end
end

% Tidy up
clear i locationImages fileType 
clear folder filterStimuli displayStimuli


clear path dirListing fp1 fileName1 image1 imageSize background

clear NC_LS_A_faces NC_RS_A_faces
clear C_LS_A_faces C_RS_A_faces
clear NC_TLBR_MA_faces NC_TRBL_MA_faces
clear C_TLBR_MA_faces C_TRBL_MA_faces
clear TH_LS_faces BH_LS_faces
clear TH_RS_faces BH_RS_faces

clear fp2 fileName2 image1Region image2Region stimuli