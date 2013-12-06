% get dense trajectories

function genTrajectory

DenseTraj = '/home/xikang/research/code/realTimeHAR/3rdParty/dense_trajectory_release_v1.2/release/DenseTrack';
video = '/home/xikang/research/code/realTimeHAR/testVideo/cache.avi';
output = '../expData/cache.gz';

cmd = [DenseTraj ' ' video ' | gzip -> ' output];
system(cmd);
gunzip(output);
delete(output);

end