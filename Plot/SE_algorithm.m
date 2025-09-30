N_it = 10000;
N_antenna = 4;
P_C_All = [27 29 31 33];

OMP_MUSIC = 0;%0: OMP, 1: MUSIC
OMP_MUSIC_string = {'OMP', 'MUSIC'};
LoS_NLoS = 0; %0: LoS, 1: NLoS
LoS_NLoS_string = {'LoS', 'NLoS'};
Low = 1;      %0: Low, 1: Original
Low_string = {'Low', 'Original'};
SavePath = sprintf('../Data/Simu/%s_%s_%s_N_%d_Antenna_%d.mat', ...
           OMP_MUSIC_string{OMP_MUSIC+1},...
           LoS_NLoS_string{LoS_NLoS+1},...
           Low_string{Low+1},...
           N_it, N_rx_azi*N_rx_ele);
SE_up_OMP_Original = load(SavePath).SE_up;
SE_dn_OMP_Original = load(SavePath).SE_dn;

OMP_MUSIC = 0;%0: OMP, 1: MUSIC
OMP_MUSIC_string = {'OMP', 'MUSIC'};
LoS_NLoS = 0; %0: LoS, 1: NLoS
LoS_NLoS_string = {'LoS', 'NLoS'};
Low = 0;      %0: Low, 1: Original
Low_string = {'Low', 'Original'};
SavePath = sprintf('../Data/Simu/%s_%s_%s_N_%d_Antenna_%d.mat', ...
           OMP_MUSIC_string{OMP_MUSIC+1},...
           LoS_NLoS_string{LoS_NLoS+1},...
           Low_string{Low+1},...
           N_it, N_rx_azi*N_rx_ele);
SE_up_OMP_Low = load(SavePath).SE_up;
SE_dn_OMP_Low = load(SavePath).SE_dn;

OMP_MUSIC = 1;%0: OMP, 1: MUSIC
OMP_MUSIC_string = {'OMP', 'MUSIC'};
LoS_NLoS = 0; %0: LoS, 1: NLoS
LoS_NLoS_string = {'LoS', 'NLoS'};
Low = 1;      %0: Low, 1: Original
Low_string = {'Low', 'Original'};
SavePath = sprintf('../Data/Simu/%s_%s_%s_N_%d_Antenna_%d.mat', ...
           OMP_MUSIC_string{OMP_MUSIC+1},...
           LoS_NLoS_string{LoS_NLoS+1},...
           Low_string{Low+1},...
           N_it, N_rx_azi*N_rx_ele);
SE_up_MUSIC_Original = load(SavePath).SE_up;
SE_dn_MUSIC_Original = load(SavePath).SE_dn;

% close all

%% 1. Spectrum Efficiency
%% 1.1 Up
set(0,'defaultfigurecolor','w')
figure; hold on; box on; grid on;
set(gca,'FontName','Times New Roman','FontSize',16);

p1  = plot(P_C_All, mean(squeeze(SE_up_OMP_Original(:,1,[3,7,8,9])), 1));
set(p1, 'Marker', 's','LineStyle','-', 'Color', 'r', 'LineWidth', 2, 'MarkerSize', 10) 

p2  = plot(P_C_All, mean(squeeze(SE_up_OMP_Original(:,3,[3,7,8,9])), 1));
set(p2, 'Marker', 's','LineStyle','-', 'Color', 'g', 'LineWidth', 2, 'MarkerSize', 10) 

p3  = plot(P_C_All, mean(squeeze(SE_up_OMP_Original(:,2,[3,7,8,9])), 1));
set(p3, 'Marker', '+','LineStyle','-', 'Color', 'b', 'LineWidth', 2, 'MarkerSize', 10)   

p4  = plot(P_C_All, mean(squeeze(SE_up_MUSIC_Original(:,2,[3,7,8,9])), 1));
set(p4, 'Marker', '+','LineStyle','-', 'Color', 'c', 'LineWidth', 2, 'MarkerSize', 10) 

p5  = plot(P_C_All, mean(squeeze(SE_up_OMP_Low(:,2,[3,7,8,9])), 1));
set(p5, 'Marker', '+','LineStyle','-', 'Color', 'm', 'LineWidth', 2, 'MarkerSize', 10) 

xlabel('Transmit Power [dBm]');
ylabel('SE (bit/s/Hz)');
title('Uplink')
ah1=axes('position',get(gca,'position'),'visible','off'); 
l1 = legend(ah1, [p1, p2, p3, p4, p5],...
    {'Best',...
     'Omini', ...
     'OMP',...
     'MUSIC',...
     'OMP, Low'},...
    'Box','off', ...
    'Interpreter','tex', ...
    'NumColumns', 3);
l1.FontSize = 16;
l1.FontName = 'Times New Roman';

%% 1.2 Down

set(0,'defaultfigurecolor','w')
figure; hold on; box on; grid on;
set(gca,'FontName','Times New Roman','FontSize',16);

p1  = plot(P_C_All, mean(squeeze(SE_dn_OMP_Original(:,1,[3,7,8,9])), 1));
set(p1, 'Marker', 's','LineStyle','-', 'Color', 'r', 'LineWidth', 2, 'MarkerSize', 10) 

p2  = plot(P_C_All, mean(squeeze(SE_dn_OMP_Original(:,3,[3,7,8,9])), 1));
set(p2, 'Marker', 's','LineStyle','-', 'Color', 'g', 'LineWidth', 2, 'MarkerSize', 10) 

p3  = plot(P_C_All, mean(squeeze(SE_dn_OMP_Original(:,2,[3,7,8,9])), 1));
set(p3, 'Marker', '+','LineStyle','-', 'Color', 'b', 'LineWidth', 2, 'MarkerSize', 10)   

p4  = plot(P_C_All, mean(squeeze(SE_dn_MUSIC_Original(:,2,[3,7,8,9])), 1));
set(p4, 'Marker', '+','LineStyle','-', 'Color', 'c', 'LineWidth', 2, 'MarkerSize', 10) 

p5  = plot(P_C_All, mean(squeeze(SE_dn_OMP_Low(:,2,[3,7,8,9])), 1));
set(p5, 'Marker', '+','LineStyle','-', 'Color', 'm', 'LineWidth', 2, 'MarkerSize', 10) 

xlabel('Transmit Power [dBm]');
ylabel('SE (bit/s/Hz)');
title('Downlink')
ah1=axes('position',get(gca,'position'),'visible','off'); 
l1 = legend(ah1, [p1, p2, p3, p4, p5],...
    {'Best',...
     'Omini', ...
     'OMP',...
     'MUSIC',...
     'OMP, Low'},...
    'Box','off', ...
    'Interpreter','tex', ...
    'NumColumns', 3);
l1.FontSize = 16;
l1.FontName = 'Times New Roman';