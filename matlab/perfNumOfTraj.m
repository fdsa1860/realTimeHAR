% see how many trajectories are needed at least to get correct result

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
% load('../model/kmeansWords300_action01_06_person01_26_scene01_04_20131210t.mat');
load('../model/kmeansWords100_action01_06_person01_26_scene010304_20140211t.mat');

addpath('/home/xikang/research/code/kthActivity/3rdParty/libsvm-2.9-dense_chi_square_mat');
% load('../model/svmChi2_words300_action01_06_person01_26_scene01_04_20131210t');
load('../model/svmChi2_words100_action01_06_person01_26_scene010304_20140211t');

% get hankelet features
[lb, ~, hFeat] = find_weight_labels_df_HHp_newProtocal({trainCenter{3}},X, params);
for i=1:length(svmModel)
    [predict_label, ~, ~] = svmpredict_chi2(0, hFeat, svmModel{i});
%     predict_label
    final_label(i) = predict_label;
end

all_label = zeros(size(X,2),6);
flag = zeros(size(X,2),1);

for k=1:100:size(X,2)
   hFeat2 = histc(lb(1:k), (1 : size(trainCenter{3}, 2)));
    
    for i=1:length(svmModel)
        [predict_label, ~, ~] = svmpredict_chi2(0, hFeat2, svmModel{i});
%         predict_label
        label(i) = predict_label;
    end
     all_label(k,:) = label;
     flag(k) = nnz(label ~= final_label);
    k
end
rmpath('/home/xikang/research/code/kthActivity/3rdParty/libsvm-2.9-dense_chi_square_mat');

figure;
plot(1:100:length(flag),flag(1:100:end,:))
figure;
all_label = max(bsxfun(@times,all_label,[1 2 3 4 5 6]),0);
plot(1:100:size(all_label,1),all_label(1:100:end,:));
ylim([-1 7]); legend box handclapping handwaving jogging running walking
% display label
% displayActivityLabel(label);