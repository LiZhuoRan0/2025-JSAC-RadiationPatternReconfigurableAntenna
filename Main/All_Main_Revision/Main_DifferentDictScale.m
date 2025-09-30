clear
clc
rng(666)
addpath('..\..\Func\')
addpath('..\')

if isempty(gcp('nocreate'))   
    numWorkers = 10;      
    parpool('local', numWorkers);
end
%% 0. Preliminary 
DictScale = 0.5;
N_rx_azi = 1;
N_rx_ele = 1;

OMP_MUSIC = 0;%0: OMP, 1: MUSIC
OMP_MUSIC_string = {'OMP', 'MUSIC'};

LoS_NLoS = 0; %0: LoS, 1: NLoS
LoS_NLoS_string = {'LoS', 'NLoS'};

Low = 0;      %0: Low, 1: Original
Low_string = {'Low', 'Original'};

threshold = -30;
if OMP_MUSIC == 1 && LoS_NLoS == 1
    error('MUSIC cannot be utlized in NLoS cases!!!')
end
P_C_all  =  27 ;
HPBW_all =  [15 25 45 65];
N_all    =  [11 11 11 11];
P_J      =  50;
LenSituation = length(HPBW_all);
N_it = 10000;

Angle_Error   = zeros(N_it, 2, LenSituation);% 1 Jammer, 2 Controler
Ptn_Error     = zeros(N_it, LenSituation);
SE_up         = zeros(N_it, 3, LenSituation);% 1 Best, 2 Est, 3 Omini
SE_dn         = zeros(N_it, 3, LenSituation);


% 1. First, generate a 'scale' string with an underscore.
scale_str = strrep(num2str(DictScale, '%.1f'), '.', '_');
%    If DictScale = 0.5, scale_str will be '0_5'.
%    If DictScale = 1.0, scale_str will be '1_0' (you could also change the format to '%.0f' or remove the '_0' later).

% 2. Use %s instead of %d in sprintf.
SavePath = sprintf( ...
    '../../Data/Simu/Revision/AngleEst_Scale_%s_%s_%s_%s_N_%d_Antenna_%d.mat', ...
    scale_str, ...
    OMP_MUSIC_string{OMP_MUSIC+1}, ...
    LoS_NLoS_string{LoS_NLoS+1}, ...
    Low_string{Low+1}, ...
    N_it, N_rx_azi * N_rx_ele ...
);

for n_sit = 1:LenSituation
    P_C = 27;
    HPBW = HPBW_all(n_sit);
    N = N_all(n_sit);
    parfor n_it = 1:N_it
        fprintf('1st Loop = %2d/%2d, 2nd Loop = %5d/%5d\n', n_sit, LenSituation, n_it, N_it)

        Para = ParaClass_DifferentDictScale(P_C, P_J, HPBW, N, ...
               N_rx_ele, N_rx_azi, threshold, LoS_NLoS, Low, DictScale);
        
        %% 1. Sening of Controler
        Y_C2U = Gen_RcvSig(Para, 'Ctrler2UAV_sensing');
        if OMP_MUSIC == 0
            [Para.varphi_C_rx, Para.theta_C_rx, ...
             Para.gain_norm, Para.gain] = Est_CtrlerAngle_DifferentDictScale(Para, Y_C2U, DictScale);        

        %% 2. Sensing of Jammer
            Y_C2U = Reconstruct_Y_DifferentDictScale(Para, Y_C2U, DictScale);
            [Para.varphi_J, Para.theta_J] = Est_JammerAngle_DifferentDictScale(Para, Y_C2U, DictScale);
        else
            [Para.varphi_C_rx, Para.theta_C_rx, ...
                Para.varphi_J, Para.theta_J] = MUSIC(Para, Y_C2U);
        end
        
        %% 3. Choosing Radiation Pattern
        % if OMP_MUSIC == 0
        %     [Best_RadiationPattern, Sele_RadiationPattern, Best_Cmber, Sele_Cmber] = Gen_RadiationMode_Cmber_OMP_DifferentDictScale(Para);
        % else
        %     [Best_RadiationPattern, Sele_RadiationPattern, Best_Cmber, Sele_Cmber] = Gen_RadiationMode_Cmber_MUSIC_DifferentDictScale(Para);
        % end
        
        %% 4. Evaluate
        % Sensing Error
        Error_sensing = Eval_Sensing(Para);
        
        % Spectrum Efficiency
        % [SE_tmp_up, SE_tmp_dn] = Eval_SE(Para, Best_RadiationPattern, Sele_RadiationPattern, Best_Cmber, Sele_Cmber);

        %% 5. Save
        Angle_Error(n_it, :, n_sit) = Error_sensing.';
        % Ptn_Error(n_it, n_sit)      = Best_RadiationPattern == Sele_RadiationPattern;
        % SE_up(n_it, :, n_sit)       = SE_tmp_up.';
        % SE_dn(n_it, :, n_sit)       = SE_tmp_dn.';
    end
end    
save(SavePath, 'P_C_all',...
        'HPBW_all',...
        'N_all',...
        'Angle_Error')%,...
        % 'Ptn_Error',...
        % 'SE_up',...
        % 'SE_dn'...
        % )