N_it = 10000;
N_antenna = 4;

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
           N_it, N_antenna);
Angle_Error_OMP_Original = load(SavePath).Angle_Error;

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
           N_it, N_antenna);
Angle_Error_OMP_Low = load(SavePath).Angle_Error;

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
           N_it, N_antenna);
Angle_Error_MUSIC_Original = load(SavePath).Angle_Error;

% close all
set(0,'defaultfigurecolor','w')
%% 1. Jammer angle
%% 1.1 Different Radiation Pattern
figure; hold on; box on; grid on;
set(gca,'FontName','Times New Roman','FontSize',16);

p1  = cdfplot(abs(Angle_Error_OMP_Original(:,1,1)));
set(p1,'LineStyle','-', 'Color', 'r', 'LineWidth', 2) 

p2  = cdfplot(abs(Angle_Error_OMP_Original(:,1,2)));
set(p2,'LineStyle','-', 'Color', 'g', 'LineWidth', 2) 

p3  = cdfplot(abs(Angle_Error_OMP_Original(:,1,3)));
set(p3,'LineStyle','-', 'Color', 'b', 'LineWidth', 2)   

p4  = cdfplot(abs(Angle_Error_MUSIC_Original(:,1,3)));
set(p4,'LineStyle','-', 'Color', 'c', 'LineWidth', 2)  

p5  = cdfplot(abs(Angle_Error_OMP_Low(:,1,3)));
set(p5,'LineStyle','-', 'Color', 'm', 'LineWidth', 2) 

xlabel('Angle Error [deg]');
ylabel('CDF');
title('Different Number Radiation Pattern - Jammer')
ah1=axes('position',get(gca,'position'),'visible','off'); 
l1 = legend(ah1, [p1, p2, p3, p4, p5],...
    {'N_p=7,  OMP',...
     'N_p=9,  OMP', ...
     'N_p=11, OMP',...
     'N_p=11, MUSIC',...
     'N_p=11, OMP, Low'},...
    'Box','off', ...
    'Interpreter','tex');
l1.FontSize = 16;
l1.FontName = 'Times New Roman';

%% 1.2 Different HPBW
figure; hold on; box on; grid on;
set(gca,'FontName','Times New Roman','FontSize',16);

p1  = cdfplot(abs(Angle_Error_OMP_Original(:,1,3)));
set(p1,'LineStyle','-', 'Color', 'r', 'LineWidth', 2) 

p2  = cdfplot(abs(Angle_Error_OMP_Original(:,1,4)));
set(p2,'LineStyle','-', 'Color', 'g', 'LineWidth', 2) 

p3  = cdfplot(abs(Angle_Error_OMP_Original(:,1,5)));
set(p3,'LineStyle','-', 'Color', 'b', 'LineWidth', 2)   

p4  = cdfplot(abs(Angle_Error_OMP_Original(:,1,6)));
set(p4,'LineStyle','-', 'Color', 'c', 'LineWidth', 2) 

p5  = cdfplot(abs(Angle_Error_MUSIC_Original(:,1,3)));
set(p5,'LineStyle','-', 'Color', 'm', 'LineWidth', 2) 

p6  = cdfplot(abs(Angle_Error_OMP_Low(:,1,3)));
set(p6,'LineStyle','-', 'Color', 'k', 'LineWidth', 2) 

xlabel('Angle Error [deg]');
ylabel('CDF');
title('Different HPBW - Jammer')
ah1=axes('position',get(gca,'position'),'visible','off'); 
l1 = legend(ah1, [p1, p2, p3, p4, p5, p6],...
    {'HPBW=65, OMP',...
     'HPBW=45, OMP', ...
     'HPBW=25, OMP',...
     'HPBW=15, OMP',...
     'HPBW=65, MUSIC',...
     'HPBW=65, OMP, Low'},...
    'Box','off', ...
    'Interpreter','tex');
l1.FontSize = 16;
l1.FontName = 'Times New Roman';
%% 1.3
figure; hold on; box on; grid on;
set(gca,'FontName','Times New Roman','FontSize',16);

p1  = cdfplot(abs(Angle_Error_OMP_Original(:,1,3)));
set(p1,'LineStyle','-', 'Color', 'r', 'LineWidth', 2) 

p2  = cdfplot(abs(Angle_Error_OMP_Original(:,1,7)));
set(p2,'LineStyle','-', 'Color', 'g', 'LineWidth', 2) 

p3  = cdfplot(abs(Angle_Error_OMP_Original(:,1,8)));
set(p3,'LineStyle','-', 'Color', 'b', 'LineWidth', 2)   

p4  = cdfplot(abs(Angle_Error_OMP_Original(:,1,9)));
set(p4,'LineStyle','-', 'Color', 'c', 'LineWidth', 2) 

p5  = cdfplot(abs(Angle_Error_MUSIC_Original(:,1,3)));
set(p5,'LineStyle','-', 'Color', 'm', 'LineWidth', 2) 

p6  = cdfplot(abs(Angle_Error_OMP_Low(:,1,3)));
set(p6,'LineStyle','-', 'Color', 'k', 'LineWidth', 2) 

xlabel('Angle Error [deg]');
ylabel('CDF');
title('')
ah1=axes('position',get(gca,'position'),'visible','off'); 
l1 = legend(ah1, [p1, p2, p3, p4, p5, p6],...
    {'P_C=27 dBm, OMP',...
     'P_C=29 dBm, OMP', ...
     'P_C=31 dBm, OMP',...
     'P_C=33 dBm, OMP',...
     'P_C=27 dBm, MUSIC',...
     'P_C=27 dBm, OMP, Low'},...
    'Box','off', ...
    'Interpreter','tex');
l1.FontSize = 16;
l1.FontName = 'Times New Roman';
%% 2. Controler angle
%% 2.1 Different Radiation Pattern
set(0,'defaultfigurecolor','w') 
figure; hold on; box on; grid on;
set(gca,'FontName','Times New Roman','FontSize',16);

p1  = cdfplot(abs(Angle_Error_OMP_Original(:,2,1)));
set(p1,'LineStyle','-', 'Color', 'r', 'LineWidth', 2) 

p2  = cdfplot(abs(Angle_Error_OMP_Original(:,2,2)));
set(p2,'LineStyle','-', 'Color', 'g', 'LineWidth', 2) 

p3  = cdfplot(abs(Angle_Error_OMP_Original(:,2,3)));
set(p3,'LineStyle','-', 'Color', 'b', 'LineWidth', 2)   

p4  = cdfplot(abs(Angle_Error_MUSIC_Original(:,2,3)));
set(p4,'LineStyle','-', 'Color', 'c', 'LineWidth', 2)  

p5  = cdfplot(abs(Angle_Error_OMP_Low(:,2,3)));
set(p5,'LineStyle','-', 'Color', 'm', 'LineWidth', 2) 

xlabel('Angle Error [deg]');
ylabel('CDF');
title('Different Number Radiation Pattern - Controler')
ah1=axes('position',get(gca,'position'),'visible','off'); 
l1 = legend(ah1, [p1, p2, p3, p4, p5],...
    {'N_p=7,  OMP',...
     'N_p=9,  OMP', ...
     'N_p=11, OMP',...
     'N_p=11, MUSIC',...
     'N_p=11, OMP, Low'},...
    'Box','off', ...
    'Interpreter','tex');
l1.FontSize = 16;
l1.FontName = 'Times New Roman';



%% 2.2 Different HPBW
figure; hold on; box on; grid on;
set(gca,'FontName','Times New Roman','FontSize',16);

p1  = cdfplot(abs(Angle_Error_OMP_Original(:,2,3)));
set(p1,'LineStyle','-', 'Color', 'r', 'LineWidth', 2) 

p2  = cdfplot(abs(Angle_Error_OMP_Original(:,2,4)));
set(p2,'LineStyle','-', 'Color', 'g', 'LineWidth', 2) 

p3  = cdfplot(abs(Angle_Error_OMP_Original(:,2,5)));
set(p3,'LineStyle','-', 'Color', 'b', 'LineWidth', 2)   

p4  = cdfplot(abs(Angle_Error_OMP_Original(:,2,6)));
set(p4,'LineStyle','-', 'Color', 'c', 'LineWidth', 2) 

p5  = cdfplot(abs(Angle_Error_MUSIC_Original(:,2,3)));
set(p5,'LineStyle','-', 'Color', 'm', 'LineWidth', 2) 

p6  = cdfplot(abs(Angle_Error_OMP_Low(:,2,3)));
set(p6,'LineStyle','-', 'Color', 'k', 'LineWidth', 2) 

xlabel('Angle Error [deg]');
ylabel('CDF');
title('Different HPBW - Controler')
ah1=axes('position',get(gca,'position'),'visible','off'); 
l1 = legend(ah1, [p1, p2, p3, p4, p5, p6],...
    {'HPBW=65, OMP',...
     'HPBW=45, OMP', ...
     'HPBW=25, OMP',...
     'HPBW=15, OMP',...
     'HPBW=65, MUSIC',...
     'HPBW=65, OMP, Low'},...
    'Box','off', ...
    'Interpreter','tex');
l1.FontSize = 16;
l1.FontName = 'Times New Roman';

%% 2.3 Different Tx Power
figure; hold on; box on; grid on;
set(gca,'FontName','Times New Roman','FontSize',16);

p1  = cdfplot(abs(Angle_Error_OMP_Original(:,2,3)));
set(p1,'LineStyle','-', 'Color', 'r', 'LineWidth', 2) 

p2  = cdfplot(abs(Angle_Error_OMP_Original(:,2,7)));
set(p2,'LineStyle','-', 'Color', 'g', 'LineWidth', 2) 

p3  = cdfplot(abs(Angle_Error_OMP_Original(:,2,8)));
set(p3,'LineStyle','-', 'Color', 'b', 'LineWidth', 2)   

p4  = cdfplot(abs(Angle_Error_OMP_Original(:,2,9)));
set(p4,'LineStyle','-', 'Color', 'c', 'LineWidth', 2) 

p5  = cdfplot(abs(Angle_Error_MUSIC_Original(:,2,3)));
set(p5,'LineStyle','-', 'Color', 'm', 'LineWidth', 2) 

p6  = cdfplot(abs(Angle_Error_OMP_Low(:,2,3)));
set(p6,'LineStyle','-', 'Color', 'k', 'LineWidth', 2) 

xlabel('Angle Error [deg]');
ylabel('CDF');
title('')
ah1=axes('position',get(gca,'position'),'visible','off'); 
l1 = legend(ah1, [p1, p2, p3, p4, p5, p6],...
    {'P_C=27 dBm, OMP',...
     'P_C=29 dBm, OMP', ...
     'P_C=31 dBm, OMP',...
     'P_C=33 dBm, OMP',...
     'P_C=27 dBm, MUSIC',...
     'P_C=27 dBm, OMP, Low'},...
    'Box','off', ...
    'Interpreter','tex');
l1.FontSize = 16;
l1.FontName = 'Times New Roman';
