% Script
%
% APPLYGABORFILTERS2IMAGES
%   Notes:
%   6/11/2013
%     -This script assumes that the images are grouped into
%      subdirectories by facial actor.
%     -Includes half face stimuli used in the experiments by
%      Tanaka et al. (2012)
%     -Introduces a white background
%
%   Functions called:
%       gaborfilter
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
%
%       This function assumes that there is at most one image of
%       a particular facial expression and identity in the folder
%       with the images to be processed.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%          CLEAR           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     LOAD GABOR FILTER SET     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load('gaborFilters.mat', 'gaborFilters');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   SPECIFYING GABOR FILTER GRID DIMENSIONS   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The density of Gabor filtering is adjusted according to the
% pixel dimensions of the input image

% Horizontal grid dimension
numGaborH = 36;

% Vertical grid dimension
numGaborV = 30;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   LOCATION OF POFA DATASET   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
location = ['C:\Users\Akin\Documents\Current Work\Research\',...
            'Images\POFA\Images (for congruency effect)\'];

% location = './Image Processing/';

% folder = {'gs' 'jj' 'mf' 'mo' ...
%           'nr' 'pe' 'pf' 'sw' 'wf'};

% folder = {'em' 'pe' 'pf' 'sw' 'wf'};

folder = {'jj'};

for i=1:length(folder)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% NUMBER AND SIZES OF IMAGES IN THE FOLDER %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Locate the folder with images
path = [location, folder{i}];

% dirListing is a struct array with the names of all the files
dirListing = dir(path);

% Initialize a variable for the number of images
numImages = 0;
for fp1 = 1:length(dirListing)
    if ~dirListing(fp1).isdir
        numImages = numImages + 1;
    end
end

% Determine the size of an image
% Use the full path to a file because the folder may not be the
% active path
fileName1 = fullfile(path,dirListing(fp1).name);

% Open or load file e.g. fopen(fileName)
% imread(fileName, 'fileType') is used here.
% File format needs to be specified correctly
image1 = imread(fileName1, 'pgm');
imageSize = [size(image1, 1) size(image1, 2)];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FLAG TO DETERMINE COMPUTATION OF GABOR FEATURES %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
features = 0;

if (features == 1)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % ARRAYS TO STORE GABOR FILTER FEATURES %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Initialize twelve 2-dimensional arrays to store Gabor filter
    % feature vectors in rows for the:

    % 1. Noncomposite left-shifted aligned face images
    NC_LS_A_faces = zeros(numImages, numGaborV*numGaborH*8*5);

    % 2. Noncomposite right-shifted aligned face images
    NC_RS_A_faces = zeros(numImages, numGaborV*numGaborH*8*5);

    % 3. Composite left-shifted aligned face images
    C_LS_A_faces = zeros(numImages*(numImages-1),...
                            numGaborV*numGaborH*8*5);

    % 4. Composite right-shifted aligned face images
    C_RS_A_faces = zeros(numImages*(numImages-1),...
                            numGaborV*numGaborH*8*5);

    % 5. Noncomposite top-left bottom-right misaligned face images
    NC_TLBR_MA_faces = zeros(numImages, numGaborV*numGaborH*8*5);

    % 6. Noncomposite top-right bottom-left misaligned face images
    NC_TRBL_MA_faces = zeros(numImages, numGaborV*numGaborH*8*5);

    % 7. Composite top-left bottom-right misaligned face images
    C_TLBR_MA_faces = zeros(numImages*(numImages-1),...
                            numGaborV*numGaborH*8*5);

    % 8. Composite top-right bottom-left misaligned face images
    C_TRBL_MA_faces = zeros(numImages*(numImages-1),...
                            numGaborV*numGaborH*8*5);

    % 9. top-half left-shifted
    TH_LS_faces = zeros(numImages, numGaborV*numGaborH*8*5);

    % 10. bottom-half left-shifted
    BH_LS_faces = zeros(numImages, numGaborV*numGaborH*8*5);

    % 11. top-half right-shifted
    TH_RS_faces = zeros(numImages, numGaborV*numGaborH*8*5);

    % 12. bottom-half right-shifted
    BH_RS_faces = zeros(numImages, numGaborV*numGaborH*8*5);


    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %     ACQUIRING IMAGES FROM FOLDER FOR PROCESSING    %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % loop through the files and open. Note that dir also lists the
    % directories, so you have to check for those and skip them.

    % Initialize indexes for each type of image generated
    index = ones(12,1);
    
end

% Background used in generating images
background = uint8(255*ones(imageSize(1)/2,imageSize(2)/2));

for fp1 = 1:length(dirListing)
    if ~dirListing(fp1).isdir
        for fp2 = 1:length(dirListing)
            if ~dirListing(fp2).isdir
                % Use the full path because the folder may not be
                % the active path
                fileName1 = fullfile(path,dirListing(fp1).name);
                fileName2 = fullfile(path,dirListing(fp2).name);
                
                % Open or load file e.g. fopen(fileName)
                % imread(fileName, 'fileType') is used here.
                % File format needs to be specified correctly
                image1 = imread(fileName1, 'pgm');
                image2 = imread(fileName2, 'pgm');

                % Portions from image1 and image2
                I1_A = image1(1:imageSize(1)/2,1:sizeImages(2)/2);
                I1_B = image1(1:sizeImages(1)/2,(sizeImages(2)/2)+1:end);
                I1_C = image1((sizeImages(1)/2)+1:end,1:sizeImages(2)/2);
                I1_D =...
                  image1((sizeImages(1)/2)+1:end,(sizeImages(2)/2)+1:end);
                I2_A = image2((sizeImages(1)/2)+1:end,1:sizeImages(2)/2);
                I2_B =...
                  image2((sizeImages(1)/2)+1:end,(sizeImages(2)/2)+1:end);

                % Generate images:
                if (fp1 == fp2)
                    % 1. Noncomposite left-shifted aligned face
                    %    images
                    % Generate image
                    I = [I1_A I1_B background;
                         I2_A I2_B background];
                    % Display image
                    show(I);
                    %%%%%%%%%
                    I_disp1 = I;
                    %%%%%%%%%
                    if (features == 1)
                        % Store Gabor filter feature vector
                        NC_LS_A_faces(i1,:) =...
                            gaborFilter(double(I), Gbio_set,...
                                        numGaborH, numGaborV);
                        % Increase the index to the array for this
                        % type of image because one more image has
                        % been added
                        i1 = i1 + 1;
                    end                    
                    % 2. Noncomposite right-shifted aligned face
                    %    images 
                    % Generate image
                    I = [background I1_A I1_B;
                         background I2_A I2_B];
                    % Display image
                    show(I);
                    %%%%%%%%%
                    I_disp1 = [I_disp1, ones(size(I_disp1,1),2), I];
                    %%%%%%%%%
                    if (features == 1)
                        % Store Gabor filter feature vector
                        NC_RS_A_faces(i2,:) =...
                            gaborFilter(double(I), Gbio_set,...
                                        numGaborH, numGaborV);
                        % Increase the index to the array for this
                        % type of image because one more image has
                        % been added
                        i2 = i2 + 1;
                    end
                    % 5. noncomposite top-left bottom-right 
                    %    misaligned face images
                    % Generate image
                    I = [I1_A I1_B background;
                         background I2_A I2_B];
                    % Display image
                    show(I);
                    %%%%%%%%%
                    I_disp2 = I;
                    %%%%%%%%%
                    if (features == 1)
                        % Store Gabor filter feature vector
                        NC_TLBR_MA_faces(i5,:) =...
                            gaborFilter(double(I), Gbio_set,...
                                        numGaborH, numGaborV);
                        % Increase the index to the array for this
                        % type of image because one more image has
                        % been added
                        i5 = i5 + 1;
                    end

                    % 6. Noncomposite top-right bottom-left
                    %    misaligned face images
                    % Generate image
                    I = [background I1_A I1_B;
                         I2_A I2_B background];
                    % Display image
                    show(I);
                    %%%%%%%%%
                    I_disp2 = [I_disp2, ones(size(I_disp2,1),2), I];
                    %%%%%%%%%
                    if (features == 1)
                        % Store Gabor filter feature vector
                        NC_TRBL_MA_faces(i6,:) =...
                            gaborFilter(double(I), Gbio_set,...
                                        numGaborH, numGaborV);
                        % Increase the index to the array for this
                        % type of image because one more image has
                        % been added
                        i6 = i6 + 1;
                    end
                end

                show(I_disp1);
                show(I_disp2);
                error('Stop');
                
                if (fp1 ~= fp2)
                    % 3. Composite left-shifted aligned face
                    %    images
                    % Generate image
                    I = [I1_A I1_B background;
                         I2_A I2_B background];
                    % Display image
                    show(I);
                    if (features == 1)
                        % Store Gabor filter feature vector
                        C_LS_A_faces(i3,:) =...
                            gaborFilter(double(I), Gbio_set,...
                                        numGaborH, numGaborV);
                        % Increase the index to the array for this
                        % type of image because one more image has
                        % been added
                        i3 = i3 + 1;
                    end

                    % 4. Composite right-shifted aligned face 
                    %    images
                    % Generate image
                    I = [background I1_A I1_B;
                         background I2_A I2_B];
                    % Display image
                    show(I);
                    if (features == 1)
                        % Store Gabor filter feature vector
                        C_RS_A_faces(i4,:) =...
                            gaborFilter(double(I), Gbio_set,...
                                        numGaborH, numGaborV);
                        % Increase the index to the array for this
                        % type of image because one more image has
                        % been added
                        i4 = i4 + 1;
                    end

                    % 7. noncomposite top-left bottom-right 
                    %    misaligned face images
                    % Generate image
                    I = [I1_A I1_B background;
                         background I2_A I2_B];
                    % Display image
                    show(I);
                    if (features == 1)
                        % Store Gabor filter feature vector
                        C_TLBR_MA_faces(i7,:) =...
                            gaborFilter(double(I), Gbio_set,...
                                        numGaborH, numGaborV);
                        % Increase the index to the array for this
                        % type of image because one more image has
                        % been added
                        i7 = i7 + 1;
                    end

                    % 8. Noncomposite top-right bottom-left
                    %    misaligned face images
                    % Generate image
                    I = [background I1_A I1_B;
                         I2_A I2_B background];
                    % Display image
                    show(I);
                    if (features == 1)
                        % Store Gabor filter feature vector
                        C_TRBL_MA_faces(i8,:) =...
                            gaborFilter(double(I), Gbio_set,...
                                        numGaborH, numGaborV);
                        % Increase the index to the array for this
                        % type of image because one more image has
                        % been added
                        i8 = i8 + 1;
                    end
                end
            end
        end

        % 9. top-half left-shifted face images
        I = [I1_A I1_B background;
             background background background];
        
        % Display image
        show(I);
        if (features == 1)
            % Store Gabor filter feature vector
            TH_LS_faces(i9,:) =...
                gaborFilter(double(I), Gbio_set,...
                    numGaborH, numGaborV);

            % Increase the index to the array for this type of image
            % because one more image has been added
            i9 = i9 + 1;
        end

        % 10. bottom-half left-shifted face images
        I = [background background background;
             I1_C I1_D background];
        
        % Display image
        show(I);
        if (features == 1)
            % Store Gabor filter feature vector
            BH_LS_faces(i10,:) =...
                gaborFilter(double(I), Gbio_set,...
                    numGaborH, numGaborV);

            % Increase the index to the array for this type of image
            % because one more image has been added
            i10 = i10 + 1;
        end

        % 11. top-half right-shifted face images
        I = [background I1_A I1_B;
             background background background];
        
        % Display image
        show(I);
        if (features == 1)
            % Store Gabor filter feature vector
            TH_RS_faces(i11,:) =...
                gaborFilter(double(I), Gbio_set,...
                    numGaborH, numGaborV);

            % Increase the index to the array for this type of
            % image because one more image has been added
            i11 = i11 + 1;
        end

        % 12. bottom-half right-shifted face images
        I = [background background background;
             background I1_C I1_D];
        
        % Display image
        show(I);
        if (features == 1)
            % Store Gabor filter feature vector
            BH_RS_faces(i12,:) =...
                gaborFilter(double(I), Gbio_set,...
                    numGaborH, numGaborV);

            % Increase the index to the array for this type of image
            % because one more image has been added
            i12 = i12 + 1;
        end
    end
end

%%%%%%%%%%%%%%%%%%%%%
%     TIDYING UP    %
%%%%%%%%%%%%%%%%%%%%%
clear location folder path dirListing numImages fp1 fp2
clear fileName2 features background image2 i I1 I2 I

close all

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     SAVING GABOR FILTER FEATURES    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% files = {'gs3' 'jj3' 'mf3' 'mo3' ...
%           'nr3' 'pe3' 'pf3' 'sw3' 'wf3'};

if (features == 1)
    files = {'em3' 'pe3' 'pf3' 'sw3' 'wf3'};

    save(files{i}, 'NC_LS_A_faces', 'NC_RS_A_faces',...
                   'C_LS_A_faces', 'C_RS_A_faces',...
                   'NC_TLBR_MA_faces', 'NC_TRBL_MA_faces',...
                   'C_TLBR_MA_faces', 'C_TRBL_MA_faces',...
                   'TH_LS_faces', 'BH_LS_faces',...
                   'TH_RS_faces', 'BH_RS_faces');
end

end