% get dense trajectories

DenseTraj = '/home/xikang/research/code/realTimeHAR/3rdParty/dense_trajectory_release_v1.2/release/DenseTrack';
video = '/home/xikang/research/code/realTimeHAR/testVideo/person03_boxing_d3_uncomp.avi';
output = '../expData/person03_boxing_d3_uncomp.gz';

cmd = [DenseTraj ' ' video ' | gzip -> ' output];
system(cmd);
gunzip(output);
delete(output);
