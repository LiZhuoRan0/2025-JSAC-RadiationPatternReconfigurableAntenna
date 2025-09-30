N_it = 10000;
N_antenna = 4;
P_C_All = [27 29 31 33];
HPBW_All = [25 45 65];

OMP_MUSIC = 0;%0: OMP, 1: MUSIC
OMP_MUSIC_string = {'OMP', 'MUSIC'};
LoS_NLoS = 0; %0: LoS, 1: NLoS
LoS_NLoS_string = {'LoS', 'NLoS'};
Low = 0;      %0: Low, 1: Original
Low_string = {'Low', 'Original'};
SavePath = sprintf('../Data/Simu/NoJammer/NoJammer_%s_%s_%s_N_%d_Antenna_%d.mat', ...
           OMP_MUSIC_string{OMP_MUSIC+1},...
           LoS_NLoS_string{LoS_NLoS+1},...
           Low_string{Low+1},...
           N_it, N_antenna);
SE_up_OMP_Low = load(SavePath).SE_up;
% SE_dn_OMP_Low = load(SavePath).SE_dn;

OMP_MUSIC = 1;%0: OMP, 1: MUSIC
OMP_MUSIC_string = {'OMP', 'MUSIC'};
LoS_NLoS = 0; %0: LoS, 1: NLoS
LoS_NLoS_string = {'LoS', 'NLoS'};
Low = 0;      %0: Low, 1: Original
Low_string = {'Low', 'Original'};
SavePath = sprintf('../Data/Simu/NoJammer/NoJammer_%s_%s_%s_N_%d_Antenna_%d.mat', ...
           OMP_MUSIC_string{OMP_MUSIC+1},...
           LoS_NLoS_string{LoS_NLoS+1},...
           Low_string{Low+1},...
           N_it, N_antenna);
SE_up_MUSIC_Low = load(SavePath).SE_up;
% SE_dn_MUSIC_Low = load(SavePath).SE_dn;

OMP_MUSIC = 0;%0: OMP, 1: MUSIC
OMP_MUSIC_string = {'OMP', 'MUSIC'};
LoS_NLoS = 0; %0: LoS, 1: NLoS
LoS_NLoS_string = {'LoS', 'NLoS'};
Low = 0;      %0: Low, 1: Original
Low_string = {'Low', 'Original'};
SavePath = sprintf('../Data/Simu/NoJammer/NoJammer_%s_%s_%s_N_%d_Antenna_%d.mat', ...
           OMP_MUSIC_string{OMP_MUSIC+1},...
           LoS_NLoS_string{LoS_NLoS+1},...
           Low_string{Low+1},...
           N_it, 2);
SE_up_OMP_Low_2 = load(SavePath).SE_up;

OMP_MUSIC = 0;%0: OMP, 1: MUSIC
OMP_MUSIC_string = {'OMP', 'MUSIC'};
LoS_NLoS = 0; %0: LoS, 1: NLoS
LoS_NLoS_string = {'LoS', 'NLoS'};
Low = 0;      %0: Low, 1: Original
Low_string = {'Low', 'Original'};
SavePath = sprintf('../Data/Simu/NoJammer/NoJammer_%s_%s_%s_N_%d_Antenna_%d.mat', ...
           OMP_MUSIC_string{OMP_MUSIC+1},...
           LoS_NLoS_string{LoS_NLoS+1},...
           Low_string{Low+1},...
           N_it, 1);
SE_up_OMP_Low_1 = load(SavePath).SE_up;
% close all

%% 1. Up Spectrum Efficiency —— Algorithm
set(0,'defaultfigurecolor','w')
figure; hold on; box on; grid on;
set(gca,'FontName','Times New Roman','FontSize',16);

p1  = plot(P_C_All, mean(squeeze(SE_up_OMP_Low(:,1,[3,7,8,9])), 1));
set(p1, 'Marker', '+','LineStyle','-', 'Color', 'r', 'LineWidth', 2, 'MarkerSize', 10) 

p2  = plot(P_C_All, mean(squeeze(SE_up_OMP_Low(:,3,[3,7,8,9])), 1));
set(p2, 'Marker', 's','LineStyle','-', 'Color', 'g', 'LineWidth', 2, 'MarkerSize', 10) 

p3  = plot(P_C_All, mean(squeeze(SE_up_OMP_Low(:,2,[3,7,8,9])), 1));
set(p3, 'Marker', 'o','LineStyle','-', 'Color', 'b', 'LineWidth', 2, 'MarkerSize', 10)   

p4  = plot(P_C_All, mean(squeeze(SE_up_MUSIC_Low(:,2,[3,7,8,9])), 1));
set(p4, 'Marker', '+','LineStyle','-', 'Color', 'c', 'LineWidth', 2, 'MarkerSize', 10) 

xlabel('Transmit Power [dBm]');
ylabel('SE (bit/s/Hz)');
title('Uplink')
ah1=axes('position',get(gca,'position'),'visible','off'); 
l1 = legend(ah1, [p1, p2, p3, p4],...
    {'Oracle',...
     'Omni', ...
     'OMP, Low',...
     'MUSIC'},...
    'Box','off', ...
    'Interpreter','tex', ...
    'NumColumns', 3);
l1.FontSize = 16;
l1.FontName = 'Times New Roman';

%% 2. Up Spectrum Efficiency —— HPBW

set(0,'defaultfigurecolor','w')
figure; hold on; box on; grid on;
set(gca,'FontName','Times New Roman','FontSize',16);

p1  = plot(HPBW_All, fliplr(mean(squeeze(SE_up_OMP_Low(:,1,[3,4,5])), 1)));
set(p1, 'Marker', '+','LineStyle','-', 'Color', 'r', 'LineWidth', 2, 'MarkerSize', 10) 

p2  = plot(HPBW_All, fliplr(mean(squeeze(SE_up_OMP_Low(:,3,[3,4,5])), 1)));
set(p2, 'Marker', 's','LineStyle','-', 'Color', 'g', 'LineWidth', 2, 'MarkerSize', 10) 

p3  = plot(HPBW_All, fliplr(mean(squeeze(SE_up_OMP_Low(:,2,[3,4,5])), 1)));
set(p3, 'Marker', 'o','LineStyle','-', 'Color', 'b', 'LineWidth', 2, 'MarkerSize', 10)   

p4  = plot(HPBW_All, fliplr(mean(squeeze(SE_up_MUSIC_Low(:,2,[3,4,5])), 1)));
set(p4, 'Marker', '+','LineStyle','-', 'Color', 'c', 'LineWidth', 2, 'MarkerSize', 10) 

xlabel('HPBW [degree]');
ylabel('SE (bit/s/Hz)');
title('Uplink')
ah1=axes('position',get(gca,'position'),'visible','off'); 
l1 = legend(ah1, [p1, p2, p3, p4],...
    {'Oracle',...
     'Omni', ...
     'OMP, Low',...
     'MUSIC'},...
    'Box','off', ...
    'Interpreter','tex', ...
    'NumColumns', 3);
l1.FontSize = 16;
l1.FontName = 'Times New Roman';
%% 3. Up Spectrum Efficiency —— Number of Tx Antennas

set(0,'defaultfigurecolor','w')
figure; hold on; box on; grid on;
set(gca,'FontName','Times New Roman','FontSize',16);

p1  = plot(P_C_All, mean(squeeze(SE_up_OMP_Low(:,3,[3,7,8,9])), 1));
set(p1, 'Marker', 's','LineStyle','-', 'Color', 'r', 'LineWidth', 2, 'MarkerSize', 10) 

p2  = plot(P_C_All, mean(squeeze(SE_up_OMP_Low_2(:,3,[3,7,8,9])), 1));
set(p2, 'Marker', 's','LineStyle','-', 'Color', 'g', 'LineWidth', 2, 'MarkerSize', 10) 

p3  = plot(P_C_All, mean(squeeze(SE_up_OMP_Low_1(:,3,[3,7,8,9])), 1));
set(p3, 'Marker', 's','LineStyle','-', 'Color', 'b', 'LineWidth', 2, 'MarkerSize', 10)   

p4  = plot(P_C_All, mean(squeeze(SE_up_OMP_Low(:,2,[3,7,8,9])), 1));
set(p4, 'Marker', '+','LineStyle','-', 'Color', 'r', 'LineWidth', 2, 'MarkerSize', 10) 

p5  = plot(P_C_All, mean(squeeze(SE_up_OMP_Low_2(:,2,[3,7,8,9])), 1));
set(p5, 'Marker', '+','LineStyle','-', 'Color', 'g', 'LineWidth', 2, 'MarkerSize', 10) 

p6  = plot(P_C_All, mean(squeeze(SE_up_OMP_Low_1(:,2,[3,7,8,9])), 1));
set(p6, 'Marker', '+','LineStyle','-', 'Color', 'b', 'LineWidth', 2, 'MarkerSize', 10) 

xlabel('Transmit Power [dBm]');
ylabel('SE (bit/s/Hz)');
title('Uplink')
ah1=axes('position',get(gca,'position'),'visible','off'); 
l1 = legend(ah1, [p1, p2, p3, p4, p5, p6],...
    {'Omni, N_{U}=4', ...
    'Omni, N_{U}=2', ...
    'Omni, N_{U}=1', ...
     'OMP, Low, N_{U}=4',...
     'OMP, Low, N_{U}=2',...
     'OMP, Low, N_{U}=1'},...
    'Box','off', ...
    'Interpreter','tex', ...
    'NumColumns', 2);
l1.FontSize = 16;
l1.FontName = 'Times New Roman';