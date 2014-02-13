% test real time activity recognition with bags of hankelets
% Xikang Zhang, 12/03/2013

% function testHankelFeat
clear;clc;close all;

% svm regularization parameters
C = 10;
G = 1e-4;

% acquire background
FrameWidth = 320;
FrameHeight = 240;
f = figure;
axis([0 FrameWidth 0 FrameHeight]);
axis off;
h = text(FrameWidth/2,FrameHeight/2,num2str(3),'Color','r','FontSize',70,'HorizontalAlignment','center');
pause(1);
for i=2:-1:0
    set(h,'string',num2str(i));
    pause(1)
end
set(h,'string','start','Color','g');
pause(1)
close(f);
pause(0.01)


% getVideo;
tic
genTrajectory;
toc

addpath(genpath('../3rdParty/hankelet-master/hankelet-master'));
addpath(genpath(getProjectBaseFolder));

% load data
traj = readTrajectory('cache');

% ignore frame number
X = traj(:,2:end)';

% take out the mean
xm = mean(X(1:2:end,:));
ym = mean(X(2:2:end,:));
Xm = kron(ones(size(X,1)/2,1),[xm;ym]);
X = X - Xm;

% load cluster centers
load('../model/kmeansWords100_action01_06_person01_26_scene010304_20140211t.mat');

% get hankelet features
[~, ~, hFeat] = find_weight_labels_df_HHp_newProtocal({trainCenter{3}},X, params);

addpath('/home/xikang/research/code/kthActivity/3rdParty/libsvm-2.9-dense_chi_square_mat');
load('../model/svmChi2_words100_action01_06_person01_26_scene010304_20140211t');
for i=1:length(svmModel)
    [predict_label, ~, ~] = svmpredict_chi2(0, hFeat, svmModel{i});
    predict_label
    label(i) = predict_label;
end
rmpath('/home/xikang/research/code/kthActivity/3rdParty/libsvm-2.9-dense_chi_square_mat');

% display label
displayActivityLabel(label);