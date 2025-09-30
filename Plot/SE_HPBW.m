N_it = 10000;
N_antenna = 4;
P_C_All = [27 29 31 33].';

OMP_MUSIC = 0;%0: OMP, 1: MUSIC
OMP_MUSIC_string = {'OMP', 'MUSIC'};
LoS_NLoS = 0; %0: LoS, 1: NLoS
LoS_NLoS_string = {'LoS', 'NLoS'};
Low = 1;      %0: Low, 1: Original
Low_string = {'Low', 'Original'};
SavePath = sprintf('../Data/Simu/HPBW_%s_%s_%s_N_%d_Antenna_%d.mat', ...
           OMP_MUSIC_string{OMP_MUSIC+1},...
           LoS_NLoS_string{LoS_NLoS+1},...
           Low_string{Low+1},...
           N_it, N_antenna);
SE_up_OMP_Original = load(SavePath).SE_up;

SE_up = zeros(4, 3);% P_C_All x HPBW
for i = 1:4
    for j = 1:3
        SE_up(i,j) = mean(squeeze(SE_up_OMP_Original(:, 2, 4*(j-1)+i)));
    end
end

OMP_MUSIC = 0;%0: OMP, 1: MUSIC
OMP_MUSIC_string = {'OMP', 'MUSIC'};
LoS_NLoS = 0; %0: LoS, 1: NLoS
LoS_NLoS_string = {'LoS', 'NLoS'};
Low = 0;      %0: Low, 1: Original
Low_string = {'Low', 'Original'};
SavePath = sprintf('../Data/Simu/HPBW_%s_%s_%s_N_%d_Antenna_%d.mat', ...
           OMP_MUSIC_string{OMP_MUSIC+1},...
           LoS_NLoS_string{LoS_NLoS+1},...
           Low_string{Low+1},...
           N_it, N_antenna);
SE_up_OMP_Low = load(SavePath).SE_up;

SE_up_Low = zeros(4, 3);% P_C_All x HPBW
for i = 1:4
    for j = 1:3
        SE_up_Low(i,j) = mean(squeeze(SE_up_OMP_Low(:, 2, 4*(j-1)+i)));
    end
end

set(0,'defaultfigurecolor','w')
figure; hold on; box on; grid on;
set(gca,'FontName','Times New Roman','FontSize',16);

p1  = plot(P_C_All, SE_up(:,1));
set(p1, 'Marker', 's','LineStyle','-', 'Color', 'r', 'LineWidth', 2, 'MarkerSize', 10) 

p2  = plot(P_C_All, SE_up(:,2));
set(p2, 'Marker', 's','LineStyle','-', 'Color', 'g', 'LineWidth', 2, 'MarkerSize', 10) 

p3  = plot(P_C_All, SE_up(:,3));
set(p3, 'Marker', 's','LineStyle','-', 'Color', 'b', 'LineWidth', 2, 'MarkerSize', 10)   

p4  = plot(P_C_All, SE_up_Low(:,1));
set(p4, 'Marker', '+','LineStyle','-', 'Color', 'r', 'LineWidth', 2, 'MarkerSize', 10) 

p5  = plot(P_C_All, SE_up_Low(:,2));
set(p5, 'Marker', '+','LineStyle','-', 'Color', 'g', 'LineWidth', 2, 'MarkerSize', 10) 

p6  = plot(P_C_All, SE_up_Low(:,3));
set(p6, 'Marker', '+','LineStyle','-', 'Color', 'b', 'LineWidth', 2, 'MarkerSize', 10)  

xlabel('Transmit Power [dBm]');
ylabel('SE (bit/s/Hz)');
title('HPBW')
ah1=axes('position',get(gca,'position'),'visible','off'); 
l1 = legend(ah1, [p1, p2, p3, p4, p5, p6],...
    {'HPBW=65',...
     'HPBW=45', ...
     'HPBW=25',...
     'HPBW=65, Low',...
     'HPBW=45, Low', ...
     'HPBW=25, Low'},...
    'Box','off', ...
    'Interpreter','tex', ...
    'NumColumns', 2);
l1.FontSize = 16;
l1.FontName = 'Times New Roman';

