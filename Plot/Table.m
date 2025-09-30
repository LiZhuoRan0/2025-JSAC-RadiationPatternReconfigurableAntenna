clear
clc
N_it = 10000;
fprintf('Different Antenna Number\n\n')
%% 1. (LoS, 1, OMP, Original)
N_rx_azi = 1;
N_rx_ele = 1;
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
Angle_Error = load(SavePath).Angle_Error;
Jammer_Angle_Error = squeeze(Angle_Error(:,1,6));
Controler_Angle_Error = squeeze(Angle_Error(:,2,6));
SE_up = load(SavePath).SE_up;
SE_up = squeeze(SE_up(:,2,6));
SE_dn = load(SavePath).SE_dn;
SE_dn = squeeze(SE_dn(:,2,6));
fprintf('(LoS, 1, OMP, Original)\n')
fprintf('Jammer Angle,           mean = %4.1f, variance = %4.1f\n', mean(Jammer_Angle_Error), var(Jammer_Angle_Error))
fprintf('Controler Angle,        mean = %4.1f, variance = %4.1f\n', mean(Controler_Angle_Error), var(Controler_Angle_Error))
fprintf('Up Spectrum Efficiency, mean = %4.1f, variance = %4.1f\n', mean(SE_up), var(SE_up))
fprintf('Dn Spectrum Efficiency, mean = %4.1f, variance = %4.1f\n', mean(SE_dn), var(SE_dn))
fprintf('-----------------------------------------------------------------------------\n')
%% 2. (LoS, 2, OMP, Original)
N_rx_azi = 2;
N_rx_ele = 1;
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
Angle_Error = load(SavePath).Angle_Error;
Jammer_Angle_Error = squeeze(Angle_Error(:,1,6));
Controler_Angle_Error = squeeze(Angle_Error(:,2,6));
SE_up = load(SavePath).SE_up;
SE_up = squeeze(SE_up(:,2,6));
SE_dn = load(SavePath).SE_dn;
SE_dn = squeeze(SE_dn(:,2,6));
fprintf('(LoS, 2, OMP, Original)\n')
fprintf('Jammer Angle,           mean = %4.1f, variance = %4.1f\n', mean(Jammer_Angle_Error), var(Jammer_Angle_Error))
fprintf('Controler Angle,        mean = %4.1f, variance = %4.1f\n', mean(Controler_Angle_Error), var(Controler_Angle_Error))
fprintf('Up Spectrum Efficiency, mean = %4.1f, variance = %4.1f\n', mean(SE_up), var(SE_up))
fprintf('Dn Spectrum Efficiency, mean = %4.1f, variance = %4.1f\n', mean(SE_dn), var(SE_dn))
fprintf('-----------------------------------------------------------------------------\n')
%% 3. (LoS, 4, OMP, Original)
N_rx_azi = 2;
N_rx_ele = 2;
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
Angle_Error = load(SavePath).Angle_Error;
Jammer_Angle_Error = squeeze(Angle_Error(:,1,6));
Controler_Angle_Error = squeeze(Angle_Error(:,2,6));
SE_up = load(SavePath).SE_up;
SE_up = squeeze(SE_up(:,2,6));
SE_dn = load(SavePath).SE_dn;
SE_dn = squeeze(SE_dn(:,2,6));
fprintf('(LoS, 4, OMP, Original)\n')
fprintf('Jammer Angle,           mean = %4.1f, variance = %4.1f\n', mean(Jammer_Angle_Error), var(Jammer_Angle_Error))
fprintf('Controler Angle,        mean = %4.1f, variance = %4.1f\n', mean(Controler_Angle_Error), var(Controler_Angle_Error))
fprintf('Up Spectrum Efficiency, mean = %4.1f, variance = %4.1f\n', mean(SE_up), var(SE_up))
fprintf('Dn Spectrum Efficiency, mean = %4.1f, variance = %4.1f\n', mean(SE_dn), var(SE_dn))
fprintf('-----------------------------------------------------------------------------\n')
%% 4. (LoS, 4, MUSIC, Original)
fprintf('Different Algorithm\n\n')
N_rx_azi = 2;
N_rx_ele = 2;
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
Angle_Error = load(SavePath).Angle_Error;
Jammer_Angle_Error = squeeze(Angle_Error(:,1,6));
Controler_Angle_Error = squeeze(Angle_Error(:,2,6));
SE_up = load(SavePath).SE_up;
SE_up = squeeze(SE_up(:,2,6));
SE_dn = load(SavePath).SE_dn;
SE_dn = squeeze(SE_dn(:,2,6));
fprintf('(LoS, 1, MUSIC, Original)\n')
fprintf('Jammer Angle,           mean = %4.1f, variance = %4.1f\n', mean(Jammer_Angle_Error), var(Jammer_Angle_Error))
fprintf('Controler Angle,        mean = %4.1f, variance = %4.1f\n', mean(Controler_Angle_Error), var(Controler_Angle_Error))
fprintf('Up Spectrum Efficiency, mean = %4.1f, variance = %4.1f\n', mean(SE_up), var(SE_up))
fprintf('Dn Spectrum Efficiency, mean = %4.1f, variance = %4.1f\n', mean(SE_dn), var(SE_dn))
fprintf('-----------------------------------------------------------------------------\n')
%% 5. (NLoS, 1, OMP, Original)
fprintf('Different Channel\n\n')
N_rx_azi = 1;
N_rx_ele = 1;
OMP_MUSIC = 0;%0: OMP, 1: MUSIC
OMP_MUSIC_string = {'OMP', 'MUSIC'};
LoS_NLoS = 1; %0: LoS, 1: NLoS
LoS_NLoS_string = {'LoS', 'NLoS'};
Low = 1;      %0: Low, 1: Original
Low_string = {'Low', 'Original'};
SavePath = sprintf('../Data/Simu/%s_%s_%s_N_%d_Antenna_%d.mat', ...
           OMP_MUSIC_string{OMP_MUSIC+1},...
           LoS_NLoS_string{LoS_NLoS+1},...
           Low_string{Low+1},...
           N_it, N_rx_azi*N_rx_ele);
Angle_Error = load(SavePath).Angle_Error;
Jammer_Angle_Error = squeeze(Angle_Error(:,1,6));
Controler_Angle_Error = squeeze(Angle_Error(:,2,6));
SE_up = load(SavePath).SE_up;
SE_up = squeeze(SE_up(:,2,6));
SE_dn = load(SavePath).SE_dn;
SE_dn = squeeze(SE_dn(:,2,6));
fprintf('(NLoS, 1, OMP, Original)\n')
fprintf('Jammer Angle,           mean = %4.1f, variance = %4.1f\n', mean(Jammer_Angle_Error), var(Jammer_Angle_Error))
fprintf('Controler Angle,        mean = %4.1f, variance = %4.1f\n', mean(Controler_Angle_Error), var(Controler_Angle_Error))
fprintf('Up Spectrum Efficiency, mean = %4.1f, variance = %4.1f\n', mean(SE_up), var(SE_up))
fprintf('Dn Spectrum Efficiency, mean = %4.1f, variance = %4.1f\n', mean(SE_dn), var(SE_dn))
fprintf('-----------------------------------------------------------------------------\n')
%% 6. (NLoS, 2, OMP, Original)
N_rx_azi = 2;
N_rx_ele = 1;
OMP_MUSIC = 0;%0: OMP, 1: MUSIC
OMP_MUSIC_string = {'OMP', 'MUSIC'};
LoS_NLoS = 1; %0: LoS, 1: NLoS
LoS_NLoS_string = {'LoS', 'NLoS'};
Low = 1;      %0: Low, 1: Original
Low_string = {'Low', 'Original'};
SavePath = sprintf('../Data/Simu/%s_%s_%s_N_%d_Antenna_%d.mat', ...
           OMP_MUSIC_string{OMP_MUSIC+1},...
           LoS_NLoS_string{LoS_NLoS+1},...
           Low_string{Low+1},...
           N_it, N_rx_azi*N_rx_ele);
Angle_Error = load(SavePath).Angle_Error;
Jammer_Angle_Error = squeeze(Angle_Error(:,1,6));
Controler_Angle_Error = squeeze(Angle_Error(:,2,6));
SE_up = load(SavePath).SE_up;
SE_up = squeeze(SE_up(:,2,6));
SE_dn = load(SavePath).SE_dn;
SE_dn = squeeze(SE_dn(:,2,6));
fprintf('(NLoS, 2, OMP, Original)\n')
fprintf('Jammer Angle,           mean = %4.1f, variance = %4.1f\n', mean(Jammer_Angle_Error), var(Jammer_Angle_Error))
fprintf('Controler Angle,        mean = %4.1f, variance = %4.1f\n', mean(Controler_Angle_Error), var(Controler_Angle_Error))
fprintf('Up Spectrum Efficiency, mean = %4.1f, variance = %4.1f\n', mean(SE_up), var(SE_up))
fprintf('Dn Spectrum Efficiency, mean = %4.1f, variance = %4.1f\n', mean(SE_dn), var(SE_dn))
fprintf('-----------------------------------------------------------------------------\n')
%% 7. (NLoS, 4, OMP, Original)
fprintf('Low Save Overhead\n\n')
N_rx_azi = 2;
N_rx_ele = 2;
OMP_MUSIC = 0;%0: OMP, 1: MUSIC
OMP_MUSIC_string = {'OMP', 'MUSIC'};
LoS_NLoS = 1; %0: LoS, 1: NLoS
LoS_NLoS_string = {'LoS', 'NLoS'};
Low = 1;      %0: Low, 1: Original
Low_string = {'Low', 'Original'};
SavePath = sprintf('../Data/Simu/%s_%s_%s_N_%d_Antenna_%d.mat', ...
           OMP_MUSIC_string{OMP_MUSIC+1},...
           LoS_NLoS_string{LoS_NLoS+1},...
           Low_string{Low+1},...
           N_it, N_rx_azi*N_rx_ele);
Angle_Error = load(SavePath).Angle_Error;
Jammer_Angle_Error = squeeze(Angle_Error(:,1,6));
Controler_Angle_Error = squeeze(Angle_Error(:,2,6));
SE_up = load(SavePath).SE_up;
SE_up = squeeze(SE_up(:,2,6));
SE_dn = load(SavePath).SE_dn;
SE_dn = squeeze(SE_dn(:,2,6));
fprintf('(NLoS, 4, OMP, Original)\n')
fprintf('Jammer Angle,           mean = %4.1f, variance = %4.1f\n', mean(Jammer_Angle_Error), var(Jammer_Angle_Error))
fprintf('Controler Angle,        mean = %4.1f, variance = %4.1f\n', mean(Controler_Angle_Error), var(Controler_Angle_Error))
fprintf('Up Spectrum Efficiency, mean = %4.1f, variance = %4.1f\n', mean(SE_up), var(SE_up))
fprintf('Dn Spectrum Efficiency, mean = %4.1f, variance = %4.1f\n', mean(SE_dn), var(SE_dn))
fprintf('-----------------------------------------------------------------------------\n')
%% 8. (LoS, 1, OMP, Low)
N_rx_azi = 1;
N_rx_ele = 1;
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
Angle_Error = load(SavePath).Angle_Error;
Jammer_Angle_Error = squeeze(Angle_Error(:,1,6));
Controler_Angle_Error = squeeze(Angle_Error(:,2,6));
SE_up = load(SavePath).SE_up;
SE_up = squeeze(SE_up(:,2,6));
SE_dn = load(SavePath).SE_dn;
SE_dn = squeeze(SE_dn(:,2,6));
fprintf('(LoS, 1, OMP, Low)\n')
fprintf('Jammer Angle,           mean = %4.1f, variance = %4.1f\n', mean(Jammer_Angle_Error), var(Jammer_Angle_Error))
fprintf('Controler Angle,        mean = %4.1f, variance = %4.1f\n', mean(Controler_Angle_Error), var(Controler_Angle_Error))
fprintf('Up Spectrum Efficiency, mean = %4.1f, variance = %4.1f\n', mean(SE_up), var(SE_up))
fprintf('Dn Spectrum Efficiency, mean = %4.1f, variance = %4.1f\n', mean(SE_dn), var(SE_dn))
fprintf('-----------------------------------------------------------------------------\n')
%% 9. (LoS, 2, OMP, Low)
N_rx_azi = 2;
N_rx_ele = 1;
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
Angle_Error = load(SavePath).Angle_Error;
Jammer_Angle_Error = squeeze(Angle_Error(:,1,6));
Controler_Angle_Error = squeeze(Angle_Error(:,2,6));
SE_up = load(SavePath).SE_up;
SE_up = squeeze(SE_up(:,2,6));
SE_dn = load(SavePath).SE_dn;
SE_dn = squeeze(SE_dn(:,2,6));
fprintf('(LoS, 2, OMP, Low)\n')
fprintf('Jammer Angle,           mean = %4.1f, variance = %4.1f\n', mean(Jammer_Angle_Error), var(Jammer_Angle_Error))
fprintf('Controler Angle,        mean = %4.1f, variance = %4.1f\n', mean(Controler_Angle_Error), var(Controler_Angle_Error))
fprintf('Up Spectrum Efficiency, mean = %4.1f, variance = %4.1f\n', mean(SE_up), var(SE_up))
fprintf('Dn Spectrum Efficiency, mean = %4.1f, variance = %4.1f\n', mean(SE_dn), var(SE_dn))
fprintf('-----------------------------------------------------------------------------\n')
%% 10. (LoS, 4, OMP, Low)
N_rx_azi = 2;
N_rx_ele = 2;
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
Angle_Error = load(SavePath).Angle_Error;
Jammer_Angle_Error = squeeze(Angle_Error(:,1,6));
Controler_Angle_Error = squeeze(Angle_Error(:,2,6));
SE_up = load(SavePath).SE_up;
SE_up = squeeze(SE_up(:,2,6));
SE_dn = load(SavePath).SE_dn;
SE_dn = squeeze(SE_dn(:,2,6));
fprintf('(LoS, 4, OMP, Low)\n')
fprintf('Jammer Angle,           mean = %4.1f, variance = %4.1f\n', mean(Jammer_Angle_Error), var(Jammer_Angle_Error))
fprintf('Controler Angle,        mean = %4.1f, variance = %4.1f\n', mean(Controler_Angle_Error), var(Controler_Angle_Error))
fprintf('Up Spectrum Efficiency, mean = %4.1f, variance = %4.1f\n', mean(SE_up), var(SE_up))
fprintf('Dn Spectrum Efficiency, mean = %4.1f, variance = %4.1f\n', mean(SE_dn), var(SE_dn))
fprintf('-----------------------------------------------------------------------------\n')
%% 11. (LoS, 4, MUSIC, Low)
N_rx_azi = 2;
N_rx_ele = 2;
OMP_MUSIC = 1;%0: OMP, 1: MUSIC
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
Angle_Error = load(SavePath).Angle_Error;
Jammer_Angle_Error = squeeze(Angle_Error(:,1,6));
Controler_Angle_Error = squeeze(Angle_Error(:,2,6));
SE_up = load(SavePath).SE_up;
SE_up = squeeze(SE_up(:,2,6));
SE_dn = load(SavePath).SE_dn;
SE_dn = squeeze(SE_dn(:,2,6));
fprintf('(LoS, 4, MUSIC, Low)\n')
fprintf('Jammer Angle,           mean = %4.1f, variance = %4.1f\n', mean(Jammer_Angle_Error), var(Jammer_Angle_Error))
fprintf('Controler Angle,        mean = %4.1f, variance = %4.1f\n', mean(Controler_Angle_Error), var(Controler_Angle_Error))
fprintf('Up Spectrum Efficiency, mean = %4.1f, variance = %4.1f\n', mean(SE_up), var(SE_up))
fprintf('Dn Spectrum Efficiency, mean = %4.1f, variance = %4.1f\n', mean(SE_dn), var(SE_dn))
fprintf('-----------------------------------------------------------------------------\n')
%% 12. (NLoS, 4, OMP, Low)
N_rx_azi = 2;
N_rx_ele = 2;
OMP_MUSIC = 0;%0: OMP, 1: MUSIC
OMP_MUSIC_string = {'OMP', 'MUSIC'};
LoS_NLoS = 1; %0: LoS, 1: NLoS
LoS_NLoS_string = {'LoS', 'NLoS'};
Low = 0;      %0: Low, 1: Original
Low_string = {'Low', 'Original'};
SavePath = sprintf('../Data/Simu/%s_%s_%s_N_%d_Antenna_%d.mat', ...
           OMP_MUSIC_string{OMP_MUSIC+1},...
           LoS_NLoS_string{LoS_NLoS+1},...
           Low_string{Low+1},...
           N_it, N_rx_azi*N_rx_ele);
Angle_Error = load(SavePath).Angle_Error;
Jammer_Angle_Error = squeeze(Angle_Error(:,1,6));
Controler_Angle_Error = squeeze(Angle_Error(:,2,6));
SE_up = load(SavePath).SE_up;
SE_up = squeeze(SE_up(:,2,6));
SE_dn = load(SavePath).SE_dn;
SE_dn = squeeze(SE_dn(:,2,6));
fprintf('(NLoS, 4, OMP, Low)\n')
fprintf('Jammer Angle,           mean = %4.1f, variance = %4.1f\n', mean(Jammer_Angle_Error), var(Jammer_Angle_Error))
fprintf('Controler Angle,        mean = %4.1f, variance = %4.1f\n', mean(Controler_Angle_Error), var(Controler_Angle_Error))
fprintf('Up Spectrum Efficiency, mean = %4.1f, variance = %4.1f\n', mean(SE_up), var(SE_up))
fprintf('Dn Spectrum Efficiency, mean = %4.1f, variance = %4.1f\n', mean(SE_dn), var(SE_dn))
fprintf('-----------------------------------------------------------------------------\n')