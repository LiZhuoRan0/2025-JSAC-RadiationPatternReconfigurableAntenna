%% ============= 0. 环境 =============
clear; clc; close all;
set(0,'defaultfigurecolor','w');
set(0,'defaultAxesFontName','Times New Roman','defaultAxesFontSize',16);

%% ============= 1. 参数设置 =============
scales     = [0.5, 1.0, 2.0];
files      = { ...
  '../../Data/Simu/Revision/AngleEst_Scale_0_5_OMP_LoS_Low_N_10000_Antenna_1.mat', ...
  '../../Data/Simu/Revision/AngleEst_Scale_1_0_OMP_LoS_Low_N_10000_Antenna_1.mat', ...
  '../../Data/Simu/Revision/AngleEst_Scale_2_0_OMP_LoS_Low_N_10000_Antenna_1.mat'  ...
};
colors     = [0    0.447 0.741;   % 蓝
              0.850 0.325 0.098; % 红
              0.466 0.674 0.188];% 绿
alpha_val  = 0.2;

% 预分配存储
mu_jam    = cell(1,3);
sd_jam    = cell(1,3);
mu_ctrl   = cell(1,3);
sd_ctrl   = cell(1,3);
HPBW_vals = [];

%% ============= 2. 读取数据并统计 =============
for i = 1:numel(scales)
    S = load(files{i});
    A = S.Angle_Error;       % 10000×2×4
    if isempty(HPBW_vals)
        HPBW_vals = S.HPBW_all(:)';  % [15 25 45 65]
        x = HPBW_vals;
    end
    
    % Jammer (路径1)
    data_jam  = squeeze(A(:,1,:));   % 10000×4
    mu_jam{i} = mean(data_jam,1);    % 1×4
    sd_jam{i} = std( data_jam,0,1);  % 1×4
    
    % Controller (路径2)
    data_ctl    = squeeze(A(:,2,:));
    mu_ctrl{i}  = mean(data_ctl,1);
    sd_ctrl{i}  = std( data_ctl,0,1);
end

%% ============= 3. 绘图 1: Jammer 角度估计误差 =============
figure; hold on; box on; grid on;
for i = 1:numel(scales)
    c = colors(i,:);
    % 阴影带
    fill([x fliplr(x)], ...
         [mu_jam{i}-sd_jam{i}, fliplr(mu_jam{i}+sd_jam{i})], ...
         c, 'FaceAlpha', alpha_val, 'EdgeColor','none', ...
         'DisplayName', sprintf('Scale %.1f ±1σ', scales(i)));
    % 均值曲线
    plot(x, mu_jam{i}, '-o', 'Color', c, ...
         'LineWidth',2, 'MarkerSize',8, ...
         'DisplayName', sprintf('Scale %.1f μ', scales(i)));
end
xticks(x); xticklabels(string(x));
xlabel('HPBW [deg]'); ylabel('Angle Error [deg]');
title('Mean Jammer Angle Estimation Error','Interpreter','none');
legend('Location','northwest');

%% ============= 3. 绘图 2: Controller 角度估计误差 =============
figure; hold on; box on; grid on;
for i = 1:numel(scales)
    c = colors(i,:);
    % 阴影带
    fill([x fliplr(x)], ...
         [mu_ctrl{i}-sd_ctrl{i}, fliplr(mu_ctrl{i}+sd_ctrl{i})], ...
         c, 'FaceAlpha', alpha_val, 'EdgeColor','none', ...
         'DisplayName', sprintf('Scale %.1f ±1σ', scales(i)));
    % 均值曲线
    plot(x, mu_ctrl{i}, '-o', 'Color', c, ...
         'LineWidth',2, 'MarkerSize',8, ...
         'DisplayName', sprintf('Scale %.1f μ', scales(i)));
end
xticks(x); xticklabels(string(x));
xlabel('HPBW [deg]'); ylabel('Angle Error [deg]');
title('Mean Jammer Angle Estimation Error','Interpreter','none');
legend('Location','northwest');
