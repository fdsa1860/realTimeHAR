% get dense trajectories

DenseTraj = '/home/xikang/research/code/realTimeHAR/3rdParty/dense_trajectory_release_v1.2/release/DenseTrack';
video = '/home/xikang/research/code/realTimeHAR/testVideo/person01_boxing_d1_uncomp.mp4';
output = '../expData/person01_boxing_d1_uncomp.gz';

cmd = [DenseTraj ' ' video ' | gzip -> ' output];
system(cmd);
gunzip(output);
delete(output);
