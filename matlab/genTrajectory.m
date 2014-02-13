% get dense trajectories

function genTrajectory

DenseTraj = '../3rdParty/dense_trajectory_release_v1.2/release/DenseTrack';
% video = '/home/xikang/research/code/realTimeHAR/testVideo/cache.avi';
video = ' ';
output = '../expData/cache.gz';

cmd = [DenseTraj ' ' video ' -E 200 | gzip -> ' output];
system(cmd);
gunzip(output);
delete(output);

end
