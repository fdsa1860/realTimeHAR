function visualTrajectories(videoFile, word, trajectory, frameId, isRecord)

if nargin < 5
    isRecord = 0;
end

if nargin < 4
    addpath(genpath('/home/xikang/research/code/realTimeHAR/3rdParty/hankelet-master/hankelet-master'))
    trajectoryFolder = '';
    trajectoryFileName = 'out.features';
    trajectory = readTxt2Var(fullFile(trajectoryFolder,trajectoryFileName));
    frameId = trajectory(:, 1);
    trajectory = trajectory(:, 2:end);
end

if nargin < 2
    word = ones(size(trajectory,1),1);
end

if nargin < 1
    videoFolder = '/home/xikang/research/code/realTimeHAR/testVideo';
    videoFile = 'xikang_boxing.avi';
    videoFile = fullfile(videoFolder,videoFile);
end

videoVar = video.movie2var(videoFile, 1, 1);
h = figure(1);
if isRecord
    s1 = video.videoSaver(fullfile(baseFolder, '20kmeans', 'DF2EightWordColored.avi'), 11);
    s1.fig = h;
end
nFrameVis = max(frameId);
%%
for i = min(frameId) : nFrameVis
    figure(h);
    imshow(videoVar(:, :, i));
    trajIdSel = frameId == i;
    traj = trajectory(trajIdSel, :);
    tmpWord = word(trajIdSel);
    nNumerics = size(traj, 2);
    nTraj = size(traj, 1);
    ColorSet = varycolor(max(word));
    hold on
    for j = 1 : size(traj, 1)
        %         plotTrajectory(h, traj(j, :));
        plot(traj(j, 1 : 2 : nNumerics), traj(j, 2 : 2 : nNumerics), '-', ...
            'Color', ColorSet(tmpWord(j), :));
        plot(traj(j, nNumerics-1), traj(j, nNumerics), 'x', 'Color', ColorSet(tmpWord(j), :));
    end
    hold off; title(['Frame # ' num2str(i)]);
    pause(1/11);
    if isRecord
        s1.saveCore();
    end
end

if isRecord
    s1.saveClose;
end

end