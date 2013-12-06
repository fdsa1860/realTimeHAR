% generate videos or images

addpath(genpath('../3rdParty/mexopencv-master'));

% Set up camera
camera = cv.VideoCapture;
pause(3); % Necessary in some environment. See help cv.VideoCapture

% Set up display window
window = figure('KeyPressFcn',@(obj,evt)setappdata(obj,'flag',true));
setappdata(window,'flag',false);

while true
    % Grab and preprocess an image
    im = camera.read;
    im = cv.resize(im,0.5);
    
    % Draw results
    imshow(im);
    
    % Terminate if any user input
    flag = getappdata(window,'flag');
    if isempty(flag)||flag, break; end
    pause(0.1);
end

rmpath(genpath('../3rdParty/mexopencv-master'));