% generate videos or images

function getVideo

addpath(genpath('../3rdParty/mexopencv-master'));

% Set up camera
camera = cv.VideoCapture;
pause(3); % Necessary in some environment. See help cv.VideoCapture

% Set up display window
window = figure('KeyPressFcn',@(obj,evt)setappdata(obj,'flag',true));
setappdata(window,'flag',false);

vidObj = VideoWriter('../testVideo/cache.avi');
vidObj.Quality = 100;
vidObj.FrameRate = 15;
open(vidObj);

counter = 0;
maxCount = 100;
while true
    % Grab and preprocess an image
    im = camera.read;
    im = cv.resize(im,0.5);
    
    % Draw results
    imshow(im);
    writeVideo(vidObj,im);
    counter = counter + 1;
    if counter==maxCount
        break;
    end
    
    % Terminate if any user input
    flag = getappdata(window,'flag');
    if isempty(flag)||flag, break; end
    pause(0.1);
end

% destruct VideoCapture object
clear camera;

close(vidObj);

rmpath(genpath('../3rdParty/mexopencv-master'));

end