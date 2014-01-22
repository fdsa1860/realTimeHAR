% generate videos or images

function getVideo

addpath(genpath('../3rdParty/mexopencv-master'));

BkgdSubThres = 10;
FrameRate = 10;
FrameWidth = 320;
FrameHeight = 240;

% Set up camera
camera = cv.VideoCapture;
pause(3); % Necessary in some environment. See help cv.VideoCapture
camera.set('FrameWidth',FrameWidth);
camera.set('FrameHeight',FrameHeight);
% camera.set('FPS',5);

% Set up display window
window = figure('KeyPressFcn',@(obj,evt)setappdata(obj,'flag',true));
setappdata(window,'flag',false);

vidObj = VideoWriter('../testVideo/cache.avi','Uncompressed AVI');
% vidObj.Quality = 100;
vidObj.FrameRate = FrameRate;
open(vidObj);

try
    % acquire background
    bkgd = camera.read;
    bkgd_gray = rgb2gray(bkgd);
    imshow(bkgd);drawnow;
    h = text(FrameWidth/2,FrameHeight/2,num2str(3),'Color','r','FontSize',70,'HorizontalAlignment','center');
    pause(1);
    for i=2:-1:0
        set(h,'string',num2str(i));
        pause(1)
    end
    set(h,'string','start','Color','g');
    pause(1)
    
    counter = 0;
    maxCount = 200;
    while true
        % Grab and preprocess an image
        im = camera.read;
%         msk = bsxfun(@gt,abs(double(rgb2gray(im))-double(bkgd_gray)),BkgdSubThres);
%         se = strel('disk',3);
%         msk = imerode(msk,se);
%         se = strel('disk',10);
%         msk = imdilate(msk,se);
%         im = bsxfun(@times,im, uint8(msk));
        % Draw results
        imshow(im);drawnow;
        
        writeVideo(vidObj,im);
        counter = counter + 1;
        if counter==maxCount
            break;
        end
        
        % Terminate if any user input
        flag = getappdata(window,'flag');
        if isempty(flag)||flag, break; end
        %     pause(1/50);
    end
catch me
    clear camera;
    close(vidObj);
    rethrow(me);
end

% destruct VideoCapture object
clear camera;

close(vidObj);

rmpath(genpath('../3rdParty/mexopencv-master'));

end