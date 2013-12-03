
% read trajectories

function traj = readTrajectory(fileName)

if nargin == 0
    trajPath = '/home/xikang/research/code/realTimeHAR/expData';
    fileName = sprintf('person03_boxing_d3_uncomp');
    traj = load(fullfile(trajPath,fileName));
end

end