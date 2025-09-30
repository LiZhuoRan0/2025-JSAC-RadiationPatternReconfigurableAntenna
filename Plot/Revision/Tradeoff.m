%% ================ 0. 环境 ================
clear; clc; close all;
set(0,'defaultfigurecolor','w');
set(0,'defaultAxesFontName','Times New Roman','defaultAxesFontSize',16);

%% ================ 1. 读取数据 =============
matfile = '../../Data/Simu/Revision/AngleEst_Tradeoff_OMP_LoS_Low_N_10000_Antenna_1.mat';
S = load(matfile);

AngleErr = S.Angle_Error;     % 10000×2×12
SEup     = S.SE_up;           % 10000×3×12
SEdn     = S.SE_dn;           % 10000×3×12
HPBW_all = S.HPBW_all(:).';   % 1×12
Np_all   = S.N_all(:).';      % 1×12

% 唯一值
HPBW_set = unique(HPBW_all,'stable');   % [15 25 45 65]
Np_set   = sort(unique(Np_all,'stable'));% [7 9 11]

nH = numel(HPBW_set);
nN = numel(Np_set);

%% ================ 2. 构建原始网格数据 =============
% 角度误差拆两路，SE_up 与 SE_dn
JamMat = nan(nN,nH);
CtlMat = nan(nN,nH);
UPMat  = nan(nN,nH);
DNMat  = nan(nN,nH);

for k = 1:numel(HPBW_all)
    h = find(HPBW_set==HPBW_all(k));
    n = find(Np_set  ==Np_all(k));
    % Jammer (路径1)
    JamMat(n,h) = mean( AngleErr(:,1,k), 'all' );
    % Controller (路径2)
    CtlMat(n,h) = mean( AngleErr(:,2,k), 'all' );
    % SE_up / SE_dn (路径2)
    UPMat(n,h)  = mean( SEup(:,2,k), 'all' );
    DNMat(n,h)  = mean( SEdn(:,2,k), 'all' );
end

[Hgrid,Ngrid] = meshgrid(HPBW_set, Np_set);

%% ================ 3. 插值生成细网格 =============
Hq = linspace(min(HPBW_set), max(HPBW_set), 100);
Nq = linspace(min(Np_set)  , max(Np_set)  , 100);
[Hfine,Nfine] = meshgrid(Hq,Nq);

JamFine = griddata(Hgrid,Ngrid,JamMat, Hfine,Nfine,'cubic');
CtlFine = griddata(Hgrid,Ngrid,CtlMat, Hfine,Nfine,'cubic');
UPFine  = griddata(Hgrid,Ngrid,UPMat , Hfine,Nfine,'cubic');
DNFine  = griddata(Hgrid,Ngrid,DNMat , Hfine,Nfine,'cubic');

%% ================ 4. 绘图：Jammer Angle Error =============
figure;
contourf(Hfine, Nfine, JamFine, 20, 'LineColor','none');
colormap(parula); colorbar;
xlabel('HPBW [deg]');
ylabel('N_p');
title('Mean Jammer Angle Error [deg]','Interpreter','none');
set(gca,'YDir','normal');

%% ================ 5. 绘图：Controller Angle Error =============
figure;
contourf(Hfine, Nfine, CtlFine, 20, 'LineColor','none');
colormap(parula); colorbar;
xlabel('HPBW [deg]');
ylabel('N_p');
title('Mean Controller Angle Error [deg]','Interpreter','none');
set(gca,'YDir','normal');

%% ================ 6. 绘图：Mean SE_{up} =============
figure;
contourf(Hfine, Nfine, UPFine, 20, 'LineColor','none');
colormap(parula); colorbar;
xlabel('HPBW [deg]');
ylabel('N_p');
title('Mean SE_{up} (bit/s/Hz), link #2','Interpreter','none');
set(gca,'YDir','normal');

%% ================ 7. 绘图：Mean SE_{dn} =============
figure;
contourf(Hfine, Nfine, DNFine, 20, 'LineColor','none');
colormap(parula); colorbar;
xlabel('HPBW [deg]');
ylabel('N_p');
title('Mean SE_{dn} (bit/s/Hz), link #2','Interpreter','none');
set(gca,'YDir','normal');
