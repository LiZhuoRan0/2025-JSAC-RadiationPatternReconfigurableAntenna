%% ===== 0. 清理环境（可选） =====
clear; clc;

%% ===== 1. 读取数据 =====
file_ind  = '../../Data/Simu/Revision/AngleEst_Independent_OMP_LoS_Low_N_10000_Antenna_1_new.mat';
file_nind = '../../Data/Simu/Revision/AngleEst_NotIndependent_OMP_LoS_Low_N_10000_Antenna_1.mat';

S_ind  = load(file_ind);
S_nind = load(file_nind);

AngleErr_ind  = S_ind.Angle_Error;          % 10000×2×6
AngleErr_nind = S_nind.Angle_Error;         % 10000×2×6
HPBW_all      = S_ind.HPBW_all(:).';        % 1×6
N_all         = S_ind.N_all(:).';           % 1×6

%% ===== 2. 选定 HPBW = 25° 且 N_p ∈ {7,9,11} 的索引 =====
HPBW_fixed  = 25;
Np_target   = [7 9 11];

idx_target  = find( HPBW_all == HPBW_fixed  &  ismember(N_all, Np_target) );

% 按 N_p = 7 → 9 → 11 的顺序排列索引
idx_ordered = arrayfun(@(n) idx_target(N_all(idx_target)==n), Np_target);

%% ===== 3.1 计算均值 & 标准差（路径均值 → 实验均值/方差） =====
mu_ind  = zeros(1,numel(idx_ordered));
sd_ind  = zeros(1,numel(idx_ordered));
mu_nind = zeros(1,numel(idx_ordered));
sd_nind = zeros(1,numel(idx_ordered));

for k = 1:numel(idx_ordered)
    id  = idx_ordered(k);

    % ——— Independent ———
    tmp = squeeze(AngleErr_ind(:,1,id));   % 10000×1
    mu_ind(k) = mean(tmp);
    sd_ind(k) = std(tmp);

    % ——— Not-Independent ———
    tmp = squeeze(AngleErr_nind(:,1,id));
    mu_nind(k) = mean(tmp);
    sd_nind(k) = std(tmp);
end

%% ===== 3.2 绘图 =====
x = 1:numel(Np_target);      % 1,2,3 便于 fill

set(0,'defaultfigurecolor','w')
figure; hold on; box on; grid on;
set(gca,'FontName','Times New Roman','FontSize',16);

% —— Independent（蓝）——
fill([x fliplr(x)], [mu_ind - sd_ind  fliplr(mu_ind + sd_ind)], ...
     'b', 'FaceAlpha',0.20, 'EdgeColor','none');
plot(x, mu_ind, 'b-*', 'MarkerSize', 10, 'LineWidth',2);

% —— Not-Independent（红）——
fill([x fliplr(x)], [mu_nind - sd_nind  fliplr(mu_nind + sd_nind)], ...
     'r', 'FaceAlpha',0.20, 'EdgeColor','none');
plot(x, mu_nind, 'r-o', 'MarkerSize', 10, 'LineWidth',2);

% 轴 & 注释
xticks(x);
xticklabels(string(Np_target));
xlabel('N_p');
ylabel('Angle Error (°)');
legend({'Indep. ±1σ','Indep. μ', ...
        'Not-Indep. ±1σ','Not-Indep. μ'}, ...
        'Location','northwest');
grid on;
title('Angle Error vs. N_p  (HPBW = 25°)');

%% ===== 4.1 计算均值 & 标准差（路径均值 → 实验均值/方差） =====
mu_ind  = zeros(1,numel(idx_ordered));
sd_ind  = zeros(1,numel(idx_ordered));
mu_nind = zeros(1,numel(idx_ordered));
sd_nind = zeros(1,numel(idx_ordered));

for k = 1:numel(idx_ordered)
    id  = idx_ordered(k);

    % ——— Independent ———
    tmp = squeeze(AngleErr_ind(:,2,id));   % 10000×1    
    mu_ind(k) = mean(tmp);
    sd_ind(k) = std(tmp);

    % ——— Not-Independent ———
    tmp = squeeze(AngleErr_nind(:,2,id));
    mu_nind(k) = mean(tmp);
    sd_nind(k) = std(tmp);
end

%% ===== 4.2 绘图 =====
x = 1:numel(Np_target);      % 1,2,3 便于 fill

set(0,'defaultfigurecolor','w')
figure; hold on; box on; grid on;
set(gca,'FontName','Times New Roman','FontSize',16);

% —— Independent（蓝）——
fill([x fliplr(x)], [mu_ind - sd_ind  fliplr(mu_ind + sd_ind)], ...
     'b', 'FaceAlpha',0.20, 'EdgeColor','none');
plot(x, mu_ind, 'b-*', 'MarkerSize', 10, 'LineWidth',2);

% —— Not-Independent（红）——
fill([x fliplr(x)], [mu_nind - sd_nind  fliplr(mu_nind + sd_nind)], ...
     'r', 'FaceAlpha',0.20, 'EdgeColor','none');
plot(x, mu_nind, 'r-o', 'MarkerSize', 10, 'LineWidth',2);

% 轴 & 注释
xticks(x);
xticklabels(string(Np_target));
xlabel('N_p');
ylabel('Angle Error (°)');
legend({'Indep. ±1σ','Indep. μ', ...
        'Not-Indep. ±1σ','Not-Indep. μ'}, ...
        'Location','northwest');
grid on;
title('Angle Error vs. N_p  (HPBW = 25°)');
