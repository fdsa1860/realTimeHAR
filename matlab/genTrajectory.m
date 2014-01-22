% get dense trajectories

function genTrajectory

DenseTraj = '/home/xikang/research/code/realTimeHAR/3rdParty/dense_trajectory_release_v1.2/release/DenseTrack';
% video = '/home/xikang/research/code/realTimeHAR/testVideo/cache.avi';
video = '/home/xikang/research/code/realTimeHAR/testVideo/person01_boxing_d1_uncomp.mp4';
output = '../expData/cache.gz';

cmd = [DenseTraj ' -E 200 ' video ' | gzip -> ' output];
system(cmd);
gunzip(output);
delete(output);

end