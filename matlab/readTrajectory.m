
% read trajectories

function traj = readTrajectory(fileName,trajPath)

if nargin == 0
    trajPath = '/home/xikang/research/code/realTimeHAR/expData';
    fileName = sprintf('person03_boxing_d3_uncomp');
elseif nargin == 1
    trajPath = '/home/xikang/research/code/realTimeHAR/expData';
end

% personNum = 5;
% sceneNum = 1;
% trajPath = '/home/xikang/research/data/KTH/trackletsData';
% fileName = sprintf('person%02d_boxing_d%d_uncomp_features2',personNum,sceneNum);
% traj = load(fullfile(trajPath,fileName));

traj = load(fullfile(trajPath,fileName));

end