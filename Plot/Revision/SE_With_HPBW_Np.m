%% ============ 0. 环境 ============
clear; clc; close all;
set(0,'defaultfigurecolor','w');
set(0,'defaultAxesFontName','Times New Roman','defaultAxesFontSize',16);

%% ============ 1. 读取数据 =========
file_ind  = '../../Data/Simu/Revision/AngleEst_Independent_OMP_LoS_Low_N_10000_Antenna_1_new.mat';
file_nind = '../../Data/Simu/Revision/AngleEst_NotIndependent_OMP_LoS_Low_N_10000_Antenna_1.mat';

S_ind  = load(file_ind);
S_nind = load(file_nind);

% 第 2 条链路: 10000×6
SEdn_ind  = squeeze(S_ind.SE_dn(:,2,:));   SEup_ind  = squeeze(S_ind.SE_up(:,2,:));
SEdn_nind = squeeze(S_nind.SE_dn(:,2,:));  SEup_nind = squeeze(S_nind.SE_up(:,2,:));

% 已知列标签（手动抄录自题目） -----------------------------------------
%   ┌─────┬──────┬────────┐
%   │列号 │  HPBW│   N_p  │
%   ├─────┼──────┼────────┤
%   │  1  │  15° │   11   │
%   │  2  │  25° │   11   │
%   │  3  │  45° │   11   │
%   │  4  │  65° │   11   │
%   │  5  │  25° │    7   │
%   │  6  │  25° │    9   │
%   └─────┴──────┴────────┘
%
% 这样读者无需推断，即知每条曲线来自哪一列数据。
HPBW_all = [15 25 45 65 25 25];   % ← 手动录入，便于对照
N_all    = [11 11 11 11  7  9];

% ---------------- 统计量 ----------------
mu_dn_ind  = mean(SEdn_ind ,1);  sd_dn_ind  = std(SEdn_ind ,0,1);
mu_up_ind  = mean(SEup_ind ,1);  sd_up_ind  = std(SEup_ind ,0,1);
mu_dn_nind = mean(SEdn_nind,1);  sd_dn_nind = std(SEdn_nind,0,1);
mu_up_nind = mean(SEup_nind,1);  sd_up_nind = std(SEup_nind,0,1);

%% ============ 颜色（同原脚本，略） ============
clr_up_i       = [0 0.447 0.741];
clr_up_i_fill  = [0.55 0.75 1.0];
clr_dn_i       = [0.10 0.55 1.00];
clr_dn_i_fill  = [0.80 0.90 1.0];
clr_up_n       = [0.850 0.325 0.098];
clr_up_n_fill  = [1.00 0.60 0.50];
clr_dn_n       = [0.90  0.45 0.25];
clr_dn_n_fill  = [1.00 0.75 0.65];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ================= 2-A.  N_p = 11,  随 HPBW 变化 =========================
HPBW_target = [15 25 45 65];        % 需要展示的 HPBW 顺序
idx_hp = [1 2 3 4];                 % ← 手动索引：对应上表 1–4 列
x_hp   = 1:numel(HPBW_target);      % 横坐标 1,2,3,4

figure; hold on; box on; grid on;

% ---------- Independent ----------
% SE_up ±1σ 填充
fill([x_hp fliplr(x_hp)], ...
     [mu_up_ind(idx_hp)-sd_up_ind(idx_hp), ...
      fliplr(mu_up_ind(idx_hp)+sd_up_ind(idx_hp))], ...
     clr_up_i_fill,'FaceAlpha',0.35,'EdgeColor','none');
% SE_dn ±1σ 填充
fill([x_hp fliplr(x_hp)], ...
     [mu_dn_ind(idx_hp)-sd_dn_ind(idx_hp), ...
      fliplr(mu_dn_ind(idx_hp)+sd_dn_ind(idx_hp))], ...
     clr_dn_i_fill,'FaceAlpha',0.35,'EdgeColor','none');
% 均值线
plot(x_hp, mu_up_ind(idx_hp), 'Color',clr_up_i,'LineWidth',2,...
     'Marker','>','MarkerSize',10,'DisplayName','Indep. SE_{up}');
plot(x_hp, mu_dn_ind(idx_hp), 'Color',clr_dn_i,'LineWidth',2,...
     'LineStyle','--','Marker','>','MarkerSize',10,'DisplayName','Indep. SE_{dn}');

% ---------- Not-Independent ----------
fill([x_hp fliplr(x_hp)], ...
     [mu_up_nind(idx_hp)-sd_up_nind(idx_hp), ...
      fliplr(mu_up_nind(idx_hp)+sd_up_nind(idx_hp))], ...
     clr_up_n_fill,'FaceAlpha',0.35,'EdgeColor','none');
fill([x_hp fliplr(x_hp)], ...
     [mu_dn_nind(idx_hp)-sd_dn_nind(idx_hp), ...
      fliplr(mu_dn_nind(idx_hp)+sd_dn_nind(idx_hp))], ...
     clr_dn_n_fill,'FaceAlpha',0.35,'EdgeColor','none');
plot(x_hp, mu_up_nind(idx_hp), 'Color',clr_up_n,'LineWidth',2,...
     'Marker','<','MarkerSize',10,'DisplayName','Not-Indep. SE_{up}');
plot(x_hp, mu_dn_nind(idx_hp), 'Color',clr_dn_n,'LineWidth',2,...
     'LineStyle','--','Marker','<','MarkerSize',10,'DisplayName','Not-Indep. SE_{dn}');

xticks(x_hp); xticklabels(string(HPBW_target));
xlabel('HPBW (°)'); ylabel('SE (bit/s/Hz)');
legend('Location','northwest');
title('SE vs. HPBW  (N_p = 11)');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ================= 2-B.  HPBW = 25°,  随 N_p 变化 ========================
Np_target = [7 9 11];               % 展示顺序
idx_np = [5 6 2];                   % ← 手动索引：列 5,6,2 对应 N_p=7,9,11
x_np   = 1:numel(Np_target);

figure; hold on; box on; grid on;

% ---------- Independent ----------
fill([x_np fliplr(x_np)], ...
     [mu_up_ind(idx_np)-sd_up_ind(idx_np), ...
      fliplr(mu_up_ind(idx_np)+sd_up_ind(idx_np))], ...
     clr_up_i_fill,'FaceAlpha',0.35,'EdgeColor','none');
fill([x_np fliplr(x_np)], ...
     [mu_dn_ind(idx_np)-sd_dn_ind(idx_np), ...
      fliplr(mu_dn_ind(idx_np)+sd_dn_ind(idx_np))], ...
     clr_dn_i_fill,'FaceAlpha',0.35,'EdgeColor','none');
plot(x_np, mu_up_ind(idx_np), 'Color',clr_up_i,'LineWidth',2,...
     'Marker','*','MarkerSize',10,'DisplayName','Indep. SE_{up}');
plot(x_np, mu_dn_ind(idx_np), 'Color',clr_dn_i,'LineWidth',2,...
     'LineStyle','--','Marker','*','MarkerSize',10,...
     'DisplayName','Indep. SE_{dn}');

% ---------- Not-Independent ----------
fill([x_np fliplr(x_np)], ...
     [mu_up_nind(idx_np)-sd_up_nind(idx_np), ...
      fliplr(mu_up_nind(idx_np)+sd_up_nind(idx_np))], ...
     clr_up_n_fill,'FaceAlpha',0.35,'EdgeColor','none');
fill([x_np fliplr(x_np)], ...
     [mu_dn_nind(idx_np)-sd_dn_nind(idx_np), ...
      fliplr(mu_dn_nind(idx_np)+sd_dn_nind(idx_np))], ...
     clr_dn_n_fill,'FaceAlpha',0.35,'EdgeColor','none');
plot(x_np, mu_up_nind(idx_np), 'Color',clr_up_n,'LineWidth',2,...
     'Marker','o','MarkerSize',10,'DisplayName','Not-Indep. SE_{up}');
plot(x_np, mu_dn_nind(idx_np), 'Color',clr_dn_n,'LineWidth',2,...
     'LineStyle','--','Marker','o','MarkerSize',10,...
     'DisplayName','Not-Indep. SE_{dn}');

xticks(x_np); xticklabels(string(Np_target));
xlabel('N_p'); ylabel('SE (bit/s/Hz)');
legend('Location','northwest');
title('SE vs. N_p  (HPBW = 25°)');
