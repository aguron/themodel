function varargout = show(varargin)
%SHOW does one of the following:
%   i. opens a figure window (if there is no input argument)
%   ii. makes sure there is a enough memory for a specified number
%      (integer as input argument) of figure windows
%   iii. opens a figure window and displays an image

    global refuse_new_figures
    switch nargin
        case 0
            % open a figure window
            if refuse_new_figures
                disp('Press any key to continue');
                pause;
                close all hidden
                refuse_new_figures = [];
                varargout{1} = figure2;
            else
                varargout{1} = figure2;
            end
        case 1         
            % memory reset
            if refuse_new_figures
                disp('Press any key to continue');
                pause;
                close all hidden
                refuse_new_figures = [];
                % display image
                if (max(size(varargin{1})) == 1)
                    return
                else
                    varargout{1} = figure2;
                    imshow(varargin{1});
                end
            else
                % make sure there is enough memory for the
                % specified number of figure windows
                if (max(size(varargin{1})) == 1)
                    if (varargin{1} > 0)
                        figure2;
                        show(varargin{1} - 1);
                        close;
                    else
                        return
                    end
                else
                    varargout{1} = figure2;
                    imshow(varargin{1});
                end
            end
        otherwise
            disp('Error: more than one argument')
    end
end